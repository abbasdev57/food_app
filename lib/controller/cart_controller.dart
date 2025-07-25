import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repo/cart_repo.dart';
import '../modal/cart_model.dart';
import '../modal/popular_product_modal.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  ///cart value

  //we will get the value in a modal because we get a lot of information not just a cart value
// inside application we will use this modal to get the value of the cart,  storage the value of the cart
  Map<int, CartModal> items = {};

  List<CartModal> storedCart = [];

  //getter for cart value
  Map<int, CartModal> get getCartItems => items;

  void addItemToController(ProductModel product, int quantity) {
    debugPrint("adding item to controller called");
    var totalQuantity = 0;
    debugPrint("");

    /// if the item is already in the cart then update the quantity of the item
    if (items.containsKey(product.id!)) {
      items.update(product.id!, (existingItem) {
        totalQuantity = existingItem.quantity! + quantity;

        debugPrint("Update item to the cart ${product.id!} q =  $quantity");
        debugPrint("totalQuantity = $totalQuantity");

        return CartModal(
          id: existingItem.id,
          name: existingItem.name,
          img: existingItem.img,
          price: existingItem.price,
          // update the quantity of the existing item by adding the new quantity to the old quantity of the existing item
          quantity: existingItem.quantity! + quantity,
          time: DateTime.now().toString(),
          isExist: true,
          product: existingItem.product,
        );
      });
      if (totalQuantity <= 0) {
        items.remove(product.id!);
      }
    }

    /// else add the item to the cart if the item is not in the cart
    else {
      /// if the quantity is greater than 0 then add the item to the cart
      if (quantity > 0) {
        items.putIfAbsent(product.id!, () {
          debugPrint("Add item to the cart" +
              product.id!.toString() +
              'q = ' +
              quantity.toString());
          items.forEach((key, value) {
            debugPrint("key = ${key}value = $value");
          });
          return CartModal(
              id: product.id,
              name: product.name,
              price: product.price!.toInt(),
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product);
        });
      }

      /// if the quantity is less than 0 then show a snackbar and did not add -ve value

      else {
        Get.snackbar("Item", "Quantity cannot be reduced more",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }


    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    debugPrint("checking in cart");
    if (items.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    debugPrint("getting quantity");
    var quantity = 0;
    if (items.containsKey(product.id!)) {
      items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
      // return items[product.id!]!.quantity;
    }
    return quantity;
  }

  int get getTotalItems {
    var totalQuantity = 0;
    items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModal> get getItems {
    return items.entries.map((e) => e.value).toList();
  }

  int get totalAmount{
    var totalAmount = 0;
    items.forEach((key, value) {
      totalAmount += value.quantity! * value.price!;
    });
    return totalAmount;
  }



  List<CartModal> getCartData() {
    setCart = cartRepo.getCartList();
    debugPrint("getCartData called");
    return storedCart;
  }

  set setCart(List<CartModal> item){
    storedCart = item;
    debugPrint("length, ${storedCart.length}  storedCart = $storedCart");

    for(int i=0;i<storedCart.length;i++){
      items.putIfAbsent(storedCart[i].product!.id!, () => storedCart[i]);
      // addItemToController(storedCart[i].product!, storedCart[i].quantity!);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistory();
    clearCart();
  }

  void clearCart(){
    items = {};
    // items.clear();
    // cartRepo.addToCartList(getItems);
    update();
  }

  List<CartModal> get getCartHistory{
    return cartRepo.getCartHistory();
  }

}
