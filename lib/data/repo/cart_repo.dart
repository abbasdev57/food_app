import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../modal/cart_model.dart';
import '../../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  ///adding the cart list to the shared preferences
  void addToCartList(List<CartModal> cartList) {
    debugPrint("addToCartList called");

    // sharedPreferences.remove(AppConstants.cartKey);
    // sharedPreferences.remove(AppConstants.cartHistoryKey);
    cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    debugPrint("cartList = $cartList");
    sharedPreferences.setStringList(AppConstants.cartKey, cart);
    debugPrint(
      sharedPreferences.getStringList(AppConstants.cartKey)!.toString(),
    );

    getCartList();
  }

  ///getting the cart list from the shared preferences
  List<CartModal> getCartList() {
    debugPrint("getCartList called");
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.cartKey)) {
      carts = sharedPreferences.getStringList(AppConstants.cartKey)!;
      debugPrint("carts = $carts");
    }
    List<CartModal> cartList = [];

    carts.forEach((element) {
      debugPrint("element = $element");
      cartList.add(CartModal.fromJson(jsonDecode(element)));
    });

    debugPrint("cartList = $cartList");
    return cartList;
  }

  /// adding the cart to the cart history in the shared preferences
  void addToCartHistory() {
    debugPrint("addToCartHistory called");

    if (sharedPreferences.containsKey(AppConstants.cartHistoryKey)) {
      cartHistory = sharedPreferences.getStringList(
        AppConstants.cartHistoryKey,
      )!;
    }

    for (int i = 0; i < cart.length; i++) {
      debugPrint("cart[i] = ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCart();
    debugPrint("cartHistory = $cartHistory");
    sharedPreferences.setStringList(AppConstants.cartHistoryKey, cartHistory);

    debugPrint(
      "length of cart History is: ${sharedPreferences.getStringList(AppConstants.cartHistoryKey)!.length}",
    );
    debugPrint(
      "length of cart History is: ${getCartHistory().length.toString()}",
    );
  }

  /// removing the cart from the shared preferences
  void removeCart() {
    debugPrint("removeCart called");
    sharedPreferences.remove(AppConstants.cartKey);
  }

  /// getting the cart history from the shared preferences
  List<CartModal> getCartHistory() {
    debugPrint("getCartHistory called");
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.cartHistoryKey)) {
      carts = sharedPreferences.getStringList(AppConstants.cartHistoryKey)!;
      // debugPrint("carts = $carts");
    }
    List<CartModal> cartList = [];

    carts.forEach((element) {
      // debugPrint("element = $element");
      cartList.add(CartModal.fromJson(jsonDecode(element)));
    });

    // debugPrint("cartList = ${cartList}");
    return cartList;
  }

  mnp() {}
}
