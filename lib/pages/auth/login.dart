import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/app_textfield.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80.h),

          Container(
            child: Center(
              child: CircleAvatar(
                radius: 80.h,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/images/icon.png"),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          AppTextField(
            textController: passwordController,
            hintText: "Password",
            icon: Icons.password,
          ),

          SizedBox(height: 20.h),
          AppTextField(
            textController: phoneController,
            hintText: "Phone",
            icon: Icons.phone,
          ),
          SizedBox(height: 30.h),

          Container(
            width: 200.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: AppColors.mainColor,
            ),
            child: Center(
              child: BigText(text: "SignUP", size: 30.sp, color: Colors.white),
            ),
          ),
          SizedBox(height: 20.h),
          RichText(
            text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
              style: TextStyle(color: Colors.grey, fontSize: 20.sp),
              text: "Have a Account already?",
            ),
          ),
          SizedBox(height: 10.h),
          RichText(
            text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
              text: "Sign up using one of the following methods",
            ),
          ),
          SizedBox(height: 30.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle Google Sign Up
                },
                child: Text("Google"),
              ),
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () {
                  // Handle Facebook Sign Up
                },
                child: Text("Facebook"),
              ),
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () {
                  // Handle Facebook Sign Up
                },
                child: Text("Twitter"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
