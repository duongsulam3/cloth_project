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
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(
              "Forget Password",
              style: TextStyle(
                fontSize: Dimensions.font36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            const Text(
                "Please fill your email in the input below to find password"),
            const Spacer(),
            TextFormWidget(
              hint: "Enter your email",
              label: "Email",
              icon: const Icon(Icons.mail),
              password: false,
              controller: _email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the empty fields";
                }
                return null;
              },
            ),
            const Spacer(flex: 2),
            SizedBox(
              width: double.maxFinite,
              height: Dimensions.height50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "CLICK HERE TO CONTINUE",
                  style: TextStyle(
                    fontSize: Dimensions.font14,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an accout ? "),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, SignUpScreen.routeName),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
