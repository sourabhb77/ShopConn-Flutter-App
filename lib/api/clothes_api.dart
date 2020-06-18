import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

uploadClothesImages(List<File> imgList, String postId) async {
  List<String> urls=List();
  int i=1;
  for (File file in imgList) {
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

Future<bool> uploadClothesDetails(dynamic clothes,List<File> images)async{
  try{
  DocumentReference documentRef=Firestore.instance.collection("post").document();
  clothes.id=documentRef.documentID;
  print("uploaded clothes details succesfully.");
  await documentRef.setData(clothes.toMap(),merge:true);
  List<String> list = await uploadClothesImages(images, clothes.id);
  clothes.imgList = list;
  return true;
}catch(err){
  print("Error uploading Product:$err");
  return false;
}
}