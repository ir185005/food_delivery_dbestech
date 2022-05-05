import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_dbestech/utils/colors.dart';
import 'package:food_delivery_dbestech/utils/dimensions.dart';
import 'package:food_delivery_dbestech/widgets/big_text.dart';
import 'package:food_delivery_dbestech/widgets/small_text.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    //print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 35, bottom: 10),
              padding: EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: 'Bangladesh', color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: 'Narsinqdi', color: Colors.black54),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.size45,
                      height: Dimensions.size45,
                      child: Icon(Icons.search, color: Colors.white),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(child: FoodPageBody()),
          ),
        ],
      ),
    );
  }
}
