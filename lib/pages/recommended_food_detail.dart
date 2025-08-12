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

/// RecommendedFood is a screen that shows the detailed view of a recommended product including image, description, quantity controls, and an option to add to cart.
class RecommendedFood extends StatelessWidget {
  final int pageIndex;

  const RecommendedFood({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Recommend"); // Debug log

    // Fetch product from recommended product list
    var products = Get.find<RecommendedProductController>()
        .recommendedProductList[pageIndex];

    // Initialize PopularProductController with product and cart
    Get.find<PopularProductController>().initProduct(
      products,
      Get.find<CartController>(),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// SliverAppBar with image background and sticky behavior
          SliverAppBar(
            automaticallyImplyLeading: false, // removes default back button
            pinned: true,
            backgroundColor: Colors.grey,
            expandedHeight: 300.h,

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD + products.img!,
                fit: BoxFit.cover,
              ),
            ),

            /// Top bar with clear (back) button and cart icon
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: DetailIcon(icon: Icons.clear, iconColor: Colors.black),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.getCartPage());
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: DetailIcon(
                              size: 24.w,
                              icon: Icons.shopping_cart_checkout,
                            ),
                          ),
                        ),
                        // Cart item count badge
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

            /// Bottom section with product name
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70.h),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BigText(size: 26.sp, text: products.name!),
                  ),
                ),
              ),
            ),
          ),

          /// Product description section
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SmallText(
                    height: 2,
                    size: 16.sp,
                    color: AppColors.paraColor,
                    text: products.description!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// Bottom navigation bar with quantity controls and add to cart
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          var finalPrice = products.price! * controller.getInCartItems;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.h),

              /// Quantity row
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// Decrease quantity
                    GestureDetector(
                      onTap: () => controller.setQuantity(false),
                      child: DetailIcon(
                        bgColor: Colors.white,
                        icon: Icons.remove,
                        iconSize: 34.w,
                      ),
                    ),

                    /// Current quantity and unit price
                    BigText(
                      text:
                      '${products.price!.toString()} x ${controller.getInCartItems}',
                    ),

                    /// Increase quantity
                    GestureDetector(
                      onTap: () => controller.setQuantity(true),
                      child: DetailIcon(
                        bgColor: Colors.white,
                        icon: Icons.add,
                        iconSize: 34.w,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),

              /// Final row: Favorite, Total Price, Add to Cart
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColors.btnBgColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.r),
                    topLeft: Radius.circular(30.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// Favorite icon
                    Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: DetailIcon(
                        icon: Icons.favorite,
                        iconColor: AppColors.mainColor,
                        iconSize: 40.w,
                      ),
                    ),

                    /// Total price
                    BigText(
                      text: "\$ $finalPrice",
                      color: Colors.red[400],
                    ),

                    /// Add to Cart Button
                    GestureDetector(
                      onTap: () {
                        controller.addItemTOCart(products);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: BigText(text: "Add to Cart"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
