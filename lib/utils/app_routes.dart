import 'package:food_app/pages/home_page.dart';
import 'package:get/get.dart';
import '../pages/cart_page.dart';
import '../pages/home/main_page.dart';
import '../pages/popular_food_detail.dart';
import '../pages/recommended_food_detail.dart';
import '../pages/splash_page.dart';

/// This class handles all named routes in the application using GetX.
///
/// It provides static route names and helper methods to generate dynamic routes.
/// All pages are registered in the `routes` list for GetMaterialApp to use.
class AppRoutes {
  /// Route for the initial screen (MainPage).
  static const String initial = "/";

  /// Route for the popular food detail screen.
  static const String popularFood = "/popular-food";

  /// Route for the recommended food detail screen.
  static const String recommendedFood = "/recommended-food";

  /// Route for the cart page.
  static const String cartPage = "/cart-page";

  /// Route for the splash screen shown on app launch.
  static const String splashPage = "/splash-page";

  /// Returns the initial route.
  static String getInitial() => initial;

  /// Returns the route for the popular food detail screen with the given [pageId].
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  /// Returns the route for the recommended food detail screen with the given [pageI].
  static String getRecommendedFood(int pageI) => '$recommendedFood?pageI=$pageI';

  /// Returns the route for the cart page.
  static String getCartPage() => cartPage;

  /// Returns the route for the splash screen.
  static String getSplashPage() => splashPage;

  /// A list of all available GetX pages and their corresponding route names.
  ///
  /// Must be passed to `GetMaterialApp` in the `getPages` property.
  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () =>  HomePage(),
      // page: () => const MainPage(),
    ),
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
    ),
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
      page: () => CartPage(),
    ),
  ];
}
