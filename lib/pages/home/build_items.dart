import 'package:flutter/material.dart';

import 'build_grid_products.dart';

class BuildItems extends StatelessWidget {
  BuildItems({Key? key}) : super(key: key);
  final List<Map> myProducts = List.generate(
    50,
    (index) => {
      "id": index,
      "img": "assets/images/model1.jpg",
      "name": "Product ${index + 1}",
      "price": 300000,
      "currency": "VND",
    },
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BuildGridProducts(),
    );
  }

  Widget buildGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //width per item
        maxCrossAxisExtent: 200,
        //height per item
        mainAxisExtent: 100,
        // Spacing vertical
        crossAxisSpacing: 10,
        // Spacing horizontal
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          myProducts[index]["name"],
        ),
      ),
      itemCount: myProducts.length,
    );
  }

  Widget buildGrid2() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Số items 1 hàng
        crossAxisCount: 2,
        //height per item
        mainAxisExtent: 380,
        // Spacing
        mainAxisSpacing: 10,
        // Spacing
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            Container(
              height: 250,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                    myProducts[index]["img"],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
            // Mô tả sản phẩm
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        myProducts[index]["name"],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${myProducts[index]["price"]} ${myProducts[index]["currency"]}",
                        ),
                        const Text("Sold 3000"),
                      ],
                    ),
                    const Spacer(),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Text("Sell 50%"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      itemCount: myProducts.length,
    );
  }
}
