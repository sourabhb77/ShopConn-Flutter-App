
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shopconn/models/other.dart';

class OtherNotifier with ChangeNotifier{
  List<Other> _otherList=[];
  Other _currentOther;

  UnmodifiableListView<Other> get  otherList=>UnmodifiableListView(_otherList);
  Other get currentOther =>_currentOther;

  set otherList(List<Other> otherList){
    _otherList = otherList;
    notifyListeners();
  } 

   set currentOther(Other other){
    _currentOther= other;
    notifyListeners();
  } 

   addOther(Other other){
     _otherList.insert(0,other);
      notifyListeners();
   }

   deleteOther(Other other){
     _otherList.remove((_other)=>_other.id==other.id);
      notifyListeners();
   }

}