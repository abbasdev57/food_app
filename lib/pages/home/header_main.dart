import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

/// A reusable main header widget that shows:
/// - Country and city name
/// - A location dropdown icon
/// - A search button
class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Static location for now — can later be dynamic from API or user settings
    String countryName = "Pakistan";
    String cityName = "Lahore";

    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),

      // Main row layout: Left (location) + Right (search button)
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left side: Location info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align left
            children: [
              BigText(
                text: countryName,
                color: AppColors.mainColor,
              ),
              Row(
                children: [
                  SmallText(
                    text: cityName,
                    color: Colors.black54,
                  ),
                  const Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ],
          ),

          /// Right side: Search button
          Container(
            height: 45.h,
            width: 45.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.mainColor,
            ),
            child: InkWell(
              onTap: () {
                // TODO: Navigate to search page
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 24.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
