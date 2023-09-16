import 'package:flutter/material.dart';
import 'package:intern_project/dimensions.dart';

class BottomNavIcon extends StatelessWidget {
  final IconData? icon;
  final Function()? onTap;
  const BottomNavIcon({Key? key, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: Dimensions.height40,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
