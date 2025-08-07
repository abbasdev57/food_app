//detail food = popularfoodpage
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
import 'home/main_food_body.dart';

class PopularFood extends StatelessWidget {
  final pageIndex;

  const PopularFood({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// getting products details from controller to modal to json to online
    var products =
        Get.find<PopularProductController>().popularProductList[pageIndex];

    Get.find<PopularProductController>().initProduct(
      products,
      Get.find<CartController>(),
    );
    //print("popular Food"+pageIndex.toString());
    //print("popular Food");
    //print(products.name);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 300.h,
                decoration: BoxDecoration(
                  //  color: Colors.black45,
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

            //two icon in a row
            Positioned(
              left: 20.w,
              top: 20.h,
              right: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: DetailIcon(
                      icon: Icons.arrow_back_ios_new,
                      iconColor: Colors.black,
                    ),
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
                                size: 24,
                                icon: Icons.shopping_cart_checkout,
                              ),
                            ),
                          ),
                          controller.totalItems >= 1
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
            ),

            //downward section
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
                    MyColumn(text: products.name!),
                    SizedBox(height: 20.h),
                    BigText(text: "Introduce"),
                    SizedBox(height: 5.h),
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
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
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
                        BigText(
                          text: popularController.getInCartItems.toString(),
                        ),
                        SizedBox(width: 10.w),
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
                  Container(
                    child: BigText(
                      text: "\$ ${products.price!.toString()}",
                      color: Colors.red[400],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
