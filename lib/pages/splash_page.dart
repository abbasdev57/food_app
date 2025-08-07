import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../controller/popular_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../utils/app_routes.dart';

/// SplashPage is the initial screen shown to the user.
/// It plays an animation, loads necessary resources (like products),
/// and then navigates to the home/initial route.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  // Animation controller and animation for scaling the logo
  late AnimationController controller;
  late Animation<double> animation;

  // Flag to control when to show loading indicator
  bool _isLoading = true;

  // Flag to ensure resources are only loaded once
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller and animation
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..forward(); // Starts animation

    animation = CurvedAnimation(parent: controller, curve: Curves.ease);

    // Start a timer to navigate after a few seconds (independent of loading)
    Timer(
      const Duration(seconds: 4),
          () => Get.offNamed(AppRoutes.getInitial()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load resources only once when dependencies are available
    if (!_isLoaded) {
      _loadResources();
      _isLoaded = true;
    }
  }

  /// Loads product data and initializes the CartController.
  /// Once data is loaded, the loading indicator is removed.
  Future<void> _loadResources() async {
    try {
      // Fetch data from controllers using GetX
      await Get.find<PopularProductController>().getPopularProductList();
      await Get.find<RecommendedProductController>().getRecommendedProductList();
      await Get.find<CartController>();

      // Stop showing the loader
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading resources: $e');
    }
  }

  @override
  void dispose() {
    // Clean up the animation controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The UI of the splash screen
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Animated app icon/logo
            ScaleTransition(
              scale: animation,
              child: Image.asset(
                'assets/images/icon.png',
                height: 200.h,
                width: 200.w,
              ),
            ),

            SizedBox(height: 20.h),

            /// Fading title
            FadeTransition(
              opacity: animation,
              child: const Text(
                'Splash Screen',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 40.h),

            /// Loading spinner while data is being fetched
            if (_isLoading)
              const CircularProgressIndicator(), // Add style if needed
          ],
        ),
      ),
    );
  }
}
