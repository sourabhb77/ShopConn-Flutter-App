class User {
  String displayName;
  String email;
  String password;
  User();

}
class ChatUser
{
  String displayName;
  String email;
  String imageUrl;
  String userId;
  ChatUser();

  ChatUser.fromMap(Map<String, dynamic> data)
  {
    displayName = data["name"];

    email = data["email"];

    imageUrl = data["imageUrl"];

    userId = data["userId"]; 

  }
}