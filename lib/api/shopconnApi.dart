import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopconn/api/googleSignInApi.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/models/clothes.dart';
import 'package:shopconn/models/note.dart';
import 'package:shopconn/models/other.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/models/Bookmark.dart';

import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopconn/notifier/productNotifier.dart';

import 'package:shopconn/screens/Bookmarks.dart';

Future<String> login(User user, AuthNotifier authNotifier) async {
  String errorCode;
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) {
    print("Error code: ${error.code}");
    errorCode = error.code.toString();
  });

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
      return "True";
    }
  }
  return errorCode;
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
  try {
    await signOutGoogle();
    await FirebaseAuth.instance
        .signOut()
        .catchError((error) => print(error.code));
    authNotifier.setUser(null);
  } catch (err) {
    print("Error : $err");
  }
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
    var ref =
        await Firestore.instance.document("users/${firebaseUser.uid}").get();

    authNotifier.name = ref.data["name"];
    authNotifier.imageUrl = ref.data["imageUrl"];
    authNotifier.eamil = ref.data["email"];
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

/**
 * Api TO get the User bookmarsk
 */

Future<List<DocumentSnapshot>> getBookmarks() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  try {
    String id = user.uid;

    CollectionReference ref =
        Firestore.instance.collection("users/$id/bookmarks");
    var snapshots = await ref.getDocuments();

    List<String> documentList = List();

    for (var data in snapshots.documents) {
      documentList.add(data.data["id"]);
    }

    var ref2 = Firestore.instance
        .collection("post")
        .where("id", whereIn: documentList)
        .orderBy("postedAt");
    var querySnapshot = await ref2.getDocuments();

    return querySnapshot.documents;
  } catch (err) {
    print("Error fetching booksmarks : $err");
    return null;
  }
}
/**
 * Function to add Product to Bookmarks
 */

Future<bool> addToBookmarks(String postId) async {
  // await new Future.delayed(const Duration(seconds : 5));

  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  try {
    String id = user.uid;
    Bookmark bookMark = Bookmark(id: postId);
    DocumentReference ref =
        Firestore.instance.collection("users/$id/bookmarks").document(postId);
    await ref.setData(bookMark.toMap());
    print("bookMarkSuccess");
    return true;
  } catch (err) {
    print("Error adding to booksmarks : $err");
    return false;
  }
}

Future<bool> deleteBookMark(dataId) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  try {
    String id = user.uid;
    QuerySnapshot ref = await Firestore.instance
        .collection("users/$id/bookmarks")
        .where("id", isEqualTo: dataId)
        .getDocuments();

    for (var document in ref.documents) {
      document.reference.delete();
    }
    return true;
  } catch (err) {
    print("Error removing from bookmarks: $err");
    return false;
  }
}

isPresent(String sender, String receiver, ChatNotifier chatNotifier,
    AuthNotifier authNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection("rooms").getDocuments();
  String ans;
  snapshot.documents.forEach((document) {
    if ((document.data["members"][1].toString() == sender &&
            document.data["members"][0].toString() == receiver) ||
        (document.data["members"][0].toString() == sender &&
            document.data["members"][1].toString() == receiver)) {
      FirebaseUser user = authNotifier.user;
      ChatRoom chatroom = ChatRoom.fromMap(document.data);
      chatNotifier.setCurrentRoom = chatroom;
      chatNotifier.setChatUser = chatroom.members[1] == authNotifier.user.uid
          ? chatroom.members[0]
          : chatroom.members[1];
      ans = document.data["id"].toString();
    }
  });
  return ans;
}

//to delete product
Future<bool> deleteProduct(String productId) async {
  try {
    QuerySnapshot ref = await Firestore.instance
        .collection("post")
        .where("id", isEqualTo: productId)
        .getDocuments();

    for (var document in ref.documents) {
      document.reference.delete();
    }
    return true;
  } catch (err) {
    print("Error in removing: $err");
    return false;
  }
}

markAsSold(String productId) async {
  await Firestore.instance
      .collection("post")
      .document(productId)
      .updateData({"onSell": false})
      .then((value) => print("marked as sold"))
      .catchError((err) {
        print("got error");
      });
}
