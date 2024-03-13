import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../dimensions.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({Key? key, required this.icon, this.onTap})
      : super(key: key);

  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.width10),
        height: Dimensions.width40,
        width: Dimensions.height40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffEFC76F),
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      ),
    );
  }
}
