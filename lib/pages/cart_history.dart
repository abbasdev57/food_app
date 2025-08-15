import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/modal/cart_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/app_routes.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/no_data_page.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

    var getCartHistoryList = Get.find<CartController>().getCartHistory.reversed
        .toList();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time!)) {
        cartItemsPerOrder.update(
          getCartHistoryList[i].time!,
          (value) => value + 1,
        );
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<String> orderTime = cartOrderTimeToList();
    List<int> itemsPerOrder = cartItemsPerOrderToList();

    debugPrint("cartHistory = $getCartHistoryList");
    debugPrint("orderTime = $itemsPerOrder");

    var listCounter = 0;

    for (int i = 0; i < cartItemsPerOrder.length; i++) {
      for (int j = 0; j < itemsPerOrder[i]; j++) {
        debugPrint(
          "cartHistory[saveCounter] = ${getCartHistoryList[listCounter]}",
        );
        debugPrint("orderTime[i] = ${itemsPerOrder[i]}");

        // cartHistory[saveCounter].quantity = orderTime[i];
        // saveCounter++;
      }
    }
    // time Widget
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
     if(index<getCartHistoryList.length){
       DateTime parseDate =
       DateFormat(
         "yyyy-MM-dd HH:mm:ss",
       ).parse(
         getCartHistoryList[listCounter]
             .time!,
       );
       var inputDate = DateTime.parse(
         parseDate.toString(),
       );
       var outputFormat = DateFormat(
         "MM/dd/yyyy hh:mm a",
       );
       var outputDate = outputFormat.format(
         inputDate,
       );
     }
      return BigText(text: outputDate);
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

          /// list of cart history
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.isNotEmpty
                  ? NoDataPage(text: "You did not buy anything")
                  : Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 10.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < cartItemsPerOrder.length; i++)
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),

                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(itemsPerOrder[i], (
                                              index,
                                            ) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }

                                              return index <= 2
                                                  ? Container(
                                                      height: 80.h,
                                                      width: 80.w,
                                                      margin: EdgeInsets.only(
                                                        right: 6.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8.r,
                                                            ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD +
                                                                getCartHistoryList[listCounter -
                                                                        1]
                                                                    .img!,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            }),
                                          ),
                                          Container(
                                            height: 80.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text:
                                                      "${itemsPerOrder[i]} items",
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print(
                                                      "One More clicked" +
                                                          orderTime[i]
                                                              .toString(),
                                                    );
                                                    Map<int, CartModal>
                                                    moreOrder = {};
                                                    for (
                                                      int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++
                                                    ) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModal.fromJson(
                                                            jsonDecode(
                                                              jsonEncode(
                                                                getCartHistoryList[j],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                            .setCartItems =
                                                        moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(
                                                      AppRoutes.getCartPage(),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 10.w,
                                                          vertical: 5.h,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5.r,
                                                          ),
                                                      border: Border.all(
                                                        width: 2.w,
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                    ),
                                                    child: SmallText(
                                                      text: "One More",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
