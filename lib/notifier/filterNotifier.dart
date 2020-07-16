import 'package:flutter/material.dart';

class FilterNotifier with ChangeNotifier {
  int _minPrice = 0;
  int _maxPrice = 3000;
  String _condition = "";
  String _productCategory = "";

  //for book
  String _bookCategory = "";
  String _branchBook = "";

  //for cloth
  String _typeOfCloth = "";

  //for note
  String _branchNote = "";
  String _year = '';

  get currentMinPrice => _minPrice;
  get currentMaxPrice => _maxPrice;
  get currentCondition => _condition;
  get currentProductCategory => _productCategory;
  get currentBookCategory => _bookCategory;
  get currentBranchBook => _branchBook;
  get currentTypeOfCloth => _typeOfCloth;
  get currentBranchNote => _branchNote;
  get currentYear => _year;

  set currentMinPrice(int val) {
    _minPrice = val;
    notifyListeners();
  }

  set currentMaxPrice(int val) {
    _maxPrice = val;
    notifyListeners();
  }

  set currentCondition(String val) {
    _condition = val;
    notifyListeners();
  }

  set currentProductCategory(String val) {
    if (currentProductCategory != val) {
      _productCategory = val;
      notifyListeners();
    }
  }

  set currentBookCategory(String val) {
    _bookCategory = val;
    notifyListeners();
  }

  set currentBranchBook(String val) {
    _branchBook = val;
    notifyListeners();
  }

  set currentTypeOfCloth(String val) {
    _typeOfCloth = val;
    notifyListeners();
  }

  set currentBranchNote(String val) {
    _branchNote = val;
    notifyListeners();
  }

  set currentYear(String val) {
    _year = val;
    notifyListeners();
  }
}
