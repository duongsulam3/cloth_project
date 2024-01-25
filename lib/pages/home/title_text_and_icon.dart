import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_project/dimensions.dart';

class TitleTextAndIcon extends StatelessWidget {
  final String text;
  final Icon icon;
  const TitleTextAndIcon({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: Dimensions.height20,
              ),
            ),
          ),
          icon,
        ],
      ),
    );
  }
}
