import 'package:flutter/material.dart';
import 'package:intern_project/pages/sign_in/text_form_widget.dart';
import 'package:intern_project/pages/sign_up/sign_up_screen.dart';

import '../../../dimensions.dart';

class ForgetPassBody extends StatefulWidget {
  const ForgetPassBody({Key? key}) : super(key: key);

  @override
  State<ForgetPassBody> createState() => _ForgetPassBodyState();
}

class _ForgetPassBodyState extends State<ForgetPassBody> {
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.height180),
            const Text(
                "Please fill your email in the input below to find password"),
            SizedBox(height: Dimensions.height20),
            TextFormWidget(
              hint: "Enter your email",
              label: "Email",
              icon: const Icon(Icons.mail),
              password: false,
              controller: _email,
            ),
            SizedBox(height: Dimensions.height200),
            SizedBox(
              width: double.maxFinite,
              height: Dimensions.height50,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.height20),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                        fontSize: Dimensions.font26, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an accout ? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
