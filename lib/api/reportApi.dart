import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> uploadReport(dynamic data) async {
  try {
    print("Uploading report started");
    DocumentReference ref = Firestore.instance.collection("report").document();
    // String id =
    data.id = ref.documentID;
    await ref.setData(data.toMap(), merge: true);
    return true;
  } catch (err) {
    print("Error Uploading report: $err");
    return false;
  }
}
