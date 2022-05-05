import 'package:food_delivery_dbestech/controllers/cart_controller.dart';
import 'package:food_delivery_dbestech/controllers/popular_product_controller.dart';
import 'package:food_delivery_dbestech/data/api/api_client.dart';
import 'package:food_delivery_dbestech/data/repository/popular_product_repo.dart';
import 'package:food_delivery_dbestech/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
