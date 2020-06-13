import 'dart:io';

// import 'package:shopconn/model/book.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/authNotifier.dart';
// import 'package:shopconn/notifier/book_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:shopconn/notifier/bookNotifier.dart';
// import 'package:uuid/uuid.dart';

login(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.displayName;

    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);

      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }
  }
}


getCurrentUser(AuthNotifier authNotifier) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    return uid;
}


Future<FirebaseUser> getCurrendFirebaseUser() async
{
  return await FirebaseAuth.instance.currentUser();
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getProfile(String id) async{
  DocumentReference ref = Firestore.instance.document("users/$id");
  DocumentSnapshot snapshot= await ref.get();
  return snapshot;
  
}


getBooks(BookNotifier bookNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('post')
      // .orderBy("postedAt", descending: true)
      .getDocuments();

  List<Book> _bookList = [];

  snapshot.documents.forEach((document) {
    Book book = Book.fromMap(document.data);
    _bookList.add(book);
  });

  print("Size of BOok Array : ${_bookList.length}");

  bookNotifier.bookList = _bookList;
}


//API To Upload User Profile to Database

Future<String> UploadProfileImage(String user,File image) async {
    StorageReference storageReference =        FirebaseStorage.instance.ref().child("users/$user");
    StorageUploadTask task = storageReference.putFile(image);
    final StorageTaskSnapshot downloadUrl = (await task.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL: $url");
    return url;
  }


 void UpdateProfile(String name,String mobile,File image) async
 {
   FirebaseUser user = await FirebaseAuth.instance.currentUser();
   String url= await UploadProfileImage(user.uid, image);
    DocumentReference ref = Firestore.instance.document("users/${user.uid}");

      ref
          .setData({"name": name, "mobile": mobile, "imageUrl": url,"newUser":false},
              merge: true)
          .then((value) => print("Success"))
          .catchError((error) => {print(error)});
    }


 

// uploadBookAndImage(Book book, bool isUpdating, File localFile, Function bookUploaded) async {
//   if (localFile != null) {
//     print("uploading image");

//     var fileExtension = path.extension(localFile.path);
//     print(fileExtension);

//     var uuid = Uuid().v4();

//     final StorageReference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('books/images/$uuid$fileExtension');

//     await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
//       print(onError);
//       return false;
//     });

//     String url = await firebaseStorageRef.getDownloadURL();
//     print("download url: $url");
//     _uploadBook(book, isUpdating, bookUploaded, imageUrl: url);
//   } else {
//     print('...skipping image upload');
//     _uploadBook(book, isUpdating, bookUploaded);
//   }
// }

// _uploadBook(Book book, bool isUpdating, Function bookUploaded, {String imageUrl}) async {
//   CollectionReference bookRef = Firestore.instance.collection('Books');

//   if (imageUrl != null) {
//     book.img = imageUrl;
//   }

//   if (isUpdating) {
//     book.updatedAt = Timestamp.now();

//     await bookRef.document(book.id).updateData(book.toMap());

//     bookUploaded(book);
//     print('updated book with id: ${book.id}');
//   } else {
//     book.createdAt = Timestamp.now();

//     DocumentReference documentRef = await bookRef.add(book.toMap());

//     book.id = documentRef.documentID;

//     print('uploaded book successfully: ${book.toString()}');

//     await documentRef.setData(book.toMap(), merge: true);

//     bookUploaded(book);
//   }
// }

// deleteBook(Book book, Function bookDeleted) async {
//   if (book.image != null) {
//     StorageReference storageReference =
//         await FirebaseStorage.instance.getReferenceFromUrl(book.image);

//     print(storageReference.path);

//     await storageReference.delete();

//     print('image deleted');
//   }

//   await Firestore.instance.collection('Books').document(book.id).delete();
//   bookDeleted(book);
// }