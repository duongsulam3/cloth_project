import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intern_project/dimensions.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key? key, required this.img, required this.onTap})
      : super(key: key);
  final String img;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.height5),
        height: Dimensions.height40,
        width: Dimensions.width40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(img),
      ),
    );
  }
}
