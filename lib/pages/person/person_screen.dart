import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intern_project/auth.dart';
import 'package:intern_project/controller/clothing_controller.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/model/user_model.dart';
import 'package:intern_project/pages/components/feature_button.dart';
import 'package:intern_project/pages/person/change_password/change_password_screen.dart';
import 'package:intern_project/pages/person/edit_profile/edit_profile.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: readUser(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Having error to loading: ${snapshot.error}");
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final userData = UserModel.fromJson(data);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            image: user.photoURL == null
                                ? const Svg("assets/icons/person.svg")
                                    as ImageProvider
                                : NetworkImage(user.photoURL.toString()),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.width10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.email.toString()),
                          userData.lastName != null
                              ? Text("Welcome back, ${userData.lastName}")
                              : Text("Welcome back, ${user.displayName}"),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.height20),
                  // Feature buttons
                  FeatureButton(
                      icon: Icons.edit,
                      text: "Edit my profile",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfile(personProfile: userData),
                            ));
                      }),
                  FeatureButton(
                      icon: Icons.password_outlined,
                      text: "Change my password",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordScreen(),
                            ));
                      }),
                  // Sign out button
                  const Spacer(),
                  SizedBox(
                    height: Dimensions.height40,
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
                        style: TextStyle(
                          fontSize: Dimensions.font26,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
