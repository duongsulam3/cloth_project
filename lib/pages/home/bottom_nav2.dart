import 'package:flutter/material.dart';
import 'package:intern_project/controller/mainscreen_provider.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/home/bottom_nav_icon.dart';
import 'package:provider/provider.dart';

class BottomNav2 extends StatefulWidget {
  const BottomNav2({Key? key}) : super(key: key);

  @override
  State<BottomNav2> createState() => _BottomNav2State();
}

class _BottomNav2State extends State<BottomNav2> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotification>(
        builder: (context, mainScreenNotification, child) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.width10),
          child: Container(
            padding: EdgeInsets.all(Dimensions.width10),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(Dimensions.height20),
            ),
            child: Row(
              children: [
                const Spacer(),
                BottomNavIcon(
                  icon: mainScreenNotification.pageIndex == 0
                      ? Icons.home
                      : Icons.home_outlined,
                  onTap: () {
                    mainScreenNotification.pageIndex = 0;
                  },
                ),
                const Spacer(),
                BottomNavIcon(
                  icon: mainScreenNotification.pageIndex == 1
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  onTap: () {
                    mainScreenNotification.pageIndex = 1;
                  },
                ),
                const Spacer(),
                BottomNavIcon(
                  icon: mainScreenNotification.pageIndex == 2
                      ? Icons.person
                      : Icons.person_outline,
                  onTap: () {
                    mainScreenNotification.pageIndex = 2;
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
