import 'package:flutter/material.dart';

import '../../dimensions.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key, required this.text, required this.img})
      : super(key: key);
  final String text, img;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "Việt Nam",
          style: TextStyle(
              fontSize: Dimensions.font36,
              color: Colors.red,
              fontWeight: FontWeight.bold),
        ),
        Text(text),
        const Spacer(
          flex: 2,
        ),
        Image.asset(
          img,
          width: double.maxFinite,
          height: 265,
        ),
      ],
    );
  }
}
