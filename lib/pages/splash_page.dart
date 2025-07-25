import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../controller/popular_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../utils/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    //Todo  this method will fetch the data from the server
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>();
    print('Screen Width: ${MediaQuery.of(context).size.width}');
    print('Screen Height: ${MediaQuery.of(context).size.height}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    )..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    _loadResources();

    //Todo:  no effect of _loadResources() on the splash screen and the error of
    // Typically references to inherited widgets should occur in widget build() methods. Alternatively, initialization based on inherited widgets can be placed in the didChangeDependencies method, which is called after initState and whenever the dependencies change thereafter.

    Timer(
      const Duration(seconds: 4),
      () => Get.offNamed(AppRoutes.getInitial()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/images/icon.png',
                height: 200.h,
                width: 200.w,
              ),
            ),
          ),

          FadeTransition(
            opacity: animation,
            child: const Text(
              'Splash Screen',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
