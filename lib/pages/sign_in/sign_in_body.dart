import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intern_project/auth.dart';
import 'package:intern_project/pages/components/social_card.dart';
import 'package:intern_project/pages/sign_in/forget_password/forget_password.dart';
import 'package:intern_project/pages/sign_in/text_form_widget.dart';
import 'package:intern_project/pages/sign_up/sign_up_screen.dart';

import '../../dimensions.dart';
import '../components/checkbox_and_text.dart';

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
    if (email.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is empty! Please check again!"),
        ),
      );
    } else if (password.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is empty! Please check again!"),
        ),
      );
    } else {
      await Auth().signInEmailAndPassword(email, password).onError(
          (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(error.toString()),
                ),
              ));
    }
  }

  void signInGoogle() async {
    //print("Sign in with Google");
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        // try {} on FirebaseAuthException catch (e) {
        //   //print(e);
        // } catch (e) {
        //   //print(e);
        // }
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // void signingFacebook() {
  //   //print("Sign in Facebook");
  // }
  //
  // void signingTwitter() {
  //   //print("Sign in Twitter");
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height8),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height40),
              Text(
                "Xin chào",
                style: TextStyle(
                  fontSize: Dimensions.font36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.height10),
              const Text("Điền thông tin Email và mật khẩu bên dưới"),
              SizedBox(height: Dimensions.height70),
              TextFormWidget(
                password: false,
                hint: "Nhập email vào đây",
                label: "Email",
                icon: const Icon(Icons.mail),
                controller: _emailController,
              ),
              SizedBox(height: Dimensions.height10),
              TextFormWidget(
                password: true,
                hint: "Nhập mật khẩu vào đây",
                label: "Mật khẩu",
                icon: const Icon(Icons.lock),
                controller: _passwordController,
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CheckBoxAndText(
                    text: "Ghi nhớ tôi",
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordScreen(),
                      ),
                    ),
                    child: Text(
                      "Quên mật khẩu?",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: Dimensions.font14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height40),
              SizedBox(
                width: double.maxFinite,
                height: Dimensions.height50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.height20),
                    ),
                  ),
                  onPressed: _handleLogin,
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: Dimensions.font26,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    img: "assets/icons/google-icon.svg",
                    onTap: () => signInGoogle(),
                  ),
                  // SizedBox(width: Dimensions.width40),
                  // SocialCard(
                  //   img: "assets/icons/facebook-2.svg",
                  //   onTap: () => signinFacebook(),
                  // ),
                  // SizedBox(width: Dimensions.width40),
                  // SocialCard(
                  //   img: "assets/icons/twitter.svg",
                  //   onTap: () => signinTwitter(),
                  // ),
                ],
              ),
              SizedBox(height: Dimensions.height40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Không có tài khoản?",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      //decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(width: Dimensions.width5),
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
                      "Đăng ký",
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
