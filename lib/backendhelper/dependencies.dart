// iniitializes dependencies for the backend helper
import 'package:food_app/backendhelper/data/api_client.dart';
import 'package:food_app/backendhelper/data/repo/popular_product_repo.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../controller/popular_controller.dart';
import '../controller/recommended_product_controller.dart';
import 'data/repo/recommended_product_repo.dart';

Future<void> init() async {
  // Initialize the ApiClient with the base URL
  Get.lazyPut(() => ApiClient(baseUrl: AppConstants.BASE_URL));

  // Initialize the PopularProductRepo with the ApiClient
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  //   controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
    () => RecommendedProductController(recommendedProductRepo: Get.find()),
  );
  print('Dependencies initialized successfully!');
}
