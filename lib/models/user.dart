class User {
  String displayName;
  String email;
  String password;
  User();

}

class ChatUser
{
  String userId, name, email , imageUrl , mobile;

  ChatUser();

  ChatUser.fromMap(Map<String, dynamic> data)
  {
    userId = data["userId"];
    name = data ["name"];
    email = data["email"];
    imageUrl = data["imageUrl"];
    mobile = data["mobile"];
  }

  Map<String , dynamic> toMap()
  {
    return 
    {
      "userId" : userId,
      "name" : name,
      "email" : email,
      "imageUrl" : imageUrl,
      "mobile" : imageUrl,

    };
  }

  printData(){
    print("$userId, $name $email $imageUrl $mobile");
  }
}