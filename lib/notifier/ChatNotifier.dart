

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';

class ChatNotifier extends ChangeNotifier
{
  ChatUser _user ;

  ChatRoom _room ;

  ChatUser get currentUser => _user;

  ChatRoom get currentRoom => _room;

  set setCurrentRoom(ChatRoom room) => this._room =room;
  

  set setChatUser(String id)
  {
    Firestore.instance.collection("users").document(id).get().then((value) {
      print("Chat Notifier: User: ${value.data}");
      this._user = ChatUser.fromMap(value.data);

      notifyListeners();

    });
  }
  

  set setChatUserObject(ChatUser user) => this._user = user ;


}