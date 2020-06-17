

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shopconn/models/user.dart';

class ChatNotifier extends ChangeNotifier
{
  ChatUser _user = ChatUser();

  ChatUser get currentUser => _user;


  set setChatUser(String id)
  {
    Firestore.instance.collection("users").document(id).get().then((value) {
      print("Chat Notifier: User: ${value.data}");
      this._user = ChatUser.fromMap(value.data);

      notifyListeners();

    });
  }


}