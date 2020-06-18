import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

 uploadNotesImages(List<File> imgList, String postId) async{
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

Future <bool> uploadNotesDetails(dynamic notes,List<File> images)async{
  try{
    DocumentReference documentRef=Firestore.instance.collection("post").document();
    notes.id=documentRef.documentID;
    print("uploaded notes details succesfully.");
    await documentRef.setData(notes.toMap(),merge:true);
    List<String> list = await uploadNotesImages(images, notes.id);
        notes.imgList = list;
        return true;
      }catch(err){
        print("Error uploading notes details:$err");
        return false;
      }
      
    }