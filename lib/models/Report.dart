import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String id;
  String userId;
  String report;
  Timestamp postedAt;

  Report();

  Report.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    userId = data['userId'];
    report = data['report'];
    postedAt = data['report'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'report': report,
      'postedAt': postedAt,
    };
  }
}
