import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  // This class is responsible for making API calls to the backend.
  // It can be extended to include methods for fetching, updating, or deleting
  // data as needed.

  // token refreshes everytime
  late String token;

  final String baseUrl;

  late Map<String,String> _mainHeaders;

  ApiClient({required this.baseUrl}) {
    // httpClient.baseUrl = baseUrl;
    baseUrl = baseUrl;
    token = AppConstants.TOKEN;
    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  //  method to fetch data from an endpoint or API from the backend
  Future<Response> getData(String endpoint) async {
    try{
      Response response =await get(endpoint);
      return response;
    }
    catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  // Example method to post data to an endpoint
  // Future<Response> postData(String endpoint, dynamic data) async {
  //   return await post(endpoint, data);
  // }
}