import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_project/pages/home/home_page.dart';

import '../../dimensions.dart';
import '../sign_in/text_form_widget.dart';

class FormBodySignUp extends StatefulWidget {
  const FormBodySignUp({Key? key}) : super(key: key);

  @override
  State<FormBodySignUp> createState() => _FormBodySignUpState();
}

class _FormBodySignUpState extends State<FormBodySignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _handleSignUp() async {
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
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
            const Text("Sign up with your email and password"),
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
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              height: Dimensions.height50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //backgroundColor: Colors.red,
                  //foregroundColor: Colors.red,
                  //disabledBackgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                  ),
                ),
                onPressed: _handleSignUp,
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: Dimensions.font26,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
