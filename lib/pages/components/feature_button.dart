import 'package:flutter/material.dart';

import '../../dimensions.dart';

class FeatureButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  const FeatureButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height50,
      width: double.maxFinite,
      // decoration: BoxDecoration(
      //   color: Colors.red,
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: Dimensions.width10),
              Text(text),
            ],
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
