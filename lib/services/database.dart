import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });


  //collection reference
  final CollectionReference bookCollection = Firestore.instance.collection('book');

  Future updateBookData(
    String ownerId,
    String name,
    int price,
    String description,
    List<String> imgList,
    String productCategory,
    bool onSell,
    String bookCategory,
    List<String> authorList,
    int edition,
    String publication,
    String condition, //Esthetic condition
    String branch,
    String subject,
    Timestamp postedAt
  )  async {
    return await bookCollection.document(uid).setData({
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
    });
  }

  Stream<QuerySnapshot> get book{
    return bookCollection.snapshots();
  }
}