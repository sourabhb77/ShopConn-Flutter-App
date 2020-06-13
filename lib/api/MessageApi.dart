import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/SavedProductData.dart';

/**
 * Dart file to handle all the message request to get all the required details
 * 1. Get new Message Request, generally in case of seller
 * 2. Get new Messages 
 * !!!!! How to save these messages in local storage for Fast retrival / offline modee
 */

//Get all the new message request for the current user 


Future<List<MessageRequest>> getNewRequest(String userId) async
{
  
  CollectionReference ref = Firestore.instance.collection("requests");
  ref.where("ownerId", isEqualTo:userId)
  .orderBy('timestamp',descending:true);

  
  List<MessageRequest> list = List();
  QuerySnapshot  snaps = await ref.getDocuments();
  for (DocumentSnapshot doc in snaps.documents)
  {
    list.add(MessageRequest.fromMap(doc.data));
  }
  return list;
}