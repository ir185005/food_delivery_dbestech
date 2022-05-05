import 'package:flutter/material.dart';
import 'package:food_delivery_dbestech/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimensions.size20 : size,
      ),
    );
  }
}
