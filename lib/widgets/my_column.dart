import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'big_text.dart';
import 'icon_text.dart';
import 'small_text.dart';

/// A custom column widget displaying a title, star rating,
/// numeric rating, comments count, and a row of icons with labels.
/// Typically used for displaying item metadata like food details or product info.
class MyColumn extends StatelessWidget {
  /// The main title or heading (e.g., product name)
  final String text;

  /// Creates a [MyColumn] widget.
  const MyColumn({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Big title text
        BigText(text: text),

        SizedBox(height: 10.h),

        /// Star rating and numeric info
        Row(
          children: [
            /// 5-star rating bar
            Wrap(
              children: List.generate(
                5,
                    (index) => const Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            SizedBox(width: 10.w),

            /// Rating score
            SmallText(text: "4.7"),
            SizedBox(width: 10.w),

            /// Comments count
            SmallText(text: "1257"),
            SizedBox(width: 10.w),

            /// Static label
            SmallText(text: "comments"),
          ],
        ),

        SizedBox(height: 10.h),

        /// Row of icon-text combos (status, distance, duration)
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconAndText(
              iconData: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndText(
              iconData: Icons.location_on,
              text: "1.7 Km",
              iconColor: AppColors.mainColor,
            ),
            IconAndText(
              iconData: Icons.access_time_rounded,
              text: "32 min",
              iconColor: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
