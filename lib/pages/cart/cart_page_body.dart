import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/pages/check_out/check_out.dart';

class CartPageBody extends StatefulWidget {
  const CartPageBody({Key? key}) : super(key: key);

  @override
  State<CartPageBody> createState() => _CartPageBodyState();
}

class _CartPageBodyState extends State<CartPageBody> {
  // Remove trailing zeros behind a double number
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  //Create Hive named cartBox
  final _cartBox = Hive.box('cart_box');
  List<Map<String, dynamic>> _cart = [];
  double totalPrice = 0;

  @override
  void initState() {
    _refreshCart();
    calculatePrice();
    super.initState();
  }

  void _refreshCart() {
    final cartData = _cartBox.keys.map((e) {
      final item = _cartBox.get(e);
      return {
        'key': e,
        'idCloth': item['idCloth'],
        'category': item['category'],
        'name': item['name'],
        'size': item['size'],
        'qty': item['qty'],
        'img': item['img'],
        'price': item['price'],
      };
    }).toList();
    setState(() {
      _cart = cartData.reversed.toList();
    });
  }

  Future<void> _deleteCart(int itemKey, int indexPrice) async {
    await _cartBox.delete(itemKey);
    totalPrice = totalPrice - indexPrice;
    _refreshCart();
  }

  double calculatePrice() {
    for (int i = 0; i < _cart.length; i++) {
      totalPrice += _cart[i]['price'];
    }
    return totalPrice;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _refreshCart();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Dimensions.height8),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.height40),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: Dimensions.font36,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    "Giỏ hàng của tôi",
                    style: TextStyle(
                      fontSize: Dimensions.font36,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final dataCart = _cart[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.height10),
                          ),
                          child: Slidable(
                            key: ValueKey(dataCart['key']),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) => _deleteCart(
                                    dataCart['key'],
                                    dataCart['price'],
                                  ),
                                  backgroundColor: const Color(0xFF000000),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: "Xoá",
                                ),
                              ],
                            ),
                            child: Container(
                              height: Dimensions.height120,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Ảnh
                                  SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        Dimensions.height10,
                                      ),
                                      child: AvifImage.network(
                                        dataCart['img'],
                                        width: Dimensions.width90,
                                        height: Dimensions.height90,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  // Mô tả
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            dataCart['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                "Giá: ${dataCart['price']} VND")),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "Kích cỡ: ${dataCart['size']}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(Dimensions.height8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          color: Colors.grey,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              Dimensions.height8,
                                            ),
                                            child: Text(
                                              dataCart['qty'].toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
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
                        );
                      },
                      itemCount: _cart.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: Dimensions.height10),
                    ),
                  ),
                  //Spacer(),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.height8),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: Dimensions.height70,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[100],
                        ),
                        onPressed: totalPrice == 0
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CheckOutScreen(),
                                  ),
                                );
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tổng cộng: ",
                              style: TextStyle(
                                fontSize: Dimensions.font26,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${totalPrice.toString().replaceAll(regex, "")} VND",
                              style: TextStyle(
                                fontSize: Dimensions.font26,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
