import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_project/auth.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/home/home_page.dart';
import 'package:intern_project/pages/sign_in/text_form_widget.dart';

class ChangePasswordBody extends StatefulWidget {
  final dynamic user;
  const ChangePasswordBody({super.key, required this.user});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentPassword = _currentPassword.value.text;
    final newPassword = _newPassword.value.text;
    final confirmPassword = _confirmPassword.value.text;
    final currentUser = FirebaseAuth.instance.currentUser;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(widget.user.userID);

    Future<void> updatePassword() async {
      if (currentUser != null) {
        final data = {
          "password": newPassword,
        };
        currentUser
            .reauthenticateWithCredential(
              EmailAuthProvider.credential(
                email: currentUser.email.toString(),
                password: currentPassword,
              ),
            )
            .then(
              (value) => currentUser.updatePassword(newPassword).then(
                    (value) => documentReference.update(data).then(
                          (value) => Auth()
                              .signOut()
                              .then(
                                (value) =>
                                    Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                  (context) => false,
                                ),
                              )
                              .whenComplete(() => const AlertDialog(
                                    title: Text("Updated password"),
                                  )),
                        ),
                  ),
            );
      }
    }

    void validatePassword() {
      if (currentPassword.isEmpty &&
          newPassword.isEmpty &&
          confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all the field on screen!!"),
          ),
        );
        Navigator.of(context).pop();
        return;
      } else if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("New password isn't correct, please check again!!"),
          ),
        );
        Navigator.of(context).pop();
        return;
      } else if (currentPassword != widget.user.password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password isn't correct, please check again!!"),
          ),
        );
        Navigator.of(context).pop();
        return;
      } else {
        updatePassword();
      }
    }

    return Padding(
      padding: EdgeInsets.all(Dimensions.height8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CHANGE MY PASSWORD",
            style: TextStyle(
              fontSize: Dimensions.font26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormWidget(
            hint: "Password",
            label: "Current password",
            icon: const Icon(Icons.password),
            password: true,
            controller: _currentPassword,
          ),
          TextFormWidget(
            hint: "Password",
            label: "New password",
            icon: const Icon(Icons.password),
            password: true,
            controller: _newPassword,
          ),
          TextFormWidget(
            hint: "New password",
            label: "Confirm new password",
            icon: const Icon(Icons.password),
            password: true,
            controller: _confirmPassword,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Update password"),
                              content: const Text(
                                "Are you sure to change your password",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: validatePassword,
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("No"),
                                )
                              ],
                            ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Save"),
                ),
                SizedBox(width: Dimensions.width10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
