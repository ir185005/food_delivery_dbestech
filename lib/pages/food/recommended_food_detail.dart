import 'package:flutter/material.dart';
import 'package:food_delivery_dbestech/controllers/popular_product_controller.dart';
import 'package:food_delivery_dbestech/controllers/recommended_product_controller.dart';
import 'package:food_delivery_dbestech/pages/cart/cart_page.dart';
import 'package:food_delivery_dbestech/routes/route_helper.dart';
import 'package:food_delivery_dbestech/utils/constants.dart';
import 'package:food_delivery_dbestech/utils/colors.dart';
import 'package:food_delivery_dbestech/utils/dimensions.dart';
import 'package:food_delivery_dbestech/widgets/app_icon.dart';
import 'package:food_delivery_dbestech/widgets/big_text.dart';
import 'package:food_delivery_dbestech/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 60,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(icon: Icons.clear)),
                  //AppIcon(icon: Icons.shopping_cart_outlined),
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(
                  child: Center(
                    child: BigText(
                      text: product.name!,
                      size: 23,
                    ),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.size20),
                      topRight: Radius.circular(Dimensions.size20),
                    ),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 230,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.baseUrl + AppConstants.uploadUrl + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExpandableText(text: product.description!),
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.size10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.size10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          icon: Icons.remove,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white),
                    ),
                    BigText(
                      text: '\$${product.price} X ${controller.inCartItems}',
                      size: Dimensions.size25,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                          icon: Icons.add,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.size20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.size20),
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
              ),
            ],
          );
        }));
  }
}
