import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = 'assets/image/empty_cart.png'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
