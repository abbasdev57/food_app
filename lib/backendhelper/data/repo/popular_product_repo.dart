import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../api_client.dart';

class PopularProductRepo extends GetxService {
  // This class is responsible for fetching popular products from the backend.
  // It can be extended to include methods for fetching, updating, or deleting
  // popular products as needed.

  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  // Example method to fetch popular products
  // Future<List<String>> fetchPopularProducts() async {
  //   // Simulate a network call
  //   await Future.delayed(Duration(seconds: 2));
  //   return ['Product A', 'Product B', 'Product C'];
  // }


  Future<Response> getPopularProductsList() async {
    print('Fetching popular products from the repository...');
    var serverUrl = AppConstants.POPULAR_PRODUCT_URL;
    return await apiClient.getData(serverUrl);
  }
}
