import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/SavedProductData.dart';

/**
 * Dart file to handle all the message request to get all the required details
 * 1. Get new Message Request, generally in case of seller
 * 2. Get new Messages 
 * !!!!! How to save these messages in local storage for Fast retrival / offline modee
 */

//Get all the new message request for the current user 


Future<List<MessageRequest>> getNewRequest() async
{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  String userId = user.uid;


  
  CollectionReference ref = Firestore.instance.collection("request");
  var query =ref .where("requesterId", isEqualTo: userId)
  .orderBy('timeStamp',descending:true);

 
  
  List<MessageRequest> list = List();
  QuerySnapshot  snaps = await query.getDocuments();
  for (DocumentSnapshot doc in snaps.documents)
  {
    print("DOC data: ${doc.data}");
    list.add(MessageRequest.fromMap(doc.data));

  }
  print("***************************");
  print("list size: ${list.length}");
  print("userID : $userId ");
  print("***************************");

  return list;
}

Future<bool> sendNewRequest(String requesterId, String requestedId, String productId) async
{
  DocumentReference ref = Firestore.instance.collection("request").document();
  MessageRequest requestObject = MessageRequest(requesterId: requesterId, requestedId: requestedId,
                                          productId: productId);
  requestObject.id = ref.documentID;

  try
  {
    await ref.setData(requestObject.toMap(), merge: true);
    return true;

  }
  catch(err)
  {
    print("Error sending chat request: $err");
    return false;
  }


}