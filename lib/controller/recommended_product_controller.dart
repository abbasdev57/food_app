import 'package:get/get.dart';
import '../data/repo/recommended_product_repo.dart';
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
    try {
      Response response = await recommendedProductRepo.getRecommendedUrl();

      if (response.statusCode == 200) {
        _recommendedProductList = [];
        var parsed = Product.fromJson(response.body);
        print("Parsed ${parsed.products.length} recommended products");

        //modal work
        _recommendedProductList.addAll(parsed.products);

        _isLoaded = true;

        // update the list everytime?
        update();
      } else {
        print("❌ Error: status code = ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception: ${e.toString()}");
    }
  }
}
