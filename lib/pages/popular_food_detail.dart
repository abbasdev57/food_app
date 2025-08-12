// This screen shows the detail of a selected food item from the Popular Food List.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import '../controller/popular_controller.dart';
import '../utils/app_constants.dart';
import '../utils/app_routes.dart';
import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/detail_icon.dart';
import '../widgets/expandable_text.dart';
import '../widgets/my_column.dart';

class PopularFood extends StatelessWidget {
  /// The index of the selected product passed through route
  final int pageIndex;

  const PopularFood({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    /// Fetch the product using the passed index from the PopularProductController
    var products = Get.find<PopularProductController>().popularProductList[pageIndex];

    /// Initialize product with CartController (to sync quantity/cart state)
    Get.find<PopularProductController>().initProduct(
      products,
      Get.find<CartController>(),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // 🔼 Image at the top of the screen
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 300.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL +
                          AppConstants.UPLOAD +
                          products.img!,
                    ),
                  ),
                ),
              ),
            ),

            // 🔼 Two icons: Back and Cart
            Positioned(
              left: 20.w,
              top: 20.h,
              right: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ← Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: DetailIcon(
                      icon: Icons.arrow_back_ios_new,
                      iconColor: Colors.black,
                    ),
                  ),
                  // 🛒 Cart button with item count
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to Cart Page when tapped
                              Get.toNamed(AppRoutes.getCartPage());
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: DetailIcon(
                                size: 24,
                                icon: Icons.shopping_cart_checkout,
                              ),
                            ),
                          ),
                          // 🧮 Show item count on cart icon (only if items exist)
                          controller.totalItems >= 1
                              ? Positioned(
                            right: 0,
                            top: 0,
                            child: Text(
                              controller.totalItems.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // 🔽 Product detail section (below image)
            Positioned(
              top: 300.h - 20.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.w),
                    topLeft: Radius.circular(20.w),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row with rating + icons
                    MyColumn(text: products.name!),
                    SizedBox(height: 20.h),

                    // Title: Introduce
                    BigText(text: "Introduce"),
                    SizedBox(height: 5.h),

                    // Product description (expandable)
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: products.description!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ⬇️ Bottom bar: Quantity, Price, Add to Cart
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularController) {
            return Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.btnBgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.h),
                  topLeft: Radius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Quantity Selector (Add/Remove buttons)
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        // ➖ Decrease quantity
                        GestureDetector(
                          onTap: () {
                            popularController.setQuantity(false);
                          },
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(width: 10.w),

                        // 🔢 Show current quantity
                        BigText(
                          text: popularController.getInCartItems.toString(),
                        ),
                        SizedBox(width: 10.w),

                        // ➕ Increase quantity
                        GestureDetector(
                          onTap: () {
                            popularController.setQuantity(true);
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 💲 Show Price
                  BigText(
                    text: "\$ ${products.price!.toString()}",
                    color: Colors.red[400],
                  ),

                  // ✅ Add to Cart button
                  GestureDetector(
                    onTap: () {
                      // Add selected item with selected quantity to Cart
                      popularController.addItemTOCart(products);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.h),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: BigText(text: "Add to Cart"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
