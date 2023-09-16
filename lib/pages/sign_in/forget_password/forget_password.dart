import 'package:flutter/material.dart';

import 'forget_password_body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forgetPassword";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("Forget Password"),
      // ),
      body: ForgetPassBody(),
    );
  }
}
