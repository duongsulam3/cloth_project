import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../dimensions.dart';
import '../cart/align_left_text.dart';

class FavPageBody extends StatefulWidget {
  final dynamic myCloth;
  const FavPageBody({Key? key, this.myCloth}) : super(key: key);

  @override
  State<FavPageBody> createState() => _FavPageBodyState();
}

class _FavPageBodyState extends State<FavPageBody> {
  final _favBox = Hive.box('fav_box');
  List<Map<String, dynamic>> _favCloths = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshFav();
  }

  // void _loadFavFromDB() {
  //   _favBox.add(value)
  // }

  void _refreshFav() {
    final favData = _favBox.keys.map((e) {
      final item = _favBox.get(e);
      return {
        'key': e,
        'idCloth': item['idCloth'],
        'name': item['name'],
        'category': item['category'],
        'img': item['img'],
        'price': item['price'],
        'oldPrice': item['oldPrice'],
        'sale': item['sale'],
      };
    }).toList();
    setState(() {
      _favCloths = favData.reversed.toList();
    });
  }

  Future<void> _deleteFav(int itemKey) async {
    await _favBox.delete(itemKey);
    _refreshFav();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return _favCloths.isEmpty
        ? Center(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height8),
              child: Text(
                "Danh sách yêu thích của bạn hiện đang trống",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: Dimensions.font36),
              ),
            ),
          )
        : ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = _favCloths[index];
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: Container(
                    //alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.height20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.height200,
                          height: Dimensions.height200,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                              image: NetworkAvifImage(
                                data['img'],
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () => _deleteFav(data['key']),
                            child: Padding(
                              padding: EdgeInsets.all(Dimensions.height10),
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        Expanded(
                          child: Column(
                            children: [
                              AlignLeftText(
                                text: data['name'],
                                size: Dimensions.font26,
                              ),
                              SizedBox(height: Dimensions.height10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  data['oldPrice'].toString(),
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${data['price'].toString()}đ",
                                  style: TextStyle(
                                    fontSize: Dimensions.font36,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.height10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  data['sale'],
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimensions.font26,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: _favCloths.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: Dimensions.height10),
          );
    // if (_favCloths.isEmpty) {
    //   return Center(
    //     child: Padding(
    //       padding: EdgeInsets.all(Dimensions.height8),
    //       child: Text(
    //         "Danh sách yêu thích của bạn hiện đang trống",
    //         textAlign: TextAlign.center,
    //         style: GoogleFonts.roboto(fontSize: Dimensions.font36),
    //       ),
    //     ),
    //   );
    // } else {
    //   return ListView.separated(
    //     scrollDirection: Axis.vertical,
    //     itemBuilder: (context, index) {
    //       final data = _favCloths[index];
    //       return GestureDetector(
    //         onTap: () {},
    //         child: Padding(
    //           padding: EdgeInsets.all(Dimensions.height10),
    //           child: Container(
    //             //alignment: Alignment.centerLeft,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(Dimensions.height20),
    //               ),
    //             ),
    //             child: Row(
    //               children: [
    //                 Container(
    //                   width: Dimensions.height200,
    //                   height: Dimensions.height200,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     image: DecorationImage(
    //                       image: NetworkAvifImage(
    //                         data['img'],
    //                       ),
    //                     ),
    //                   ),
    //                   child: GestureDetector(
    //                     onTap: () => _deleteFav(data['key']),
    //                     child: Padding(
    //                       padding: EdgeInsets.all(Dimensions.height10),
    //                       child: const Align(
    //                         alignment: Alignment.topRight,
    //                         child: Icon(
    //                           Icons.favorite,
    //                           color: Colors.red,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(width: Dimensions.width10),
    //                 Expanded(
    //                   child: Column(
    //                     children: [
    //                       AlignLeftText(
    //                         text: data['name'],
    //                         size: Dimensions.font26,
    //                       ),
    //                       SizedBox(height: Dimensions.height10),
    //                       Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           data['oldPrice'].toString(),
    //                           style: const TextStyle(
    //                             decoration: TextDecoration.lineThrough,
    //                           ),
    //                         ),
    //                       ),
    //                       Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           "${data['price'].toString()}đ",
    //                           style: TextStyle(
    //                             fontSize: Dimensions.font36,
    //                             color: Colors.red,
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(height: Dimensions.height10),
    //                       Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           data['sale'],
    //                           style: TextStyle(
    //                             color: Colors.red,
    //                             fontStyle: FontStyle.italic,
    //                             fontSize: Dimensions.font26,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //     itemCount: _favCloths.length,
    //     separatorBuilder: (BuildContext context, int index) =>
    //         SizedBox(height: Dimensions.height10),
    //   );
    // }
  }
}
