import 'package:flutter/material.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/check_out/check_out_body.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Information",
          style: TextStyle(
            fontSize: Dimensions.font26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const CheckOutBody(),
    );
  }
}
