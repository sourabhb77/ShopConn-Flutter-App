import 'package:cloud_firestore/cloud_firestore.dart';

class Other {
  String id;
  String ownerId;
  String name;
  String description;
  int price;
  String productCategory;
  String buyerId;
  List<String> imgList;
  String condition;
  Timestamp postedAt;
  List<String> tagList;

  Other();

  Other.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    ownerId = data['ownerId'];
    name = data['name'];
    description = data['description'];
    price = data['price'];
    productCategory = data['productCategory'];
    buyerId = data['buyerId'];
    imgList = List.from(data['imgList']);
    condition = data['condition'];
    postedAt = data['postedAt'];
    tagList = List.from(data['tagList']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'price': price,
      'productCategory': productCategory,
      'buyerId': buyerId,
      'imgList': imgList,
      'condition': condition,
      'postedAt': postedAt,
      'tagList': tagList,
    };
  }
}
