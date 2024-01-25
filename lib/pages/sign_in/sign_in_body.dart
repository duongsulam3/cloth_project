import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  void signInGoogle() async {
    //print("Sign in with Google");
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          print(e);
        } catch (e) {
          //print(e);
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      //print(e);
    }
  }

  void signinFacebook() {
    //print("Sign in Facebook");
  }

  void signinTwitter() {
    //print("Sign in Twitter");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.height40,
              ),
              Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: Dimensions.font36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              const Text("Sign in with your email and password"),
              SizedBox(
                height: Dimensions.height70,
              ),
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
              SizedBox(
                height: Dimensions.height10,
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
              SizedBox(
                height: Dimensions.height10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CheckBoxAndText(
                    text: "Remember me",
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordScreen(),
                      ),
                    ),
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
              SizedBox(
                height: Dimensions.height40,
              ),
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
              SizedBox(
                height: Dimensions.height40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    img: "assets/icons/google-icon.svg",
                    onTap: () => signInGoogle(),
                  ),
                  SizedBox(
                    width: Dimensions.width40,
                  ),
                  SocialCard(
                    img: "assets/icons/facebook-2.svg",
                    onTap: () => signinFacebook(),
                  ),
                  SizedBox(
                    width: Dimensions.width40,
                  ),
                  SocialCard(
                    img: "assets/icons/twitter.svg",
                    onTap: () => signinTwitter(),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.height40,
              ),
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
              //const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
