import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String countryName = "Pakistan Asia", cityName = "Lahore";
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(text: countryName, color: AppColors.mainColor),
                Row(
                  children: [
                    SmallText(text: cityName, color: AppColors.mainBlackColor),
                    Icon(Icons.arrow_drop_down_rounded),
                  ],
                ),
              ],
            ),
            Center(
              child: Container(
                height: 45.h,
                width: 45.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.mainColor,
                ),
                child: InkWell(
                  onTap: () {
                    // Add your search functionality here
                  },
                  child: Icon(Icons.search, color: Colors.white, size: 24.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
