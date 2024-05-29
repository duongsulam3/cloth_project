import 'package:flutter/material.dart';
import 'package:intern_project/controller/search_provider.dart';
import 'package:provider/provider.dart';

import '../../dimensions.dart';
import '../cart/cart_page.dart';
import '../components/icon_button.dart';
import 'categories.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final TextEditingController mySearchController = TextEditingController();

  @override
  void dispose() {
    mySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

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
                    //textAlignVertical: TextAlignVertical.center,
                    controller: mySearchController,
                    //undoController: UndoHistoryController(),
                    onChanged: (value) {
                      searchProvider.updateProductList(value);
                      setState(() {
                        mySearchController.value.text;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: Dimensions.height9),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                      hintText: "Tìm kiếm: Shirt, Pant,...",
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
