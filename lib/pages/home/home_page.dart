import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_project/controller/mainscreen_provider.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/home/home_screen_body.dart';
import 'package:intern_project/pages/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';

import '../favorite/fav_screen.dart';
import '../person/person_screen.dart';
import 'bottom_nav2.dart';
import 'home_header.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> _pageList = const [
    HomeScreenBody(),
    FavScreen(),
    PersonScreen(),
  ];
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<MainScreenNotification>(
                builder: (context, mainScreenNotification, child) {
              return Scaffold(
                bottomNavigationBar: const BottomNav2(),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Dimensions.height200),
                  child: const HomeHeader(),
                ),
                body: _pageList[mainScreenNotification.pageIndex],
              );
            });
          } else {
            return const SignInScreen();
          }
        });
  }
}
