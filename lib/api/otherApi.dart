import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

 uploadOtherImages(List<File> imgLislt, String postId) async{
 List<String> urls=List();
  int i=1;
  for (File file in imgLislt) {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("post/$postId");
    StorageUploadTask task = storageReference.child("$i").putFile(file);
    final StorageTaskSnapshot downloadUrl = (await task.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    urls.add(url);
    ++i;
  }
  return urls;
}

Future <bool> uploadOtherDetails(dynamic data,List<File> images)async{
   try {
    print("Uploading images: started");
    DocumentReference ref = Firestore.instance.collection("post").document();
    // String id =
    data.id = ref.documentID;
    await ref.setData(data.toMap(), merge: true);
    List<String> list = await uploadOtherImages(images, data.id);
    data.imgList = list;
    return true;
  } catch (err) {
    print("Error Uploading Product: $err");
    return false;
  }
      
    }