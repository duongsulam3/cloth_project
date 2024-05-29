import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:hive/hive.dart';
import 'package:intern_project/dimensions.dart';
import 'package:intern_project/model/user_data_model.dart';
import 'package:intern_project/pages/home/home_page.dart';

class CartConfirmBody extends StatefulWidget {
  final dynamic userData;
  const CartConfirmBody({super.key, this.userData});

  @override
  State<CartConfirmBody> createState() => _CartConfirmBodyState();
}

class _CartConfirmBodyState extends State<CartConfirmBody> {
  // Remove trailing zeros behind a double number
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  //Hive box
  final _cartBox = Hive.box('cart_box');
  List<Map<String, dynamic>> _cart = [];
  List<Map<String, dynamic>> _cartDataToDB = [];
  double totalPrice = 0;
  double feeVAT = 0;

  @override
  void initState() {
    _refreshCart();
    calculatePrice();
    calculateVAT();
    super.initState();
  }

  void _refreshCart() {
    final cartData = _cartBox.keys.map((e) {
      final item = _cartBox.get(e);
      return {
        "key": e,
        'idItem': item['idCloth'],
        'nameItem': item['name'],
        'sizeItem': item['size'],
        'quantityItem': item['qty'],
        'imgItem': item['img'],
        'priceItem': item['price'],
        "totalPriceItem": item['price'],
      };
    }).toList();
    final cartDataToDB = _cartBox.keys.map((e) {
      final item = _cartBox.get(e);
      return {
        'idItem': item['idCloth'],
        'nameItem': item['name'],
        'sizeItem': item['size'],
        'quantityItem': item['qty'],
        'imgItem': item['img'],
        'priceItem': item['price'],
        "totalPriceItem": item['price'],
      };
    }).toList();
    setState(() {
      _cart = cartData.reversed.toList();
      _cartDataToDB = cartDataToDB.reversed.toList();
    });
  }

  double calculatePrice() {
    for (int i = 0; i < _cart.length; i++) {
      totalPrice += _cart[i]['priceItem'];
    }
    return totalPrice;
  }

  double calculateVAT() {
    return feeVAT = totalPrice / 100 * 12;
  }

  Future _deleteCart(int itemKey, int indexPrice) async {
    await _cartBox.delete(itemKey);
    totalPrice = totalPrice - indexPrice;
    _refreshCart();
    calculateVAT();
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = DataUser.fromJson(widget.userData);

    void checkOut() {
      final id =
          FirebaseFirestore.instance.collection("orderWithUser").doc().id;
      final data = {
        "address": dataUser.address,
        "billPrice": totalPrice,
        "cartItems": _cartDataToDB,
        "city": dataUser.city,
        "email": dataUser.email,
        "firstName": dataUser.firstName,
        "lastName": dataUser.lastName,
        "orderID": id,
        "orderStatus": "pending",
        "phoneNumber": dataUser.phone,
        "shipping": 0,
        "userID": dataUser.userID,
      };
      FirebaseFirestore.instance
          .collection("orderWithUser")
          .doc(id)
          .set(data)
          .then((value) => {
                _cartBox.clear(),
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                )
              });
    }

    return Padding(
      padding: EdgeInsets.all(Dimensions.height8),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Giỏ hàng",
              style: TextStyle(
                fontSize: Dimensions.font26,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                final dataCart = _cart[i];
                return Container(
                  padding: EdgeInsets.all(Dimensions.width10),
                  width: Dimensions.screenWidth,
                  height: Dimensions.height200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Ảnh
                      SizedBox(
                        child: AvifImage.network(
                          dataCart['imgItem'],
                          width: Dimensions.width90,
                          height: Dimensions.height90,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: Dimensions.width10),
                      //Infor
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataCart['nameItem'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: Dimensions.height5),
                            Text(
                              "Mã sản phẩm: ${dataCart['idItem']}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: Dimensions.height5),
                            Text(
                              "Kích cỡ: ${dataCart['sizeItem']}",
                              style: TextStyle(
                                fontSize: Dimensions.font16,
                              ),
                            ),
                            SizedBox(height: Dimensions.height5),
                            Text(
                              'Số lượng: ${dataCart['quantityItem']}',
                              style: TextStyle(
                                fontSize: Dimensions.font16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Tạm tính: ${dataCart['priceItem'].toString()} VND",
                              style: TextStyle(
                                fontSize: Dimensions.font16,
                                color: Colors.red,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      //Delete Button
                      SizedBox(width: Dimensions.width50),
                      IconButton(
                        onPressed: () => _deleteCart(
                          dataCart['key'],
                          dataCart['priceItem'],
                        ),
                        icon: const Icon(Icons.highlight_remove_outlined),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, i) => Container(
                height: Dimensions.height10,
                width: Dimensions.screenWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              itemCount: _cart.length,
            ),
            Container(
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hoá đơn",
                      style: TextStyle(
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //separator line
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      height: Dimensions.height10,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sản phẩm(s) tạm tính",
                        ),
                        Text(
                            "${totalPrice.toString().replaceAll(regex, "")} VND"),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      height: Dimensions.height10,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tạm tính:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font16,
                          ),
                        ),
                        Text(
                          "${totalPrice.toString().replaceAll(regex, "")} VND",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      height: Dimensions.height10,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Thuế ( đã tính )",
                        ),
                        Text("${feeVAT.toString().replaceAll(regex, "")} VND"),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      height: Dimensions.height10,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng cộng:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font16,
                          ),
                        ),
                        Text(
                          "${totalPrice.toString().replaceAll(regex, "")} VND",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            Row(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  child: Text(
                    "Huỷ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.font16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent[100],
                    disabledBackgroundColor: Colors.grey,
                  ),
                  onPressed: _cart.isEmpty ? null : checkOut,
                  child: SizedBox(
                    width: Dimensions.width90,
                    child: Center(
                      child: Text(
                        "Thanh toán",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
