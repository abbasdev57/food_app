import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late var firstHalf, secondHalf;
  bool hiddenText = true;

  double textHeight = 180.h;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
          height: 1.8,
          color: AppColors.paraColor,
          size: 16.sp,
          text: firstHalf)
          : Column(
        children: [
          SmallText(
              height: 1.8,
              color: AppColors.paraColor,
              size: 16.sp,
              text: hiddenText
                  ? firstHalf + "..."
                  : (firstHalf + secondHalf)),
          SizedBox(height:5.h,),
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
                  size: 20.sp,
                ),
                Icon(
                  hiddenText
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  color: AppColors.mainColor,
                  size: 24.sp,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }

    super.initState();
  }
}
