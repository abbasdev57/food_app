import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../utils/colors.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({super.key});

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> cartItemsPerOrder = {};

    var cartHistory = Get.find<CartController>().getCartHistory;

    for (int i = 0; i < cartHistory.length; i++) {
      if (cartItemsPerOrder.containsKey(cartHistory[i].time!)) {
        cartItemsPerOrder.update(cartHistory[i].time!, (value) => value + 1);
      } else {
        cartItemsPerOrder.putIfAbsent(cartHistory[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
      return cartItemsPerOrder.values.toList();
    }

    List<int> orderTime = cartOrderTimeToList();
    debugPrint("cartHistory = $cartHistory");
    debugPrint("orderTime = $orderTime");

    var saveCounter = 0;

    for (int i = 0; i < cartItemsPerOrder.length; i++) {
      for (int j = 0; j < orderTime[i]; j++) {
        debugPrint("cartHistory[saveCounter] = ${cartHistory[saveCounter]}");
        debugPrint("orderTime[i] = ${orderTime[i]}");

        // cartHistory[saveCounter].quantity = orderTime[i];
        // saveCounter++;
      }
    }

    return Scaffold(
      body: Column(
        children: [
          //appbar
          Container(
            padding: EdgeInsets.only(top: 25.h),
            height: 100.h,
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Cart History",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,

                    child: Icon(
                      Icons.add_shopping_cart,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
