import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/widgets/no_data_page.dart';
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

/// This widget displays the user's cart page.
/// It shows the list of products added to the cart, allows quantity adjustments,
/// and provides a checkout button.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// -------------------------
          /// Top navigation row
          /// -------------------------
          Positioned(
            top: 45.w,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const DetailIcon(
                    icon: Icons.arrow_back_ios,
                    bgColor: AppColors.mainColor,
                    iconColor: Colors.white,
                  ),
                ),

                SizedBox(width: 20.w),

                /// Home button
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.getInitial()),
                  child: const DetailIcon(
                    icon: Icons.home,
                    bgColor: AppColors.mainColor,
                    iconColor: Colors.white,
                  ),
                ),

                /// Cart icon (redundant here since we're on CartPage)
                const DetailIcon(
                  icon: Icons.shopping_cart,
                  bgColor: AppColors.mainColor,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),

          /// -------------------------
          /// Cart items list
          /// -------------------------
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
              top: 100.h,
              left: 10.w,
              right: 10.w,
              bottom: 0,
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
                          child: Row(
                            children: [
                              /// Product image (clickable to go to product detail)
                              GestureDetector(
                                onTap: () {
                                  var product = cartList[index].product!;
                                  var popularIndex = Get.find<PopularProductController>()
                                      .popularProductList
                                      .indexOf(product);

                                  if (popularIndex >= 0) {
                                    Get.toNamed(AppRoutes.getPopularFood(popularIndex));
                                  } else {
                                    var recommendedIndex =
                                    Get.find<RecommendedProductController>()
                                        .recommendedProductList
                                        .indexOf(product);
                                    Get.toNamed(AppRoutes.getRecommendedFood(recommendedIndex));
                                  }
                                },
                                child: Container(
                                  height: 120.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
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

                              /// Product details and quantity controls
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text: cartList[index].name!,
                                      color: Colors.black,
                                    ),
                                    const SmallText(text: ""),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        /// Price
                                        BigText(
                                          text: cartList[index].price!.toString(),
                                          color: Colors.redAccent,
                                        ),

                                        /// Quantity control (− / qty / +)
                                        Container(
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.r),
                                          ),
                                          child: Row(
                                            children: [
                                              /// Decrease quantity
                                              GestureDetector(
                                                onTap: () => controller.addItemToController(
                                                  cartList[index].product!,
                                                  -1,
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: AppColors.signColor,
                                                ),
                                              ),

                                              SizedBox(width: 10.w),

                                              /// Quantity text
                                              BigText(
                                                text: cartList[index].quantity.toString(),
                                              ),

                                              SizedBox(width: 10.w),

                                              /// Increase quantity
                                              GestureDetector(
                                                onTap: () => controller.addItemToController(
                                                  cartList[index].product!,
                                                  1,
                                                ),
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
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ):NoDataPage(text: "Your Cart is Empty");
          })
        ],
      ),

      /// -------------------------
      /// Bottom Checkout Bar
      /// -------------------------
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
            child:cartController.getItems.isNotEmpty?  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// Total Price Display
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text("\$${cartController.totalAmount}"),
                ),

                /// Checkout Button
                GestureDetector(
                  onTap: () {
                    cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const BigText(text: "Checkout"),
                  ),
                ),
              ],
            ): Container()
          );
        },
      ),
    );
  }
}
