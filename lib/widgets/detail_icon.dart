import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A customizable icon widget with a circular background.
///
/// Useful for action buttons or visual indicators in UI detail views.
///
/// Example:
/// ```dart
/// DetailIcon(
///   icon: Icons.favorite,
///   iconColor: Colors.white,
///   bgColor: Colors.red,
/// )
/// ```
class DetailIcon extends StatelessWidget {
  /// The icon to display inside the container.
  final IconData icon;

  /// The color of the icon. Defaults to red.
  final Color iconColor;

  /// The background color of the container.
  final Color? bgColor;

  /// The width & height of the container. Defaults to 40.
  final double size;

  /// The size of the icon inside. Defaults to 24.sp if not specified.
  final double? iconSize;

  const DetailIcon({
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
        color: bgColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize ?? 24.sp,
          color: iconColor,
        ),
      ),
    );
  }
}
