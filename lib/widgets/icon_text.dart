import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;
  final size;

  const IconAndText({
    Key? key,
    this.size,
    required this.iconData,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: iconColor, size: size == 18 ? 18.w : 24.w),
        SizedBox(width: 5.w),
        SmallText(text: text),
      ],
    );
  }
}
