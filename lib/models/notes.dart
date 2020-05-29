import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Notes{
  String id;
  String ownerId;
  String subject;
  String year;
  String facultyName;
  Float price;
  String description;
  List<String> imgList;
  String productCategory;
  bool onSell = true;
  Timestamp postedAt;
   
  Notes();

  Notes.fromMap(Map<String,dynamic>data)
  {
    id=data['id'];
    ownerId = data['ownerId'];
    subject=data['subject'];
    year=data['year'];
    facultyName=data['facultyName'];
    price = data['price'];
    description = data['description'];
    imgList = data['imgList'];
    productCategory = data['productCategory'];
    onSell = data['onSell'];
    postedAt = data['postedAt'];
  }

  Map<String,dynamic>toMap(){
   return 
   {
     'id':id,
     'ownerId':ownerId,
     'subject':subject,
     'year':year,
     'facultyName':facultyName,
     'price':price,
     'description':description,
     'productCategory':productCategory,
     'onSell':onSell,
     'postedAt':postedAt,
   };
  }

}