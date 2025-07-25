// iniitializes dependencies for the backend helper

import 'package:flutter/material.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/popular_controller.dart';
import '../../../controller/recommended_product_controller.dart';
import '../../controller/cart_controller.dart';
import '../data/api_client.dart';
import '../data/repo/cart_repo.dart';
import '../data/repo/popular_product_repo.dart';
import '../data/repo/recommended_product_repo.dart';

Future<void> init() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Get.lazyPut(() => prefs);
  // Initialize the ApiClient with the base URL
  Get.lazyPut(() => ApiClient(baseUrl: AppConstants.BASE_URL));

  // Initialize the PopularProductRepo with the ApiClient
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  debugPrint("before CArt repo");
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //   controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
    () => RecommendedProductController(recommendedProductRepo: Get.find()),
  );
  debugPrint("before CArt controller");
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

  print('Dependencies initialized successfully!');
}
