import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../api_client.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  //contstructor

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    //
    var serverUrl = AppConstants.RECOMMENDED_PRODUCT_URL;
    return await apiClient.getData(serverUrl);
  }
}
