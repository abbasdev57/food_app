// Initializes backend helpers, repositories, and controllers for the app
// using GetX dependency injection.

import 'package:flutter/material.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Controllers
import '../../../controller/popular_controller.dart';
import '../../../controller/recommended_product_controller.dart';
import '../../controller/cart_controller.dart';

// Data Layer
import '../data/api_client.dart';
import '../data/repo/cart_repo.dart';
import '../data/repo/popular_product_repo.dart';
import '../data/repo/recommended_product_repo.dart';

Future<void> init() async {
  // 1️⃣ Local storage instance (used for things like tokens, cart history)
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => prefs); // Register it with GetX's service locator

  // 2️⃣ API Client (handles HTTP requests to your backend)
  Get.lazyPut(() => ApiClient(baseUrl: AppConstants.BASE_URL));

  // 3️⃣ Repositories (bridge between controllers and data sources)
  // Popular & Recommended products fetch data from the API
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  // Cart repo stores cart data locally using SharedPreferences
  debugPrint("before CartRepo");
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // 4️⃣ Controllers (hold app logic/state and call repos for data)
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));

  debugPrint("before CartController");
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

  // 5️⃣ Confirmation log
  print('✅ Dependencies initialized successfully!');
}
