import 'package:cloud_firestore/cloud_firestore.dart';

class Other {
  String id;
  String ownerId;
  String name;
  String description;
  int price;
  String productCategory;
  bool onSell=true;
  List<String> imgList;
  String condition;
  Timestamp postedAt;

  Other();

  Other.fromMap(Map<String,dynamic>data){
    id=data['id'];
    ownerId=data['ownerId'];
    name=data['name'];
    description=data['description'];
    price=data['price'];
    productCategory=data['productCategory'];
    onSell=data['onSell'];
    imgList = List.from(data['imgList']);
    condition=data['condition'];
    postedAt=data['postedAt'];
  }
  
  Map<String,dynamic>toMap(){
    return{
    'id':id,
    'ownerId':ownerId,
    'name':name,
    'description':description,
    'price':price,
    'productCategory':productCategory,
    'onSell':onSell,
    'imgList':imgList,
    'condition':condition,
    'postedAt':postedAt,
  };
}
}