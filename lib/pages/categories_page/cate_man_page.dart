import 'package:flutter/material.dart';
import 'package:intern_project/controller/clothing_controller.dart';
import 'package:intern_project/dimensions.dart';

import '../home/build_grid_product_cate.dart';

class CateListScreen extends StatelessWidget {
  const CateListScreen({
    Key? key,
    this.cFromCategories,
    required this.index,
  }) : super(key: key);

  final dynamic cFromCategories;
  final int index;
  static String routeName = "/cateMan";

  @override
  Widget build(BuildContext context) {
    String cateName = cFromCategories[index]["text"];
    String cateNameVi = cFromCategories[index]["textVI"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          cateNameVi,
          style: TextStyle(
            fontSize: Dimensions.font26,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.height10),
            BuildGridProductsCate(
              products: readCategoryCloth(cateName.toLowerCase()),
            ),
          ],
        ),
      ),
    );
  }
}
