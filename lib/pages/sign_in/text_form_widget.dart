import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    Key? key,
    required this.hint,
    required this.label,
    required this.icon,
    required this.password,
    required this.controller,
    required this.validator,
  }) : super(key: key);
  final String hint;
  final String label;
  final Icon icon;
  final bool password;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: password,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: icon,
        ),
      ),
    );
  }
}
