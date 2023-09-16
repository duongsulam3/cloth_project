import 'package:flutter/material.dart';

class CheckBoxAndText extends StatefulWidget {
  final String text;
  const CheckBoxAndText({Key? key, required this.text}) : super(key: key);

  @override
  State<CheckBoxAndText> createState() => _CheckBoxAndTextState();
}

class _CheckBoxAndTextState extends State<CheckBoxAndText> {
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: remember,
          onChanged: (value) {
            setState(() {
              remember = value!;
            });
          },
        ),
        Text(
          widget.text,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            // decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
