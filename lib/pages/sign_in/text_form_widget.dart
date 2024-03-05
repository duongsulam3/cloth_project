import 'package:flutter/material.dart';
import 'package:intern_project/dimensions.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    Key? key,
    required this.hint,
    required this.label,
    required this.icon,
    required this.password,
    required this.controller,
  }) : super(key: key);
  final String hint;
  final String label;
  final Icon icon;
  final bool password;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.width10),
      child: TextFormField(
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height20),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: icon,
        ),
      ),
    );
  }
}
