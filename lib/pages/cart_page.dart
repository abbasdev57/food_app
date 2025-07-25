import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../controller/popular_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../utils/app_constants.dart';
import '../utils/app_routes.dart';
import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/detail_icon.dart';
import '../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 45.w,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: DetailIcon(
                    icon: Icons.arrow_back_ios,
                    bgColor: AppColors.mainColor,
                    // size: 40.w,
                    iconColor: Colors.white,
                  ),
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.getInitial());
                  },
                  child: DetailIcon(
                    icon: Icons.home,
                    bgColor: AppColors.mainColor,
                    // size: 40.w,
                    iconColor: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  child: DetailIcon(
                    icon: Icons.shopping_cart,
                    bgColor: AppColors.mainColor,
                    // size: 40.w,
                    iconColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100.h,
            left: 10.w,
            right: 10.w,
            bottom: 0,
            child: Container(
              // color: Colors.grey,
              // margin: EdgeInsets.only(top: 10.h),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    var cartList = controller.getItems;
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.all(10.w),
                          height: 100.h,
                          width: 200,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularProductIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexWhere(
                                            (element) =>
                                                element.id ==
                                                cartList[index].product!.id,
                                          );
                                  var popularProductIndex2 =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(cartList[index].product!);
                                  debugPrint("Index");
                                  debugPrint(popularProductIndex.toString());
                                  debugPrint(popularProductIndex2.toString());

                                  if (popularProductIndex2 >= 0) {
                                    Get.toNamed(
                                      AppRoutes.getPopularFood(
                                        popularProductIndex2,
                                      ),
                                    );
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(cartList[index].product!);
                                    debugPrint("else $recommendedIndex");

                                    Get.toNamed(
                                      AppRoutes.getRecommendedFood(
                                        recommendedIndex,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 120.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(20.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.BASE_URL +
                                            AppConstants.UPLOAD +
                                            cartList[index].img!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Container(
                                  height: 100.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: cartList[index].name!,
                                        color: Colors.black,
                                      ),
                                      SmallText(text: ""),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text: cartList[index].price!
                                                .toString(),
                                            color: Colors.redAccent,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .addItemToController(
                                                          cartList[index]
                                                              .product!,
                                                          -1,
                                                        );
                                                    // productController
                                                    //     .setQuantity(false);
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.signColor,
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                BigText(
                                                  text: cartList[index]
                                                      .quantity!
                                                      .toString(),
                                                ),
                                                SizedBox(width: 10.w),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .addItemToController(
                                                          cartList[index]
                                                              .product!,
                                                          1,
                                                        );
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: AppColors.signColor,
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
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.h),
                topLeft: Radius.circular(30.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text("\$${cartController.totalAmount}"),
                ),

                GestureDetector(
                  onTap: () {
                    debugPrint("Checkout");
                    cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: BigText(text: "Checkout"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
