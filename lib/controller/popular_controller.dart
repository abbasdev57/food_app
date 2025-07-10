import 'package:food_app/backendhelper/data/repo/popular_product_repo.dart';
import 'package:food_app/modal/popular_product_modal.dart';
import 'package:get/get.dart';


class PopularProductController extends GetxController {
  // This controller is used to manage the state of popular products and to handle the logic related to them.

  final PopularProductRepo popularProductRepo;
  
  PopularProductController({required this.popularProductRepo});
  
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  
  // Method to fetch popular products from the repository
Future<void> getPopularProductList() async {
  Response response = await popularProductRepo.getPopularProductsList();

  if(response.statusCode == 200){
    _popularProductList = [];
        print("inside get popular product list");
    
    _popularProductList.addAll(Product.fromJson(response.body).products);
    _isLoaded = true;

  //   update the list and used for getx
    update();
  }
  else{
    print('Error in Controller');
  }
}
  
  
  // List of popular product IDs
  // List<int> _popularProductIds = [];
  //
  // // Getter for popular product IDs
  // List<int> get popularProductIds => _popularProductIds;
  //
  // // Method to add a product ID to the list
  // void addProductId(int id) {
  //   if (!_popularProductIds.contains(id)) {
  //     _popularProductIds.add(id);
  //     update(); // Notify listeners about the change
  //   }
  // }
  //
  // // Method to remove a product ID from the list
  // void removeProductId(int id) {
  //   _popularProductIds.remove(id);
  //   update(); // Notify listeners about the change
  // }
}