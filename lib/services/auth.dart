import 'package:shopconn/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

final FirebaseAuth _auth = FirebaseAuth.instance;

User _userFromFirebaseUser(FirebaseUser user)
{
  return user!=null ? User(uid: user.uid):null;
}

Stream<User>get user
{
 return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
}

// Future signInAnonmously()async
// {
//  try{
//  AuthResult result = await _auth.signInAnonymously();
//  FirebaseUser user= result.user;
//  return _userFirebase(user);
//  }
//  catch(e)
//  {
//   print(e.toString());
//   return null;
//  }
// }

Future signInwithEmailAndPassword(String email,String password) async{
try{
 AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
 FirebaseUser user= result.user;
 return _userFromFirebaseUser(user);
}
catch(e){
 print(e.toString());
 return null;
}
}


Future registerwithEmailAndPassword(String email,String password) async{
try{
 AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
 FirebaseUser user= result.user;
 return _userFromFirebaseUser(user);
}
catch(e){
 print(e.toString());
 return null;
}
}



Future signOut() async{
try{
  return await _auth.signOut();
}
catch(e){
  print(e.toString());
  return null;
}
}

}

