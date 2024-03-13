import 'package:flutter/material.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/sign_in/text_form_widget.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Update profile"),
                              content: const Text(
                                  "Your profile data will be remove permanently"),
                              actions: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("OK"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
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
