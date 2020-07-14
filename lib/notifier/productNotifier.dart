import 'dart:collection';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  List _productList = [];
  dynamic _currentProduct;

  UnmodifiableListView<dynamic> get productList =>
      UnmodifiableListView(_productList);

  get currentProduct => _currentProduct;

  set productList(List productList) {
    _productList = productList;
    notifyListeners();
  }

  set currentProduct(dynamic product) {
    _currentProduct = product;
    notifyListeners();
  }
}
