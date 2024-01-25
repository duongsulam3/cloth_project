import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_project/auth.dart';
import 'package:intern_project/dimensions.dart';

import 'package:intern_project/pages/components/feature_button.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Information
            Row(
              children: [
                Container(
                  width: Dimensions.width50,
                  height: Dimensions.height50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        user!.photoURL == null
                            ? "https://firebasestorage.googleapis.com/v0/b/shopping-app-flutter-8f35d.appspot.com/o/images%2Ficons%2Fperson-icon.png?alt=media&token=894bb824-7df2-429c-9b8a-a3332f9a4294"
                            : user.photoURL.toString(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, ${user.email}"),
                    user.displayName == null
                        ? const Text("Your name by default")
                        : Text(user.displayName.toString()),
                  ],
                ),
              ],
            ),
            // Feature buttons
            const FeatureButton(
              icon: Icons.edit,
              text: "Edit Profile",
            ),
            const FeatureButton(
              icon: Icons.favorite_outline,
              text: "My Favorite",
            ),
            const FeatureButton(
              icon: Icons.shopping_cart_rounded,
              text: "My Cart",
            ),
            // Sign out button
            SizedBox(
              height: Dimensions.height50,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffEFC76F)),
                ),
                onPressed: () {
                  Auth().signOut();
                },
                child: Text(
                  "Sign out",
                  style: TextStyle(fontSize: Dimensions.font26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
