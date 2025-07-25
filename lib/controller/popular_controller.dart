import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repo/popular_product_repo.dart';
import '../modal/cart_model.dart';
import '../modal/popular_product_modal.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  //instance of repo

  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  late CartController _cart;

  List<ProductModel> _popularProductList = [];

  //getter for popularProductList
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get getQuantity => _quantity;

  int _inCartItems = 0;

  int get getInCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductsList();
    //statuscode = 200 equals to server response is successful

    if (response.statusCode == 200) {
      _popularProductList = [];
      print("getting products List");
      // print(response.body);
      // print("response.body");

      //modal work
      _popularProductList.addAll(Product.fromJson(response.body).products);

      _isLoaded = true;

      // update the list everytime?
      /// = setState((){});
      update();
    } else {
      print("Error in controller");
    }
  }

  //set Quantity

  void setQuantity(bool increment) {
    debugPrint("Setting quantity");
    if (increment) {
      _quantity = checkQuantity(_quantity + 1);
      debugPrint("+ quantity$_quantity");
    } else {
      _quantity = checkQuantity(_quantity - 1);
      debugPrint("- quantity$_quantity");
    }
    update();
  }

  // to limit the quantity

  int checkQuantity(int q) {
    debugPrint("Checking quantity");
    if ((_inCartItems + q) < 0) {
      //appear on top
      Get.snackbar(
        "Item",
        "Quantity cannot be reduced more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        debugPrint("in cart items $_inCartItems inside check quantity");
        _quantity = -_inCartItems;
        return _quantity;
      }

      return 0;
    } else if ((_inCartItems + q) > 20) {
      Get.snackbar(
        "Item",
        "Quantity cannot be reduced more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return q;
    }
  }

  // refresh everytime

  initProduct(ProductModel productsModal, CartController controller) {
    debugPrint("Init Product");

    _quantity = 0;
    _inCartItems = 0;
    _cart = controller;
    //if exist
    var exists = false;
    exists = _cart.existInCart(productsModal);

    if (exists) {
      _inCartItems = _cart.getQuantity(productsModal);

      debugPrint("exist in cart$exists quantity$_inCartItems");
    }
    //get from Storage

    // cart items=3
  }

  void addItemTOCart(ProductModel product) {
    debugPrint("adding item to cart");

    ///call to the cart controller method
    _cart.addItemToController(product, _quantity);
    // reset the quantity because the item has been added to the cart successfully and we don't want to add the same quantity again
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.getCartItems.forEach((key, itemValue) {
      debugPrint(
        "id ${itemValue.id!}  quantity ${itemValue.quantity!} isExist ${itemValue.isExist!}",
      );
    });
    update();
  }

  int get totalItems {
    return _cart.getTotalItems;

    // var totalQuantity = 0;
    // _cart.getCartItems.forEach((key, value) {
    //   totalQuantity += value.quantity!;
    // });
    // return totalQuantity;
  }

  List<CartModal> get getItems {
    return _cart.getItems;
  }
}
