import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/models/clothes.dart';
import 'package:shopconn/models/note.dart';
import 'package:shopconn/models/other.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopconn/notifier/productNotifier.dart';

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
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
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

Future<FirebaseUser> getCurrendFirebaseUser() async {
  return await FirebaseAuth.instance.currentUser();
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));
  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getProfile(String id) async {
  DocumentReference ref = Firestore.instance.document("users/$id");
  DocumentSnapshot snapshot = await ref.get();
  return snapshot;
}

// getBooks(BookNotifier bookNotifier) async {
//   QuerySnapshot snapshot = await Firestore.instance.collection('post').getDocuments();

//   List<Book> _bookList = [];
//   snapshot.documents.forEach((document) {
//     Book book = Book.fromMap(document.data);
//     _bookList.add(book);
//   });
//   bookNotifier.bookList = _bookList;
//   print("Got your products");
// }

// to get all types of products
Future<void> getProducts(ProductNotifier productNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('post').getDocuments();

  List _productList = [];
  snapshot.documents.forEach((document) {
    print(document.data["productCategory"]);

    if (document.data["productCategory"] == "Book") {
      Book book = Book.fromMap(document.data);
      _productList.add(book);
    } else if (document.data["productCategory"] == "Clothes") {
      Clothes cloth = Clothes.fromMap(document.data);
      _productList.add(cloth);
    } else if (document.data["productCategory"] == "Note") {
      Note note = Note.fromMap(document.data);
      _productList.add(note);
    } else if (document.data["productCategory"] == "Other") {
      Other other = Other.fromMap(document.data);
      _productList.add(other);
    }
  });
  productNotifier.productList = _productList;
  print("Got your products");
}

//API To Upload User Profile to Database

Future<String> UploadProfileImage(String user, File image) async {
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child("users/$user");
  StorageUploadTask task = storageReference.putFile(image);
  final StorageTaskSnapshot downloadUrl = (await task.onComplete);
  final String url = (await downloadUrl.ref.getDownloadURL());
  print("URL: $url");
  return url;
}

void UpdateProfile(String name, String mobile, File image) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  String url = await UploadProfileImage(user.uid, image);
  DocumentReference ref = Firestore.instance.document("users/${user.uid}");

  ref
      .setData(
          {"name": name, "mobile": mobile, "imageUrl": url, "newUser": false},
          merge: true)
      .then((value) => print("Success"))
      .catchError((error) => {print(error)});
}
