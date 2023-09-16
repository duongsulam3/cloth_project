import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../dimensions.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard(
      {Key? key, required this.icon, required this.text, required this.press})
      : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: Dimensions.height50,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffEFC76F),
                ),
                child: SvgPicture.asset(icon),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
