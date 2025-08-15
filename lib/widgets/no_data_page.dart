import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text, imgPath;

  const NoDataPage({
    super.key,
    required this.text,
    this.imgPath = "assets/images/empty_cart.png",
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(imgPath, height: height * 0.3, width: width * 0.3),
        SizedBox(height: height * 0.03),
        Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            fontSize: height * 0.02,
            color: Theme.of(context).disabledColor,

          ),
        ),
      ],
    );
  }
}
