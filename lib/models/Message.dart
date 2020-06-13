class MessageRequest
{
  String requestId;
  String requestMessage, ownerId;
  String requesterId;
  String productId;
  
  


  Map<String, dynamic> toMap()
  {
    return 
    {
      'requestId': requestId,
      'requestMessage' : requestMessage,
      'ownerId': ownerId,
      'productId': productId,
    };
  }

  MessageRequest.fromMap(Map<String, dynamic> data)
  {
    requestId = data['requestId'];
    requestMessage = data['requestMessage'];
    ownerId = data["ownerId"];
    productId = data['productId'];
    requesterId = data['requesterId'];
  }
}