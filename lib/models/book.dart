import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String id;
  String ownerId;
  String name;
  int price;
  String description;
  List<String> imgList;
  String productCategory;
  bool onSell = true;
  String bookCategory;
  List<String> authorList;
  String edition;
  String publication;
  String condition; //Esthetic condition
  String branch;
  String subject;
  Timestamp postedAt;

  Book();
  
  Book.fromMap(Map<String, dynamic> data){
    id = data['id'];
    ownerId = data['ownerId'];
    name = data['name'];
    price = data['price'];
    description = data['description'];
    imgList = data['imgList'];
    productCategory = data['productCategory'];
    onSell = data['onSell'];
    bookCategory = data['bookCategory'];
    authorList = data['authorList'];
    edition = data['edition'];
    publication = data['publication'];
    condition = data['condition'];
    branch = data['branch'];
    subject = data['subject'];
    postedAt = data['postedAt'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'price': price,
      'description': description,
      'imgList': imgList,
      'productCategory': productCategory,
      'onSell': onSell,
      'bookCategory': bookCategory,
      'authorList': authorList,
      'edition': edition,
      'publication': publication,
      'condition': condition,
      'branch': branch,
      'subject': subject,
      'postedAt': postedAt,
    };
  }
}

