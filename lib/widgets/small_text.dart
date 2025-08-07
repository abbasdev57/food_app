import 'package:flutter/material.dart';

/// A reusable small text widget with customizable color, size, and height.
///
/// This is commonly used for subtitles, captions, or other minor text.
class SmallText extends StatelessWidget {
  /// The text to display.
  final String text;

  /// The color of the text.
  /// Defaults to a light gray color if not provided.
  final Color? color;

  /// The font size of the text. Defaults to 12.
  final double size;

  /// The line height (line spacing multiplier). Defaults to 1.2.
  final double height;

  /// Creates a [SmallText] widget.
  const SmallText({
    Key? key,
    required this.text,
    this.color = const Color(0xff98918e),
    this.size = 12,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
        // fontFamily: 'Assistant', // Optional: Uncomment if you have a custom font.
      ),
    );
  }
}
