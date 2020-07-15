import 'package:cloud_firestore/cloud_firestore.dart';

class Clothes {
  String id;
  String name;
  String ownerId;
  String type; //type-boliersuit or labcoat
  int price;
  // String price;
  int size;
  // String size;
  String description;
  List<String> imgList;
  String productCategory;
  String buyerId;
  Timestamp postedAt;
  String condition;
  List<String> tagList;

  Clothes();

  Clothes.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    ownerId = data['ownerId'];
    type = data['type'];
    price = data['price'];
    size = data['size'];
    description = data['description'];
    // imgList=data['imgList'];
    imgList = List.from(data['imgList']);
    productCategory = data['productCategory'];
    buyerId = data['buyerId'] ?? "";
    postedAt = data['postedAt'];
    condition = data['condition'];
    tagList = List.from(data['tagList']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'type': type,
      'price': price,
      'size': size,
      'description': description,
      'imgList': imgList,
      'productCategory': productCategory,
      'buyerId': buyerId,
      'postedAt': postedAt,
      'condition': condition,
      'tagList': tagList,
    };
  }
}
