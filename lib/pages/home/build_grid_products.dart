import 'package:flutter/material.dart';
import 'package:intern_project/controller/search_provider.dart';
import 'package:provider/provider.dart';

import '../../dimensions.dart';
import '../../model/men_clothing_model.dart';
import '../product_detail/product_detail.dart';
import 'gridview_per_item.dart';

class BuildGridProducts extends StatefulWidget {
  final Stream<List<MenClothing>> products;
  const BuildGridProducts({super.key, required this.products});

  @override
  State<BuildGridProducts> createState() => _BuildGridProductsState();
}

class _BuildGridProductsState extends State<BuildGridProducts> {
  @override
  Widget build(BuildContext context) {
    final products = widget.products;
    final searchProvider = Provider.of<SearchProvider>(context);
    return StreamBuilder<List<MenClothing>>(
      stream: products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (searchProvider.searchText.isEmpty) {
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
            final menCloths = snapshot.data!
                .where((e) => e.name
                    .toLowerCase()
                    .contains(searchProvider.searchText.toLowerCase()))
                .toList();
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
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
