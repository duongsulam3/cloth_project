import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  String searchText = "";

  void updateProductList(String value) {
    searchText = value;
    notifyListeners();
  }
}
