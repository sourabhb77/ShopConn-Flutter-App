import 'package:cloud_firestore/cloud_firestore.dart';

class Clothes{
  String id;
  String name;
  String ownerId;
  String type;
  // int price;
  String price;
  // int size;
  String size;
  String description;
  List<String> imgList;
  String productCategory;
  bool onSell = true;
  Timestamp postedAt;


  Clothes();

  Clothes.fromMap(Map<String,dynamic>data){
    id=data['id'];
    ownerId=data['ownerId'];
    name=data['name'];
    type=data['type'];
    price=data['price'];
    size=data['size'];
    description=data['description'];
    productCategory=data['productCategory'];
    onSell=data['onSell'];
    postedAt=data['postedAt'];
  }

  Map<String,dynamic>toMap(){
    return{
      'name':name,
       'id': id,
      'ownerId': ownerId,
      'type':type,
      'price': price,
      'size':size,
      'description': description,
      'imgList': imgList,
      'productCategory': productCategory,
      'onSell': onSell,
      'postedAt': postedAt,
    };

  }

}