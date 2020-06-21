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


class MessageRequest
{
  String id;
  String requestMessage;
  String requesterId, requestedId;
  String productId;
  Timestamp timestamp;

  MessageRequest({this.requesterId, this.requestedId,this.productId, this.requestMessage:"Hi, I am Intereseted in Your Product"}); 
  


  Map<String, dynamic> toMap()
  {
    return 
    {
      'id': id,
      'requestMessage' : requestMessage,
      'requesterId' :requesterId,
      "requestedId" : requestedId,
      
      'productId': productId,
      'timeStamp': FieldValue.serverTimestamp()
    };
  }

  MessageRequest.fromMap(Map<String, dynamic> data)
  {
    id = data['id'];
    requestMessage = data['requestMessage'];
    productId = data['productId'];
    requesterId = data['requesterId'];
    requestedId = data['requestedId'];
    timestamp = data['timeStamp'];
  }
}