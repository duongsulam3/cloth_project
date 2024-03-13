import 'package:flutter/material.dart';

import '../../dimensions.dart';
import '../../model/men_clothing_model.dart';
import '../product_detail/product_detail.dart';
import 'gridview_per_item.dart';

class BuildGridProducts extends StatelessWidget {
  final Stream<List<MenClothing>>? products;
  const BuildGridProducts({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final menCloths = snapshot.data!;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // Số items 1 hàng
              crossAxisCount: 2,
              //height per item
              mainAxisExtent: Dimensions.height420,
              // Spacing
              mainAxisSpacing: Dimensions.height10,
              // Spacing
              crossAxisSpacing: Dimensions.width10,
            ),
            itemBuilder: (context, index) {
              final menCloth = menCloths[index];
              return GridViewPerItem(
                imgCloth: menCloth.img[0],
                nameCloth: menCloth.name,
                price: menCloth.price,
                oldPrice: menCloth.oldPrice,
                currency: menCloth.currency,
                sale: menCloth.sale,
                sold: menCloth.sold,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(myCloth: menCloth),
                    ),
                  );
                },
              );
            },
            itemCount: menCloths.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
