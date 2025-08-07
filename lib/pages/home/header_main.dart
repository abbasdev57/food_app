import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String countryName = "Pakistan", cityName = "Lahore";

    return Container(
      child: Container(
        margin: EdgeInsets.only(
            top: 10.h, bottom: 15.h),
        padding: EdgeInsets.only(
            left: 20.w, right: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(text: countryName, color: AppColors.mainColor),
                Center(
                  child: Row(
                    children: [
                      SmallText(
                        text: cityName,
                        color: Colors.black54,
                      ),
                      const Icon(Icons.arrow_drop_down_rounded),
                    ],
                  ),
                )
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
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24.r,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
