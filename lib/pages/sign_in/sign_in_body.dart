import 'package:flutter/material.dart';
import 'package:intern_project/auth.dart';
import 'package:intern_project/pages/components/checkbox_and_text.dart';
import 'package:intern_project/pages/components/social_card.dart';
import 'package:intern_project/pages/sign_in/forget_password/forget_password.dart';
import 'package:intern_project/pages/sign_in/text_form_widget.dart';
import 'package:intern_project/pages/sign_up/sign_up_screen.dart';

import '../../dimensions.dart';

class FormBody extends StatefulWidget {
  const FormBody({Key? key}) : super(key: key);

  @override
  State<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final _formKey = GlobalKey<FormState>();
  bool remember = true;

  _handleLogin() async {
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    await Auth().signInEmailAndPassword(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Spacer(),
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: Dimensions.font36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("Sign in with your email and password"),
            const Spacer(),
            TextFormWidget(
              password: false,
              hint: "Enter your email here",
              label: "Email",
              icon: const Icon(Icons.mail),
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the empty fields";
                }
                return null;
              },
            ),
            TextFormWidget(
              password: true,
              hint: "Enter your password here",
              label: "Password",
              icon: const Icon(Icons.lock),
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the empty fields";
                }
                return null;
              },
            ),
            Row(
              children: [
                const CheckBoxAndText(
                  text: "Remember me",
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgetPasswordScreen.routeName),
                  child: Text(
                    "Forget password?",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: Dimensions.font14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              height: Dimensions.height50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                  ),
                ),
                onPressed: _handleLogin,
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: Dimensions.font26,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SocialCard(
                  img: "assets/icons/google-icon.svg",
                ),
                SizedBox(
                  width: Dimensions.width40,
                ),
                const SocialCard(
                  img: "assets/icons/facebook-2.svg",
                ),
                SizedBox(
                  width: Dimensions.width40,
                ),
                const SocialCard(
                  img: "assets/icons/twitter.svg",
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(width: Dimensions.height5),
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
                    style: TextStyle(color: Colors.blue),
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
