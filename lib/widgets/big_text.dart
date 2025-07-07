import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  TextOverflow overflow;

  BigText( {
    Key? key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        overflow: overflow,

        fontSize: size == 0 ? 20.sp : size,
        //fontWeight: FontWeight.w200, //comment it because the font is already bold
        fontFamily: 'Bebas',
      ),
    );
  }
}
