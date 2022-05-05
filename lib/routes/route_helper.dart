import 'package:food_delivery_dbestech/pages/cart/cart_page.dart';
import 'package:food_delivery_dbestech/pages/food/popular_food_detail.dart';
import 'package:food_delivery_dbestech/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_dbestech/pages/home/home_page.dart';
import 'package:food_delivery_dbestech/pages/home/main_food_page.dart';
import 'package:food_delivery_dbestech/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = '/splash-page';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';

  static String getSplash() => '$splash';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetail(
            pageId: int.parse(pageId!),
          );
        }),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
  ];
}
