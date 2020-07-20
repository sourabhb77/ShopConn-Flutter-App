import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier with ChangeNotifier {
  FirebaseUser _user;
  String imageUrl;
  String name;
  String email, mobile; 

  FirebaseUser get user => _user;

  String get userId => _user.uid;

  void currentUser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  void setUser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }
}
