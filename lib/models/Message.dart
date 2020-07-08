// import 'package:cloud_firestore/cloud_firestore.dart';

// // class User
// // {
// //   String userId, name, email , imageUrl , mobile;

// //   User.fromMap(Map<String, dynamic> data)
// //   {
// //     userId = data["userId"];
// //     name = data ["name"];
// //     email = data["email"];
// //     imageUrl = data["imageUrl"];
// //     mobile = data["mobile"];
// //   }

// //   Map<String , dynamic> toMap()
// //   {
// //     return
// //     {
// //       "userId" : userId,
// //       "name" : name,
// //       "email" : email,
// //       "imageUrl" : imageUrl,
// //       "mobile" : imageUrl,

// //     };
// //   }
// // }

// class MessageRequest
// {
//   String id;
//   String requestMessage;
//   String requesterId, requestedId;
//   String productId;
//   Timestamp timestamp;

//   MessageRequest({this.requesterId, this.requestedId,this.productId, this.requestMessage:"Hi, I am Intereseted in Your Product"});

//   Map<String, dynamic> toMap()
//   {
//     return
//     {
//       'id': id,
//       'requestMessage' : requestMessage,
//       'requesterId' :requesterId,
//       "requestedId" : requestedId,

//       'productId': productId,
//       'timeStamp': FieldValue.serverTimestamp()
//     };
//   }

//   MessageRequest.fromMap(Map<String, dynamic> data)
//   {
//     id = data['id'];
//     requestMessage = data['requestMessage'];
//     productId = data['productId'];
//     requesterId = data['requesterId'];
//     requestedId = data['requestedId'];
//     timestamp = data['timeStamp'];
//   }
// }

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

// class User
// {
//   String userId, name, email , imageUrl , mobile;

//   User.fromMap(Map<String, dynamic> data)
//   {
//     userId = data["userId"];
//     name = data ["name"];
//     email = data["email"];
//     imageUrl = data["imageUrl"];
//     mobile = data["mobile"];
//   }

//   Map<String , dynamic> toMap()
//   {
//     return
//     {
//       "userId" : userId,
//       "name" : name,
//       "email" : email,
//       "imageUrl" : imageUrl,
//       "mobile" : imageUrl,

//     };
//   }
// }

class MessageRequest {
  String id;
  String requestMessage;
  String requesterId, requestedId;
  String productId;
  Timestamp timeStamp;

  MessageRequest(
      {this.requesterId,
      this.requestedId,
      this.productId,
      this.requestMessage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestMessage': requestMessage,
      'requesterId': requesterId,
      "requestedId": requestedId,
      'productId': productId,
      'timeStamp': FieldValue.serverTimestamp()
    };
  }

  MessageRequest.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    requestMessage = data['requestMessage'];
    productId = data['productId'];
    requesterId = data['requesterId'];
    requestedId = data['requestedId'];
    timeStamp = data['timeStamp'];
  }
}

class ChatRoom {
  ChatRoom();
  String id;
  List<String> members;
  Timestamp timeStamp;

  ChatRoom.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    members = List.from(data["members"]);
    timeStamp = data["timeStamp"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "members": members,
      "timeStamp": FieldValue.serverTimestamp(),
    };
  }
}

class ChatMessage {
  ChatMessage();
  String sender, receiver, message;
  String id;
  Timestamp timeStamp;

  ChatMessage.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    sender = data["sender"];
    receiver = data["receiver"];
    message = data["message"];
    timeStamp = data["timeStamp"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "message": message,
      "sender": sender,
      "receiver": receiver,
      "timeStamp": FieldValue.serverTimestamp(),
    };
  }
}
