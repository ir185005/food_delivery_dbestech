import 'package:flutter/material.dart';
import 'package:food_delivery_dbestech/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  const AppIcon({
    Key? key,
    required this.icon,
    this.iconColor = const Color(0xff756d54),
    this.backgroundColor = const Color(0x96fcf4e4),
    this.size = 40,
    this.iconSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
