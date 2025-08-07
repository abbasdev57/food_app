import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'small_text.dart';

/// A reusable widget that displays an icon next to a small text label.
/// Commonly used for displaying features like location, time, or status info.
class IconAndText extends StatelessWidget {
  /// The icon to display (e.g. Icons.location_on)
  final IconData iconData;

  /// The text label to display next to the icon
  final String text;

  /// The color of the icon
  final Color iconColor;

  /// The size of the icon in logical pixels (optional, default = 24.w)
  final double? size;

  /// Constructor for IconAndText widget
  const IconAndText({
    super.key,
    required this.iconData,
    required this.text,
    required this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Icon widget with color and responsive size
        Icon(
          iconData,
          color: iconColor,
          size: (size ?? 24).w, // Default size if not provided
        ),

        /// Horizontal spacing between icon and text
        SizedBox(width: 5.w),

        /// SmallText widget for displaying the label
        SmallText(
          text: text,
          size: 14.sp,
          color: Colors.black87,
        ),
      ],
    );
  }
}
