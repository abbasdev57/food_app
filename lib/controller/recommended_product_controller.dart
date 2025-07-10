import 'package:get/get.dart';
import '../backendhelper/data/repo/recommended_product_repo.dart';
import '../modal/popular_product_modal.dart';

class RecommendedProductController extends GetxController {
//instance of repo

  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];

  //getter for popularProductList

  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
//statuscode = 200 equals to server response is successful

    if (response.statusCode == 200) {
      _recommendedProductList = [];
      print("con");
      print(response.body);
      print("response.body");

//modal work
      _recommendedProductList.addAll(Product
          .fromJson(response.body)
          .products);

      _isLoaded = true;

// update the list everytime?
      update();
    } else {
      print("Error in recommended controller");
    }
  }
}
