//Tasks By hour  1App bar + Custom Widgets
//2PageView.builder  items + sizing + Animations(Transform ) + Box Shadow
// 3dots indicator + dimensions
//4 list view builder,detail screen, expandable text
// 4.30 recommended food detail screen

// 3.19 popular food detail screen 2
//  4.29 recommended food detail screen 3
// 5.4 app dependencies + getx controller and api client explianations
// 5.16 backend helper + dependencies + repo + controller
// 6.10 json nesting explain with model

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/utils/app_routes.dart';
import 'package:get/get.dart';
import 'controller/popular_controller.dart';
import 'controller/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'pages/home/main_page.dart';

// Future<void> main() async {
void main() async {
  debugPrint('Starting the application...');
  WidgetsFlutterBinding.ensureInitialized();

  // inititalize dependencies

  await dep.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // using media query to get the screen size
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    // print("Screen Width: $screenWidth");
    // print("Screen Height: $screenHeight");
    //Todo  this method will fetch the data from the server

    Get.find<CartController>().getCartData();

    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return ScreenUtilInit(
      // designSize: ScreenUtil.defaultSize
      //   designSize: Size(screenWidth, screenHeight),
      designSize: Size(411, 914),
      builder: (context, child) {
        return GetBuilder<PopularProductController>(
          builder: (_) {
            return GetBuilder<RecommendedProductController>(
              builder: (_) {
                return GetBuilder<CartController>(
                  builder: (_) {
                    return GetMaterialApp(
                      initialRoute: AppRoutes.getSplashPage(),
                      getPages: AppRoutes.routes,
                      title: 'Food Delivery App',
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

  @override
  void dispose() {
    super.dispose();
  }
}
