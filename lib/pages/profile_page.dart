import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/account_widget.dart';
import 'package:food_app/widgets/detail_icon.dart';
import 'package:food_app/widgets/icon_text.dart';

import '../widgets/big_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(text: "Profile", size: 24.h, color: Colors.white),
      ),
      body: Container(
        width: double.maxFinite,
        // height: double.maxFinite,
        padding: EdgeInsets.all(10.h),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// profile icon
            CircleAvatar(
              radius: 75.h,
              backgroundImage: AssetImage("assets/images/abbas.png"),
            ),
            SizedBox(height: 20.h),

            /// profile name
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(
                      icon: DetailIcon(
                        icon: Icons.person,
                        size: 50.h,
                        iconSize: 25.sp,
                        bgColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                      text: BigText(text: "Abbas Ali"),
                    ),
                    SizedBox(height: 20.h),

                    /// profile phone
                    AccountWidget(
                      icon: DetailIcon(
                        icon: Icons.phone,
                        size: 50.h,
                        iconSize: 25.sp,
                        bgColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                      ),
                      text: BigText(text: "+92 304 4482107"),
                    ),
                    SizedBox(height: 20.h),

                    /// profile email
                    AccountWidget(
                      icon: DetailIcon(
                        icon: Icons.email,
                        size: 50.h,
                        iconSize: 25.sp,
                        bgColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                      ),
                      text: BigText(text: "abbas@gmail.com"),
                    ),
                    SizedBox(height: 20.h),

                    AccountWidget(
                      icon: DetailIcon(
                        icon: Icons.location_on,
                        size: 50.h,
                        iconSize: 25.sp,
                        bgColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                      ),
                      text: BigText(text: "Fill in your address"),
                    ),
                    SizedBox(height: 20.h),
                    AccountWidget(
                      icon: DetailIcon(
                        icon: Icons.message_outlined,
                        size: 50.h,
                        iconSize: 25.sp,
                        bgColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                      text: BigText(text: "Abbas"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
