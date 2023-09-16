import 'package:flutter/material.dart';

import '../../dimensions.dart';
import '../cart/cart_page.dart';
import '../components/icon_button.dart';
import 'categories.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.height10,
        bottom: Dimensions.height10,
        left: Dimensions.width10,
        right: Dimensions.width10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.height20),
          bottomRight: Radius.circular(Dimensions.height20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Dimensions.width70percent,
                height: Dimensions.height50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.width20),
                  color: const Color(0xffEFC76F),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                      hintText: "Search here...",
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const IconContainer(
                icon: "assets/icons/Bell.svg",
                onTap: null,
              ),
              IconContainer(
                icon: "assets/icons/Cart Icon.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: Dimensions.height20),
          const Categories(),
        ],
      ),
    );
  }
}
