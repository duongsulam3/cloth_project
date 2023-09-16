import 'package:flutter/material.dart';
import 'package:intern_project/pages/home/home_page.dart';
import 'package:intern_project/pages/splash/splash_content_pageview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dimensions.dart';
import 'list_data_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(
                    () {
                      curIndex = value;
                    },
                  );
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  text: splashData[index]["text"].toString(),
                  img: splashData[index]["img"].toString(),
                ),
              ),
            ),
            Expanded(
              //flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  splashData.length,
                  (index) => buildDot(index),
                ),
              ),
            ),
            const Spacer(flex: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.height40),
              height: Dimensions.height50,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                  ),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("showHome", true);
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: Dimensions.font26,
                    color: Colors.white,
                    //fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: Dimensions.width5),
      height: Dimensions.height5,
      width: curIndex == index ? Dimensions.width20 : Dimensions.height5,
      decoration: BoxDecoration(
        color: curIndex == index ? Colors.red : Colors.black,
        borderRadius: BorderRadius.circular(Dimensions.height10),
      ),
    );
  }
}
