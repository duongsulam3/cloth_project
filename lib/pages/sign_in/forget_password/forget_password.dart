import 'package:flutter/material.dart';

import '../../../dimensions.dart';
import 'forget_password_body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forgetPassword";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Forget Password",
          style: TextStyle(fontSize: Dimensions.font26),
        ),
      ),
      body: const ForgetPassBody(),
    );
  }
}
