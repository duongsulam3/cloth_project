import 'package:flutter/material.dart';
import 'package:intern_project/pages/person/change_password/change_password_body.dart';

import '../../../dimensions.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
      body: const ChangePasswordBody(),
    );
  }
}
