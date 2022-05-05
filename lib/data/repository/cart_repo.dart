import 'dart:convert';

import 'package:food_delivery_dbestech/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.cartList);
    // sharedPreferences.remove(AppConstants.cartHistoryList);
    cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.cartList, cart);
    //print(sharedPreferences.getStringList(AppConstants.cartList));
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
    }
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach(
      (element) => cartListHistory.add(
        CartModel.fromJson(
          jsonDecode(element),
        ),
      ),
    );
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print(cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.cartHistoryList, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.cartList);
  }
}
