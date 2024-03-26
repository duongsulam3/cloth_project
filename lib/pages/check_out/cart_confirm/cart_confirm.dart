import 'package:flutter/material.dart';
import 'package:intern_project/dimensions.dart';

import 'cart_confirm_body.dart';

class CartConfirmPage extends StatelessWidget {
  final dynamic userData;
  const CartConfirmPage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: Dimensions.font26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CartConfirmBody(userData: userData),
    );
  }
}
