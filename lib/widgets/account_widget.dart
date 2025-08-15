import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/detail_icon.dart';
import 'package:food_app/widgets/icon_text.dart';

class AccountWidget extends StatelessWidget {
  DetailIcon icon;
  BigText text;

  AccountWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Row(
        children: [
          icon,
          SizedBox(width: 20.w),
          text,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 2.r,
              offset: Offset(0,5),color: Colors.grey.withOpacity(0.2))
        ]
      ),
    );
  }
}
