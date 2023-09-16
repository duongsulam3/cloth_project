import 'package:flutter/widgets.dart';

class AlignLeftText extends StatelessWidget {
  final String text;
  final double size;

  const AlignLeftText({
    Key? key,
    required this.text,
    this.size = 26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        maxLines: 2,
        style: TextStyle(
          fontSize: size,
        ),
      ),
    );
  }
}
