import 'package:flutter/material.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/sign_in/sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign-in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Đăng nhập",
          style: TextStyle(fontSize: Dimensions.font26),
        ),
      ),
      //resizeToAvoidBottomInset: false,
      body: const FormBody(),
    );
  }
}
