import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark {
  Timestamp timeStamp;
  String id;

  Bookmark({this.id});

  Bookmark.fromMap(Map<String, dynamic> data) {
    timeStamp = data['timeStamp'];
    id = data["id"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }
}
