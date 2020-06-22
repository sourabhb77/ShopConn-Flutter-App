import 'package:cloud_firestore/cloud_firestore.dart';

class Clothes{
  String id;
  String name;
  String ownerId;
  String type;//type-boliersuit or labcoat
  int price;
  // String price;
  int size;
  // String size;
  String description;
  List<String> imgList;
  String productCategory;
  bool onSell = true;
  Timestamp postedAt;
  String condition;


  Clothes();

  Clothes.fromMap(Map<String,dynamic>data){
    id=data['id'];
    name=data['name'];
    ownerId=data['ownerId'];
    type=data['type'];
    price=data['price'];
    size=data['size'];
    description=data['description'];
    // imgList=data['imgList'];
    imgList = List.from(data['imgList']);
    productCategory=data['productCategory'];
    onSell=data['onSell'];
    postedAt=data['postedAt'];
    condition=data['condition'];
  }

  Map<String,dynamic>toMap(){
    return{
      'id': id,
      'name':name,
      'ownerId': ownerId,
      'type':type,
      'price': price,
      'size':size,
      'description': description,
      'imgList': imgList,
      'productCategory': productCategory,
      'onSell': onSell,
      'postedAt': postedAt,
      'condition':condition,
    };

  }

}