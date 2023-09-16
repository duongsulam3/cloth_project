import 'package:flutter/material.dart';

import '../../dimensions.dart';

class SaleBanner extends StatelessWidget {
  const SaleBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Dimensions.height120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.width20),
        color: const Color(0xffFA919D),
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.width10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SALE UP TO 50%",
              style: TextStyle(
                fontSize: Dimensions.width40,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   "Duy nhất vào ngày 8/8",
            //   style: TextStyle(
            //     fontSize: Dimensions.font26,
            //     fontStyle: FontStyle.italic,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
