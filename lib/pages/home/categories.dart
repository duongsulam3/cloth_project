import 'package:flutter/material.dart';
import 'package:intern_project/pages/categories_page/cate_man_page.dart';
import 'package:intern_project/pages/home/categories_card.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/man-categories.svg",
        "text": "men",
        "textVI": "Nam",
        "id": 1,
      },
      {
        "icon": "assets/icons/women-clothing-categories.svg",
        "text": "women",
        "textVI": "Nữ",
        "id": 2,
      },
      {
        "icon": "assets/icons/kids.svg",
        "text": "kid",
        "textVI": "Trẻ em",
        "id": 3,
      },
      {
        "icon": "assets/icons/baby.svg",
        "text": "baby",
        "textVI": "Nam",
        "id": 4,
      },
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          categories.length,
          (index) => CategoriesCard(
            icon: categories[index]["icon"],
            text: categories[index]["textVI"],
            press: () {
              // debugPrint(
              //   categories[index]["id"].toString(),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CateListScreen(
                    index: index,
                    cFromCategories: categories,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
