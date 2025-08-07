import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable text widget for displaying large, bold titles.
///
/// Automatically applies the "Bebas" font and supports responsive sizing with `flutter_screenutil`.
/// If [size] is not provided, it defaults to 20.sp (responsive).
///
/// Example usage:
/// ```dart
/// BigText(text: "Hello World")
/// BigText(text: "Title", size: 24.sp, color: Colors.black)
/// ```
class BigText extends StatelessWidget {
  /// The text to display.
  final String text;

  /// The text color. Defaults to dark brown.
  final Color? color;

  /// The font size. If set to 0, it defaults to 20.sp.
  final double size;

  /// How visual overflow should be handled. Defaults to ellipsis (...).
  final TextOverflow overflow;

  const BigText({
    super.key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? 20.sp : size,
        fontFamily: 'Bebas', // Ensure you’ve added this font in pubspec.yaml
      ),
    );
  }
}
