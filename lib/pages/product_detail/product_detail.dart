import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/clothing_controller.dart';
import '../../dimensions.dart';
import '../cart/cart_page.dart';

class ProductDetail extends StatefulWidget {
  final dynamic myCloth;

  const ProductDetail({Key? key, required this.myCloth}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  // TODO: implement widget
  String defaultSize = "L";
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');
  int activeIndex = 0;
  PageController pageController = PageController();

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  Future<void> _createFav(Map<String, dynamic> newFav) async {
    await _favBox.add(newFav);
  }

  @override
  Widget build(BuildContext context) {
    //var productNotifier = Provider.of<ProductNotifier>(context);
    return StreamBuilder(
      stream: readAllClothSize(widget.myCloth.idCloth),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final dataSizes = snapshot.data!;
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  //Hình ảnh
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: Dimensions.height420,
                    // Ảnh
                    child: Container(
                      //width: double.maxFinite,
                      color: Colors.grey,
                      child: PageView.builder(
                          itemCount: widget.myCloth.img.length,
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          onPageChanged: (pageIndex) =>
                              setState(() => activeIndex = pageIndex),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: double.maxFinite,
                              child: AvifImage.network(
                                widget.myCloth.img[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    top: Dimensions.height320,
                    left: 0,
                    right: 0,
                    child: Container(
                      //color: Colors.red,
                      alignment: Alignment.center,
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: widget.myCloth.img.length,
                        effect: CustomizableEffect(
                          dotDecoration: const DotDecoration(
                            width: 12,
                            height: 6,
                            color: Colors.black,
                            dotBorder: DotBorder(
                              padding: 1,
                              width: 1,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(1),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(1),
                            ),
                            verticalOffset: 0,
                          ),
                          spacing: 6.0,
                          activeDotDecoration: DotDecoration(
                            width: Dimensions.width10,
                            height: Dimensions.height10,
                            color: const Color(0xffEFC76F),
                            borderRadius:
                                BorderRadius.circular(Dimensions.height20),
                            dotBorder: const DotBorder(
                              padding: 1,
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Sản phẩm
                  Positioned(
                    top: Dimensions.height350,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(
                                0, -1), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.height20),
                          topLeft: Radius.circular(Dimensions.height20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height5,
                          right: Dimensions.width10,
                          left: Dimensions.width10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Cloth name
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.myCloth.name,
                                style: TextStyle(
                                  fontSize: Dimensions.font26,
                                ),
                              ),
                            ),
                            //SizedBox(height: Dimensions.height10),
                            Flexible(
                              child: Text(
                                widget.myCloth.description,
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            //SizedBox(height: Dimensions.height10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Selected size: $defaultSize",
                                style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                    fontSize: Dimensions.font14,
                                  ),
                                ),
                              ),
                            ),
                            //SizedBox(height: Dimensions.height10),
                            // Sizes
                            SizedBox(
                              height: Dimensions.height50,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  // Container with size
                                  final menSize = dataSizes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // productNotifier.clothSizeSelected = data;
                                      //print(productNotifier.clothSizeSelected);
                                      setState(() {
                                        defaultSize = menSize.size;
                                      });
                                    },
                                    child: Container(
                                      width: Dimensions.width50,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            menSize.size,
                                            softWrap: false,
                                            style: GoogleFonts.abel(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: Dimensions.font26,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: Dimensions.width10),
                                itemCount: dataSizes.length,
                              ),
                            ),
                            //SizedBox(height: Dimensions.height10),
                            //Prices
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Old Price
                                Text(
                                  "${widget.myCloth.oldPrice.toString()}đ",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: Dimensions.font14,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10),
                                // Sale Price
                                Text(
                                  "${widget.myCloth.price.toString()}đ",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: Dimensions.font26,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const Spacer(),
                                Text("Sale: ${widget.myCloth.sale}"),
                                const Spacer(),
                              ],
                            ),
                            //SizedBox(height: Dimensions.height10),
                            //Rating
                            Row(
                              children: [
                                Text(
                                  "Rating: ",
                                  style: TextStyle(
                                    fontSize: Dimensions.font14,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                // list star rating
                                RatingBar.builder(
                                  itemSize: Dimensions.height20,
                                  initialRating: 5,
                                  minRating: 1,
                                  allowHalfRating: true,
                                  maxRating: 5,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.pink,
                                  ),
                                  onRatingUpdate: (double value) {},
                                ),
                                SizedBox(width: Dimensions.width10),
                                Text(
                                  "5000 rated",
                                  style: TextStyle(
                                    fontSize: Dimensions.font14,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(Dimensions.height5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Button add to cart
                                  GestureDetector(
                                    onTap: () {
                                      //print(size);
                                      _createCart({
                                        'idCloth': widget.myCloth.idCloth,
                                        'name': widget.myCloth.name,
                                        'category': widget.myCloth.category,
                                        'size': defaultSize,
                                        'img': widget.myCloth.img[0],
                                        'price': widget.myCloth.price,
                                        'qty': 1,
                                      });
                                      //print(widget.myCloth.idCloth);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: Dimensions.height70,
                                      width: Dimensions.width280,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.height10,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Add to cart",
                                          style: TextStyle(
                                            fontSize: Dimensions.font26,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //Button add to favorite
                                  GestureDetector(
                                    onTap: () {
                                      _createFav({
                                        'idCloth': widget.myCloth.idCloth,
                                        'name': widget.myCloth.name,
                                        'category': widget.myCloth.category,
                                        'img': widget.myCloth.img[0],
                                        'price': widget.myCloth.price,
                                        'oldPrice': widget.myCloth.oldPrice,
                                        'sale': widget.myCloth.sale,
                                      });
                                      //print(_favBox.length);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: Dimensions.height70,
                                      width: Dimensions.width70,
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.favorite_outline,
                                        size: Dimensions.font36,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Icons Appbar
                  Positioned(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: Dimensions.font36,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: Dimensions.font36,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
