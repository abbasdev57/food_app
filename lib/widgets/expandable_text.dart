import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  final int maxCharCount = 300; // You can also use a line-based logic if needed

  @override
  void initState() {
    super.initState();
    if (widget.text.length > maxCharCount) {
      firstHalf = widget.text.substring(0, maxCharCount);
      secondHalf = widget.text.substring(maxCharCount, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: secondHalf.isEmpty
          ? SmallText(
        text: firstHalf,
        color: AppColors.paraColor,
        size: 16.sp,
        height: 1.8,
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallText(
            text: hiddenText ? "$firstHalf..." : "$firstHalf$secondHalf",
            color: AppColors.paraColor,
            size: 16.sp,
            height: 1.8,
          ),
          SizedBox(height: 5.h),
          InkWell(
            onTap: () {
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(
                  text: hiddenText ? "See More" : "See Less",
                  color: AppColors.mainColor,
                  size: 16.sp,
                ),
                Icon(
                  hiddenText
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  color: AppColors.mainColor,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
