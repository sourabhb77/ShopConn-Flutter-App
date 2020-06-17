import 'dart:collection';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  List _productList = [];

  UnmodifiableListView<dynamic> get productList => UnmodifiableListView(_productList);


  set productList(List productList) {
    _productList = productList;
    notifyListeners();
  }
}