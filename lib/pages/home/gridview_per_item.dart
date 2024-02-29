import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:intern_project/dimensions.dart';

class GridViewPerItem extends StatelessWidget {
  final String imgCloth;
  final String nameCloth;
  final int price;
  final int oldPrice;
  final String currency;
  final String sale;
  final int sold;
  final Function()? onTap;

  const GridViewPerItem({
    Key? key,
    required this.imgCloth,
    required this.nameCloth,
    required this.oldPrice,
    required this.currency,
    required this.sale,
    required this.sold,
    required this.price,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
              height: Dimensions.height180,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(Dimensions.height20),
                image: DecorationImage(
                  image: NetworkAvifImage(imgCloth),
                  fit: BoxFit.fill,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              ),
            ),
            // Mô tả sản phẩm
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    // Tên sản phẩm
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        nameCloth,
                        maxLines: 3,
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Dimensions.font26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Giá gốc & sold
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$oldPriceđ",
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          "Sold $sold",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    //Giá KM & sale
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$priceđ",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: Dimensions.font26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Sale $sale",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
