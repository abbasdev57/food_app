import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/utils/app_routes.dart';
import 'package:get/get.dart';
import 'controller/popular_controller.dart';
import 'controller/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'pages/home/main_page.dart';

/// The main entry point of the Flutter application.
void main() async {
  debugPrint('Starting the application...');

  /// Ensures Flutter engine is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize all necessary dependencies like controllers, services, etc.
  await dep.init();

  /// Run the main app widget.
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// The state of the root widget that sets up screen size, routes, and controllers.
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Pre-fetching cart, popular and recommended product data from backend.
    Get.find<CartController>().getCartData();
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();

    return ScreenUtilInit(
      /// Sets the design size for responsive UI scaling (based on your Figma design).
      designSize: Size(411, 914),
      builder: (context, child) {
        /// Nesting GetBuilder widgets to rebuild UI when respective controllers change.
        return GetBuilder<PopularProductController>(
          builder: (_) {
            return GetBuilder<RecommendedProductController>(
              builder: (_) {
                return GetBuilder<CartController>(
                  builder: (_) {
                    /// Root MaterialApp using GetX for routing and state management.
                    return GetMaterialApp(
                      title: 'Food Delivery App',
                      initialRoute: AppRoutes.getSplashPage(),
                      getPages: AppRoutes.routes,
                      // Uncomment below if you want to skip splash screen
                      // home: const MainPage(),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  /// Clean up resources (if any) when the widget is removed from the widget tree.
  @override
  void dispose() {
    super.dispose();
  }
}