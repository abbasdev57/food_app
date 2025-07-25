import 'package:get/get.dart';
import '../pages/cart_page.dart';
import '../pages/home/main_page.dart';
import '../pages/popular_food_detail.dart';
import '../pages/recommended_food_detail.dart';
import '../pages/splash_page.dart';

class AppRoutes {
  // this / means first home section in materialApp
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";

  static String getInitial() => initial;

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static String getRecommendedFood(int pageI) =>
      '$recommendedFood?pageI=$pageI';

  static String getCartPage() => cartPage;

  static String getSplashPage() => splashPage;

  // initaialize it in main by getPages

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainPage()),
    GetPage(name: splashPage, page: () => const SplashPage()),
    GetPage(
      name: popularFood,
      page: () {
        var pId = Get.parameters['pageId'];
        return PopularFood(pageIndex: int.parse(pId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pId = Get.parameters['pageI'];
        return RecommendedFood(pageIndex: int.parse(pId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
    ),
  ];
}
