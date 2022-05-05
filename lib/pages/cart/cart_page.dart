import 'package:flutter/material.dart';
import 'package:food_delivery_dbestech/base/no_data_page.dart';
import 'package:food_delivery_dbestech/controllers/cart_controller.dart';
import 'package:food_delivery_dbestech/controllers/popular_product_controller.dart';
import 'package:food_delivery_dbestech/pages/home/main_food_page.dart';
import 'package:food_delivery_dbestech/routes/route_helper.dart';
import 'package:food_delivery_dbestech/utils/colors.dart';
import 'package:food_delivery_dbestech/utils/constants.dart';
import 'package:food_delivery_dbestech/utils/dimensions.dart';
import 'package:food_delivery_dbestech/widgets/app_icon.dart';
import 'package:food_delivery_dbestech/widgets/big_text.dart';
import 'package:food_delivery_dbestech/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.size20,
              right: Dimensions.size20,
              top: Dimensions.size45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.size25,
                  ),
                  SizedBox(width: Dimensions.size20 * 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.size25,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.size25,
                  ),
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.size20 * 4.5,
                    left: Dimensions.size20,
                    right: Dimensions.size20,
                    bottom: 0,
                    child: Container(
                      //color: Colors.red,
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                              builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    height: Dimensions.size20 * 5,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, 'cartpage'),
                                              );
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar('History product',
                                                    'Product review is not available.');
                                              } else {
                                                Get.toNamed(
                                                  RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex),
                                                );
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.size20 * 5,
                                            height: Dimensions.size20 * 5,
                                            margin: EdgeInsets.only(
                                              bottom: Dimensions.size10,
                                              right: Dimensions.size10,
                                            ),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  AppConstants.baseUrl +
                                                      AppConstants.uploadUrl +
                                                      cartController
                                                          .getItems[index].img!,
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimensions.size20,
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: Dimensions.size20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                color: Colors.black54,
                                              ),
                                              SmallText(text: 'Spicey'),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index].price
                                                        .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                      Dimensions.size10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Dimensions.size20,
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 5.0,
                                                          ),
                                                          child: BigText(
                                                            text:
                                                                _cartList[index]
                                                                    .quantity
                                                                    .toString(),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  );
                                });
                          })),
                    ),
                  )
                : NoDataPage(text: 'Your cart is empty.');
          }),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
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
            child: cartController.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimensions.size20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.size20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: BigText(
                                text: '\$' +
                                    cartController.totalAmount.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //popularProduct.addItem
                          print('tapped');
                          cartController.addToHistory();
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.size20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.size20),
                            color: AppColors.mainColor,
                          ),
                          child: BigText(
                            text: 'CheckOut',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container());
      }),
    );
  }
}
