import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/controller/popular_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/icon_text.dart';
import 'package:get/get.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../modal/popular_product_modal.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_routes.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class MainFoodBody extends StatefulWidget {
  const MainFoodBody({super.key});

  @override
  State<MainFoodBody> createState() => _MainFoodBodyState();
}

class _MainFoodBodyState extends State<MainFoodBody> {
  // PageController to control the page view , for one item at a time
  final PageController _pageController = PageController(viewportFraction: 0.85);

  // for transition animation use current page position
  var _currentPagePosition = 0.0;

  final double _scaleFactor = 0.8; // scale factor for the page view
  // 320 is the height of the total page view
  // 220 is the image height + 120 is the text height
  double _containerHeight = 220.h;
  final double _totalHeight = 320.h;

  @override
  void initState() {
    super.initState();
    // add listener to the page controller to get the current page position
    _pageController.addListener(() {
      setState(() {
        _currentPagePosition = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Todo: add shimmer effect

        // Main Slider
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    margin: EdgeInsets.only(top: 10.h),
                    height: _totalHeight,
                    // color: Colors.amberAccent,
                    // when the page changes its build from here everytime
                    child: GestureDetector(
                      onTap: () {
                        //   move to popular
                        // Get.toNamed(AppRoutes.getPopularFood());
                      },
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: popularProducts.popularProductList.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(
                            position,
                            popularProducts.popularProductList[position],
                          );
                        },
                      ),
                    ),
                  )
                : CircularProgressIndicator(color: AppColors.mainBlackColor);
          },
        ),

        // DOts indicator
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            print(popularProducts.popularProductList.length);

            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currentPagePosition,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                // spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0.r),
                ),
              ),
            );
          },
        ),

        // spacing
        SizedBox(height: 30.h),

        //  text
        Container(
          margin: EdgeInsets.only(left: 30.w, bottom: 30.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 2.h),
                child: BigText(text: "Recommended"),
              ),
              SizedBox(width: 20.w),
              Container(
                margin: EdgeInsets.only(bottom: 3.h),
                child: SmallText(text: "Food Pairing"),
              ),
            ],
          ),
        ),

        //   lists
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoaded
                ? ListView.builder(
                    itemCount: recommendedProduct.recommendedProductList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _ListItem(
                        index,
                        recommendedProduct.recommendedProductList[index],
                      );
                    },
                  )
                : CircularProgressIndicator(color: AppColors.mainColor);
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    /*
    print(MediaQuery.of(context).size.height.toString());
    print("as");
    print(Dimensions.screenHeight.toString());
    print(MediaQuery.of(context).size.width.toString());
    print("as");
    print(Dimensions.screenWidth.toString());
*/
    Matrix4 matrix4 = Matrix4.identity();
    //floor() will get the value in int

    // for current slide
    if (index == _currentPagePosition.floor()) {
      var currentScale =
          1 - (_currentPagePosition - index) * (1 - _scaleFactor);
      var currentTransition = _totalHeight * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    }
    //for right slide
    else if (index == _currentPagePosition.floor() + 1) {
      var currentScale =
          _scaleFactor +
          (_currentPagePosition - index + 1) * (1 - _scaleFactor);
      var currentTransition = _totalHeight * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    }
    //for left slide
    else if (index == _currentPagePosition.floor() - 1) {
      var currentScale =
          1 - (_currentPagePosition - index) * (1 - _scaleFactor);
      var currentTransition = _totalHeight * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    }
    //for all
    else {
      var currentScale = 0.8;
      var currentTransition = _totalHeight * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          Container(
            height: 220.h,
            margin: EdgeInsets.only(left: 5.w, right: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: NetworkImage(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD +
                      popularProduct.img!,
                ),
                fit: BoxFit.cover,
              ),
              //color: Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120.h,
              margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffe8e8e8),
                    blurRadius: 5,
                    //offset will define the position shaodw
                    offset: Offset(0, 8),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(left: 20.w, top: 15.h, right: 20.w),
                // child: MyColumn(text: popularProduct.name!),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name!),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            popularProduct.stars!,
                            (index) => const Icon(
                              Icons.star,
                              size: 15,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SmallText(text: popularProduct.price.toString()),
                        SizedBox(width: 10.w),
                        SmallText(text: "1257"),
                        SizedBox(width: 10.w),
                        SmallText(text: "comments"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        IconAndText(
                          iconData: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndText(
                          iconData: Icons.location_on,
                          text: "1.7 Km",
                          iconColor: AppColors.mainColor,
                        ),
                        IconAndText(
                          iconData: Icons.access_time_rounded,
                          text: "32 min",
                          iconColor: AppColors.iconColor2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ListItem(int index, ProductModel recommendedProduct) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
      child: Row(
        children: [
          //  for image
          Container(
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                //Todo differenet from dbstech
                ///recommendedPrdouct.recommendedProductsList[index].img!
                image: NetworkImage(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD +
                      recommendedProduct.img!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Container(
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(text: recommendedProduct.name!),
                    SizedBox(height: 5.h),
                    SmallText(text: "Crispy zinger strips  with fresh onions."),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconAndText(
                          size: 18,
                          iconData: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndText(
                          size: 18,
                          iconData: Icons.location_on,
                          text: "1.7 Km",
                          iconColor: AppColors.mainColor,
                        ),
                        IconAndText(
                          size: 18,
                          iconData: Icons.access_time_rounded,
                          text: "32 min",
                          iconColor: AppColors.iconColor2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyColumn extends StatelessWidget {
  final String text;

  const MyColumn({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text),
        SizedBox(height: 10.h),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            SmallText(text: "4.7"),
            SizedBox(width: 10.w),
            SmallText(text: "1257"),
            SizedBox(width: 10.w),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            IconAndText(
              iconData: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndText(
              iconData: Icons.location_on,
              text: "1.7 Km",
              iconColor: AppColors.mainColor,
            ),
            IconAndText(
              iconData: Icons.access_time_rounded,
              text: "32 min",
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
