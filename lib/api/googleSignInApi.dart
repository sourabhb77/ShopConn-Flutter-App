import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopconn/const/constants.dart';
import 'package:shopconn/const/push_nofitications.dart';

Future<bool> signInWithGoogle() async {
  try {
    print("Starting Sigin With google");
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print("Starting Sigin With google");

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return true;
  } catch (err) {
    print("Error With google signin : $err");
    return false;
  }
}

Future<void> signOutGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
}

Future<FirebaseUser> handleSignIn() async {
  // hold the instance of the authenticated user
  FirebaseUser user;

  GoogleSignIn _googleSignIn;
  FirebaseAuth _auth = FirebaseAuth.instance;
  // flag to check whether we're signed in already
  bool isSignedIn = await _googleSignIn.isSignedIn();
  if (isSignedIn) {
    // if so, return the current user
    user = await _auth.currentUser();
  } else {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // get the credentials to (access / id token)
    // to sign in via Firebase Authentication
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    user = (await _auth.signInWithCredential(credential)).user;
  }

  return user;
}

Future<void> saveDeviceToken() async {
  PushNotificationManager manager = PushNotificationManager();

  try {
    print("*****************************************************************************************");
    String token = await manager.fcm.getToken();

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;

    var db = Firestore.instance;
    var ref = db.collection("users").document(uid);
    ref.setData({fcm: token}, merge: true);
  } catch (err) {
    print("Error Updating FCm token  ; $err");
  }
}
