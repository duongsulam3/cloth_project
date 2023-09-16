import 'package:flutter/material.dart';

class ListImgView extends StatefulWidget {
  const ListImgView({Key? key}) : super(key: key);

  @override
  State<ListImgView> createState() => _ListImgViewState();
}

class _ListImgViewState extends State<ListImgView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 500,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/model1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        "Data",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
