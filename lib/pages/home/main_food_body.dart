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

/// MainBody widget displays:
/// - A horizontal PageView for popular products (with scaling animation)
/// - Dots indicator for the current page
/// - Recommended product list (vertical)
class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  /// Controls the horizontal PageView
  PageController controller = PageController(viewportFraction: 0.85);

  /// Current scroll position for scaling effect
  double currentPageValue = 0.0;

  /// Height used for scaling animation calculations
  final double _height = 320.h;

  /// Minimum scale for non-active pages
  double scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    // Listen to PageView scroll changes
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
  }

  @override
  void dispose() {
    // Free up memory when widget is removed
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// ========================
        /// POPULAR PRODUCTS SLIDER
        /// ========================
        GetBuilder<PopularProductController>(builder: (popularproducts) {
          return popularproducts.isLoaded
              ? Container(
            margin: EdgeInsets.only(top: 10.h),
            height: 320.h,
            child: PageView.builder(
              controller: controller,
              itemCount: popularproducts.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(
                  position,
                  popularproducts.popularProductList[position],
                );
              },
            ),
          )
              : const CircularProgressIndicator(
            color: AppColors.mainBlackColor,
          );
        }),

        /// ========================
        /// DOTS INDICATOR
        /// ========================
        GetBuilder<PopularProductController>(builder: (popularproducts) {
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
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),

        SizedBox(height: 30.h),

        /// ========================
        /// RECOMMENDED SECTION TITLE
        /// ========================
        Container(
          margin: EdgeInsets.only(left: 30.w, bottom: 30.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: BigText(text: "Recommended"),
              ),
              SizedBox(width: 20.w),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: "Food Pairing"),
              ),
            ],
          ),
        ),

        /// ========================
        /// RECOMMENDED PRODUCTS LIST
        /// ========================
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoaded
                ? ListView.builder(
              itemCount:
              recommendedProduct.recommendedProductList.length,
              shrinkWrap: true, // Makes it fit inside Column
              physics:
              const NeverScrollableScrollPhysics(), // Avoids scroll conflict
              itemBuilder: (context, index2) {
                return listItem(
                  index2,
                  recommendedProduct.recommendedProductList[index2],
                );
              },
            )
                : const CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          },
        ),
      ],
    );
  }

  /// Builds a single slider page with scaling animation
  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();

    // Determine scale & position based on current scroll
    if (index == currentPageValue.floor()) {
      // Current active page
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    } else if (index == currentPageValue.floor() + 1) {
      // Right-side page
      var currentScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    } else if (index == currentPageValue.floor() - 1) {
      // Left-side page
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 0);
    } else {
      // All other pages
      var currentScale = scaleFactor;
      var currentTransition = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransition, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          /// ========================
          /// PRODUCT IMAGE (Tappable)
          /// ========================
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.getPopularFood(index));
            },
            child: Container(
              height: 220.h,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
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
              ),
            ),
          ),

          /// ========================
          /// PRODUCT NAME BOX
          /// ========================
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120.h,
              margin: EdgeInsets.only(
                  left: 30.w, right: 30.w, bottom: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 8),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              child: Padding(
                padding:
                EdgeInsets.only(left: 20.w, top: 15.h, right: 20.w),
                child: MyColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single recommended product row item
  Widget listItem(int index, ProductModel recommendedProduct) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.getRecommendedFood(index));
      },
      child: Container(
        margin:
        EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
        child: Row(
          children: [
            /// IMAGE CONTAINER
            Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD +
                        recommendedProduct.img!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// TEXT DETAILS CONTAINER
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.w),
                height: 110.h,
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
                    SmallText(
                        text: "Crispy zinger strips with fresh onions."),
                    SizedBox(height: 5.h),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
          ],
        ),
      ),
    );
  }
}
