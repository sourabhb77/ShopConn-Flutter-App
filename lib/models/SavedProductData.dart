import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String id;
  String ownerId;
  String name;
  int price;
  String description;
  List<String> imgList;
  String productCategory;
  String buyerId;
  String bookCategory;
  List<String> authorList;
  int edition;
  String publication;
  String condition; //Esthetic condition
  String branch;
  String subject;
  Timestamp postedAt;
  List<String> tagList;

  Book();

  Book.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    ownerId = data['ownerId'];
    name = data['name'];
    price = data['price'];
    description = data['description'];
    imgList = List.from(data['imgList']);
    productCategory = data['productCategory'];
    buyerId = data['buyerId'] ?? "";
    bookCategory = data['bookCategory'];
    authorList = List.from(data['authorList']);
    edition = data['edition'];
    publication = data['publication'];
    condition = data['condition'];
    branch = data['branch'];
    subject = data['subject'];
    postedAt = data['postedAt'];
    tagList = List.from(data['tagList']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'price': price,
      'description': description,
      'imgList': imgList,
      'productCategory': productCategory,
      'buyerId': buyerId,
      'bookCategory': bookCategory,
      'authorList': authorList,
      'edition': edition,
      'publication': publication,
      'condition': condition,
      'branch': branch,
      'subject': subject,
      'postedAt': postedAt,
      'tagList': tagList,
    };
  }
}
