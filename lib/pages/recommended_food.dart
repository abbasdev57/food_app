import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/detail_icon.dart';
import '../widgets/small_text.dart';

class RecommendedFood extends StatelessWidget {
  const RecommendedFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //Todo: fix image on title while scrolling
            pinned: true,
            backgroundColor: Colors.white70,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/crispy_wings.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailIcon(icon: Icons.clear),
                DetailIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BigText(size: 26.sp, text: 'Kfc Wings'),
                  ),
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  child: SmallText(
                    height: 2,
                    size: 16.sp,
                    color: AppColors.paraColor,
                    text:
                        "A Zinger Burger is KFC's original fried chicken recipe with a spicy twist. "
                        "Hot fried chicken is sandwiched between a sesame bun together with lettuce "
                        "and a creamy dressing for a classic chicken burger with a hint of spice.,\n A Z"
                        "inger Burger is KFC's original fried chicken recipe with a spicy twist. Hot "
                        "fried chicken is sandwiched between a sesame bun together with lettuce and a "
                        "creamy dressing for a classic chicken burger with a hint of spice."
                        " lettuce "
                        "lettuce "
                        "and a creamy dressing for a classic chicken burger with a hint of spice.,\n A Z"
                        "inger Burger is KFC's original fried chicken recipe with a spicy twist. Hot "
                        "fried chicken is sandwiched between a sesame bun together with lettuce and a "
                        "creamy dressing for a classic chicken burger with a hint of spice."
                        "creamy dressing for a classic chicken burger with a hint of spice."
                        "and a creamy dressing for a classic chicken burger with a hint of spice.,\n A Z"
                        "inger Burger is KFC's original fried chicken recipe with a spicy twist. Hot "
                        "fried chicken is sandwiched between a sesame bun together with lettuce and a "
                        "creamy dressing for a classic chicken burger with a hint of spice.",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DetailIcon(icon: Icons.remove, iconSize: 33.sp),
                BigText(text: " 1200 x  " + " 0"),
                DetailIcon(icon: Icons.add, iconSize: 33.sp),
              ],
            ),
          ),
          SizedBox(height: 5.h),
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
                    iconSize: 40.sp,
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
        ],
      ),
    );
  }
}
