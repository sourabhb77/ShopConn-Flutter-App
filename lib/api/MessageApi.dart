import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/models/user.dart';
import 'package:tuple/tuple.dart';
//import 'package:stream_transform/stream_transform.dart';

/**
 * Dart file to handle all the message request to get all the required details
 * 1. Get new Message Request, generally in case of seller
 * 2. Get new Messages 
 * !!!!! How to save these messages in local storage for Fast retrival / offline modee
 */

//Get all the new message request for the current user

Future<List<ChatUser>> getNewRequest() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  String userId = user.uid;

  CollectionReference ref = Firestore.instance.collection("request");
  var query = ref
      .where("requestedId", isEqualTo: userId)
      .orderBy('timeStamp', descending: true);

  List<ChatUser> list = List();
  QuerySnapshot snaps = await query.getDocuments();
  for (DocumentSnapshot doc in snaps.documents) {
    var message_req = MessageRequest.fromMap(doc.data);
    DocumentSnapshot user = await Firestore.instance
        .collection("users")
        .document(message_req.requesterId)
        .get();

    print("Chat user data: ${user.data}");

    list.add(ChatUser.fromMap(user.data));
  }
  print("***************************");
  print("list size: ${list.length}");
  print("userID : $userId ");
  print("***************************");

  return list;
}

Future<bool> sendNewRequest(
    String requesterId, String requestedId, String productId) async {
  DocumentReference ref = Firestore.instance.collection("request").document();
  MessageRequest requestObject = MessageRequest(
      requesterId: requesterId, requestedId: requestedId, productId: productId);
  requestObject.id = ref.documentID;

  try {
    await ref.setData(requestObject.toMap(), merge: true);
    return true;
  } catch (err) {
    print("Error sending chat request: $err");
    return false;
  }
}

Future<bool> makeRoom(String userId) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  List<String> members = List();
  //Prodcut owner Id = User.uid;
  members.add(user.uid);
  members.add(userId);
  DocumentReference ref = Firestore.instance.collection("rooms").document();
  String id = ref.documentID;

  ChatRoom room = ChatRoom();
  room.id = id;
  room.members = members;
  try {
    await ref.setData(room.toMap(), merge: true);
    ChatMessage msg = ChatMessage();
    var ref2 = Firestore.instance.collection("rooms/$id/chats").document();
    msg.id = ref2.documentID;
    msg.message = "HI";
    msg.receiver = userId;
    msg.sender = user.uid;

    await ref2.setData(msg.toMap());
    return true;
  } catch (err) {
    print("Error While Making room: $err");
    return false;
  }
}

loadUser(ChatUser user, ChatMessage msg) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  String id = firebaseUser.uid;
  String requestId;
  try {
    if (id.compareTo(msg.receiver) == 0) {
      requestId = msg.receiver;
    } else {
      requestId = msg.sender;
    }

    DocumentSnapshot dataSnap =
        await Firestore.instance.document("users/$requestId").get();
    user = ChatUser.fromMap(dataSnap.data);
  } catch (err) {
    print("error getting user : $err");
  }
}

// Function that returns the string of groups that we need to listen to
Future<List<Tuple2<String, String>>> getRooms() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  String userId = user.uid;
  Query ref = Firestore.instance
      .collection("rooms")
      .where("members", arrayContains: userId);
  QuerySnapshot snaps = await ref.getDocuments();

  List<Tuple2<String, String>> rooms = List();

  for (DocumentSnapshot snap in snaps.documents) {
    List<String> userList = List.from(snap.data["members"]);

    userList.remove(userId); //removing the current user;
    Map<String, String> mp = HashMap();
    mp[snap.data["id"]] = userList[0];

    rooms.add(Tuple2(snap.data["id"], userList[0]));

    print("ROOM ID: ${snap.documentID}");
  }

  print("Room Obtained from server: size: ${rooms.length}");
  return rooms;
}

// // Future< List<ChatUser> >
//  Future< List<Stream<QuerySnapshot> >> getChats() async
// {
//   FirebaseUser user = await FirebaseAuth.instance.currentUser();
//   String userId = user.uid;
//   List< Tuple2<String, String> > rooms = await getRooms(); // <RoomId, UserId>

//   List<Tuple2<ChatUser, String>>  chatList;

//   List<Stream<QuerySnapshot> > result = List();
//   Stream<QuerySnapshot> st;
//   for(var tup in rooms)
//   {
//     var msg =  Firestore.instance.collection("rooms/${tup.item1}/chats").snapshots();
//     // .orderBy("timeStamp",descending: true).limit(1).snapshots();
//     result.add(msg);

//     // var userSnap = await Firestore.instance.collection("users").document(tup.item2).get();
//     // ChatUser user = ChatUser.fromMap(userSnap.data);

//   }

//   Stream<QuerySnapshot> q1 = Firestore.instance.collectionGroup("chats").where("receiverId", isEqualTo: userId).orderBy("timeStamp").limit(1).snapshots();
//   Stream<QuerySnapshot> q2 = Firestore.instance.collectionGroup("chats").where("senderId",isEqualTo: userId).orderBy("timeStamp").limit(1).snapshots();

//   return result;

// }

Stream st(String userId) {
  print("UserID: Stream $userId");

  var q1 = Firestore.instance
      .collectionGroup("chats")
      .where("receiver", isEqualTo: userId)
      .orderBy("timeStamp")
      .limit(1)
      .snapshots();
  Stream<QuerySnapshot> q2 = Firestore.instance
      .collectionGroup("chats")
      .where("sender", isEqualTo: userId)
      .orderBy("timeStamp")
      .limit(1)
      .snapshots();

  // return StreamZip([q1, q1]);
  return StreamGroup.merge([q1, q2]).asBroadcastStream();
  // return q2;
}

Stream loadDetails() async* {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  String userId = user.uid;

  var q1 = Firestore.instance
      .collectionGroup("chats")
      .where("sender", isEqualTo: userId)
      .orderBy("timeStamp", descending: true)
      .snapshots();
  var q2 = Firestore.instance
      .collectionGroup("chats")
      .where("receiver", isEqualTo: userId)
      .orderBy("timeStamp", descending: true)
      .snapshots();
  var q = await Firestore.instance
      .collectionGroup("chats")
      .where("sender", isEqualTo: userId)
      .orderBy("timeStamp", descending: true)
      .limit(1)
      .getDocuments();
  print("Query data: ${q.documents[0].data}");

  // q1.listen((event) {updateUI(event)});
  // q1.listen((event) {controller.sink.add(event.documents[0]);});
  // yield* StreamGroup.merge([q1,q2]).asBroadcastStream();
  // yield* Rx.zip2(q1, q2, (a, b) => a!=b );
  StreamController<QuerySnapshot> controller =
      StreamController<QuerySnapshot>.broadcast();

  // controller.addStream(q1);
  // controller.addStream(q2);

  var newStream =
      Rx.combineLatest2(q1, q2, (a, b) => Stream.fromIterable([a, b]));
  // controller.addStream(newStream);

  var t = Rx.merge([q1, q2]);
  t.listen((events) {
    for (var event in events.documents) {
      // print("Event Data : ${event.data}");

    }
  });

  // t.map((event) {
  //   snaps.contains(event).then((value) {
  //     if(value)
  //     {
  //       snaps.
  //     }
  //   });
  // });

  // var result = q1.merge(q2);

  // yield* result;
  // yield* controller.stream;
  yield* newStream;
}

getChatsDetails() async* {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  String userId = user.uid;

  var ref = Firestore.instance
      .collectionGroup("rooms")
      .where("members", arrayContainsAny: [userId])
      .orderBy("timeStamp")
      .snapshots();

  var rooms = getRooms();
}
