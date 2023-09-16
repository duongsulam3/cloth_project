import 'package:flutter/material.dart';
import 'package:intern_project/controller/clothing_controller.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/model/men_clothing_model.dart';

class BuildGridTest extends StatelessWidget {
  const BuildGridTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MenClothing>>(
      stream: readAllCloth(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final menCloths = snapshot.data!;
          //print(menCloths.toString());
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // Số items 1 hàng
              crossAxisCount: 2,
              //height per item
              mainAxisExtent: 420,
              // Spacing
              mainAxisSpacing: 10,
              // Spacing
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.height20),
                  topRight: Radius.circular(Dimensions.height20),
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
                      // image: DecorationImage(
                      //   image: AssetImage(
                      //     myProducts[index]["img"],
                      //   ),
                      //   fit: BoxFit.cover,
                      // ),
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
                              menCloths[index].name,
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
                                "${menCloths[index].price} ${menCloths[index].currency}",
                              ),
                              //Text("Sold 3000"),
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
            itemCount: menCloths.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //return Text("data");
      },
    );
  }
}
