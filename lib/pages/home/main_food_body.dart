import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/popular_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../modal/popular_product_modal.dart';
import '../../utils/app_constants.dart';

import '../../utils/app_routes.dart';
import '../../utils/colors.dart';

import '../../widgets/big_text.dart';

import '../../widgets/icon_text.dart';
import '../../widgets/my_column.dart';
import '../../widgets/small_text.dart';
import 'package:get/get.dart';

class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  // controller display the page item size of a single item
  PageController controller = PageController(viewportFraction: 0.85);

  //for transition   of the left and right side size down

  var currentPageValue = 0.0;
  final double _height = 320.h;

  // vertical size (y)
  double scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
  }

  @override
  void dispose() {
    //When the app is closed the memory will be free and variable store new values
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider
        GetBuilder<PopularProductController>(builder: (popularproducts) {
          //Todo: add Shimmer effect

          return popularproducts.isLoaded
              ? Container(
            margin: EdgeInsets.only(top: 10.h),
            height: 320.h,
            //color: Colors.grey,

            // when the page changes its build from here everytime

            child: PageView.builder(
                controller: controller,
                itemCount: popularproducts.popularProductList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position,
                      popularproducts.popularProductList[position]);
                }),
          )
              : const CircularProgressIndicator(
            color: AppColors.mainBlackColor,
          );
        }),

        GetBuilder<PopularProductController>(builder: (popularproducts) {
          // print(popularproducts.popularProductList.length);
          return DotsIndicator(
            dotsCount: popularproducts.popularProductList.isEmpty
                ? 1
                : popularproducts.popularProductList.length,
            position: currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: AppColors.mainColor,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          );
        }),

        SizedBox(
          height: 30.h,
        ),

        //popular text
        Container(
          margin: EdgeInsets.only(left: 30.w, bottom: 30.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: BigText(text: "Recommended")),
              SizedBox(
                width: 20.w,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: SmallText(text: "Food Pairing")),
            ],
          ),
        ),

        // recommended lists

        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
              itemCount: recommendedProduct.recommendedProductList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index2) {
                return listItem(index2,
                    recommendedProduct.recommendedProductList[index2]);
              })
              : const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
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
    if (index == currentPageValue.floor()) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    }
    //for right slide
    else if (index == currentPageValue.floor() + 1) {
      var currentScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    }
    //for left slide

    else if (index == currentPageValue.floor() - 1) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    }

    //for all
    else {
      var currentScale = 0.8;
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.getPopularFood(index));
            },
            child: Container(
              height: 220.h,
              margin: EdgeInsets.only(left: 5.w, right: 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD +
                      popularProduct.img!),
                  fit: BoxFit.cover,
                ),
                //color: Colors.black,
              ),
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
                        offset: Offset(0, 8)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(left: 20.w, top: 15.h, right: 20.w),
                child: MyColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(int index, ProductModel recommendedProduct) {
    // print(index.toString());
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.getRecommendedFood(index));
        print("list click");
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
        child: Row(
          children: [
            Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(

                  //Todo differenet from dbstech
                  ///uppload sey aagey
                  ///recommendedPrdouct.recommendedProductsList[index].img!
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD +
                        recommendedProduct.img!),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.w),
                height: 100.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(text: recommendedProduct.name!),
                    SizedBox(
                      height: 5.h,
                    ),
                    SmallText(text: "Crispy zinger strips  with fresh onions."),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndText(
                            size: 18,
                            iconData: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        IconAndText(
                            size: 18,
                            iconData: Icons.location_on,
                            text: "1.7 Km",
                            iconColor: AppColors.mainColor),
                        IconAndText(
                            size: 18,
                            iconData: Icons.access_time_rounded,
                            text: "32 min",
                            iconColor: AppColors.iconColor2),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
