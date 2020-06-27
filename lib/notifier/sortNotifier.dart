import 'package:flutter/material.dart';

class SortNotifier with ChangeNotifier {
  String _parameter = 'name';
  bool _desc = false;

  get currentSortParameter => _parameter;
  get currentSortDesc => _desc;

  set currentSortParameter(String parameter) {
    _parameter = parameter;
    notifyListeners();
  }

  set currentSortDesc(bool desc) {
    _desc = desc;
    notifyListeners();
  }
}
