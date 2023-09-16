import 'package:flutter/cupertino.dart';

class ProductNotifier extends ChangeNotifier {
  List<dynamic> _clothSizes = [];
  final List _productCart = [];

  List<dynamic> get clothSizes => _clothSizes;

  set clothsSizes(List<dynamic> newSizes) {
    _clothSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _clothSizes.length; i++) {
      if (i == index) {
        _clothSizes[i]['isSelected'] = !_clothSizes[i]['isSelected'];
      }
    }
  }

  get productCart => _productCart;

  // final List<dynamic> _clothSizeSelected = [];
  //
  // List<dynamic> get clothSizeSelected => _clothSizeSelected;
  //
  // set clothSizeSelected(List<dynamic> newClothSizeSelected) {
  //   _clothSizeSelected == newClothSizeSelected;
  //   notifyListeners();
  // }
  //
  // void addProductToCart(int index) {
  //   _clothSizeSelected.add(_clothSizeSelected[index]);
  //   notifyListeners();
  // }
  //
  // void removeProductToCart(int index) {
  //   _clothSizeSelected.removeAt(index);
  //   notifyListeners();
  // }

  // void toggleCheck(int index) {
  //   for (int i = 0; i < _clothSizeSelected.length; i++) {
  //     _clothSizeSelected[i]['isSelected'] =
  //         !_clothSizeSelected[i]['isSelected'];
  //   }
  // }
}
