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

class RecommendedFood extends StatelessWidget {
  final pageIndex;

  const RecommendedFood({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Recommend");
    var products = Get.find<RecommendedProductController>()
        .recommendedProductList[pageIndex];
    Get.find<PopularProductController>().initProduct(
      products,
      Get.find<CartController>(),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //remove auto add back button
            automaticallyImplyLeading: false,

            //Todo: fix image on title while scrolling
            pinned: true,
            backgroundColor: Colors.grey,
            expandedHeight: 300,

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD + products.img!,
                fit: BoxFit.cover,
              ),
            ),
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
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: Text(
                                  Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
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

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
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
                    padding: const EdgeInsets.all(8.0),
                    child: BigText(size: 20.sp * 1.3, text: products.name!),
                  ),
                ),
              ),
            ),
          ),
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
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          var finalPrice = products.price! * controller.getInCartItems;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: DetailIcon(
                        bgColor: Colors.white,
                        icon: Icons.remove,
                        iconSize: 24.w * 1.4,
                      ),
                    ),
                    BigText(
                      text:
                          '${products.price!.toString()} x ${controller.getInCartItems}',
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: DetailIcon(
                        bgColor: Colors.white,
                        icon: Icons.add,
                        iconSize: 24.w * 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.w),
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
                    Container(
                      child: BigText(
                        text: "\$ $finalPrice",
                        color: Colors.red[400],
                      ),
                    ),
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
