//detail food = popularfooddetail.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/detail_icon.dart';
import '../widgets/expandable_text.dart';
import 'home/main_food_body.dart';

class PopularFood extends StatelessWidget {
  const PopularFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.black45,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/crispy_wings.png"),
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
                    //onTap: Get.toNamed(()=>AppRoutes.initial),
                    child: DetailIcon(icon: Icons.arrow_back_ios_new),
                  ),
                  DetailIcon(icon: Icons.shopping_cart_checkout),
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
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyColumn(text: 'name in mycolumn',),
                    SizedBox(height: 20.h),
                    BigText(text: "Introduce"),
                    SizedBox(height: 5.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(
                          text:
                              "A Zinger Burger is KFC's original fried chicken recipe with a spicy twist. Hot fried chicken is sandwiched between a sesame bun together with lettuce and a creamy dressing for a classic chicken burger with a hint of spice.,\n A Zinger Burger is KFC's original fried chicken recipe with a spicy twist. Hot fried chicken is sandwiched between a sesame bun together with lettuce and a creamy dressing for a classic chicken burger with a hint of spice.",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
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
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.remove, color: AppColors.signColor),
                    SizedBox(width: 10.w),
                    BigText(text: "0"),
                    SizedBox(width: 10.w),
                    Icon(Icons.add, color: AppColors.signColor),
                  ],
                ),
              ),
              Container(
                child: BigText(text: "\$0.08", color: Colors.red[400]),
              ),
              Container(
                padding: EdgeInsets.all(20.w),
                child: BigText(text: "Add to Cart"),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
