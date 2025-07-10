import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? bgColor;
  final double size;
  final double? iconSize;

  DetailIcon({
    Key? key,
    required this.icon,
    this.iconColor = const Color(0xfff10808),
    this.bgColor,
    this.size = 40,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Icon(
        icon,
        size: iconSize ?? 24.sp,
        // size: iconSize.isNull ? 24.sp : iconSize,
        color: iconColor,
      ),
    );
  }
}
