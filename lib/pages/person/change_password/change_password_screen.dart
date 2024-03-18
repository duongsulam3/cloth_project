import 'package:flutter/material.dart';
import 'package:intern_project/pages/person/change_password/change_password_body.dart';

import '../../../dimensions.dart';

class ChangePasswordScreen extends StatelessWidget {
  final dynamic user;
  const ChangePasswordScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Change my password",
          style: TextStyle(
            fontSize: Dimensions.font26,
          ),
        ),
      ),
      body: ChangePasswordBody(user: user),
    );
  }
}
