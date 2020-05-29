import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;
import 'package:shopconn/models/clothes.dart';
import 'package:uuid/uuid.dart';

uploadClothesDetails(Clothes clothes)async{
  // if(localFile!=null)
  // {
    // var fileExtension= path.extension(localFile.path);
    // var uuid=Uuid().v4();
    // final StorageReference firebaseStorageRef =FirebaseStorage.instance.ref().child('clothes/images/$uuid$fileExtension');

    // await firebaseStorageRef.putFile(localFile.onComplete.catchError(
    //   (onError){
    //     return false;
    //   }
    // ));
    // String url=await firebaseStorageRef.getDownloadURL();
  _uploadClothesDetails(clothes);
  // }
  // else
  // {
  //   print('skipping image upload');
  // }
}

_uploadClothesDetails(Clothes clothes)async{
  CollectionReference clothesRef=Firestore.instance.collection('Clothes');
  clothes.postedAt=Timestamp.now();
  DocumentReference documentRef=await clothesRef.add(clothes.toMap());

  clothes.id=documentRef.documentID;
  print("uploaded clothes details succesfully.");

  await documentRef.setData(clothes.toMap(),merge:true);

}