import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_dbestech/controllers/cart_controller.dart';
import 'package:food_delivery_dbestech/controllers/popular_product_controller.dart';
import 'package:food_delivery_dbestech/pages/cart/cart_page.dart';
import 'package:food_delivery_dbestech/pages/home/main_food_page.dart';
import 'package:food_delivery_dbestech/routes/route_helper.dart';
import 'package:food_delivery_dbestech/utils/constants.dart';
import 'package:food_delivery_dbestech/utils/dimensions.dart';
import 'package:food_delivery_dbestech/widgets/app_column.dart';
import 'package:food_delivery_dbestech/widgets/app_icon.dart';
import 'package:food_delivery_dbestech/widgets/expandable_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      //extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                width: double.maxFinite,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.baseUrl +
                          AppConstants.uploadUrl +
                          product.img!)),
                ),
              )),
          Positioned(
            top: Dimensions.size25,
            left: Dimensions.size20,
            right: Dimensions.size20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == 'cartpage') {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 240,
            bottom: 0,
            child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.size20,
                  vertical: Dimensions.size10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.size10),
                    BigText(text: 'Introduce'),
                    SizedBox(height: Dimensions.size10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: product.description!),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.size100,
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.size10,
            horizontal: Dimensions.size20,
          ),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.size20 * 2),
                topRight: Radius.circular(Dimensions.size20 * 2),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.size20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.size20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child:
                          BigText(text: popularProduct.inCartItems.toString()),
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(Icons.add, color: AppColors.signColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.size20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.size20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(
                    text: '\$ ${product.price} | Add to Cart',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
