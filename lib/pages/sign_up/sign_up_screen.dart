import 'package:flutter/material.dart';
import 'package:intern_project/pages/sign_up/sign_up_body.dart';

import '../../dimensions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static String routeName = "/sign-up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sign up",
          style: TextStyle(fontSize: Dimensions.font26),
        ),
      ),
      //resizeToAvoidBottomInset: false,
      body: const FormBodySignUp(),
    );
  }
}
