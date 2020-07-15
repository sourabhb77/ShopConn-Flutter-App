import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    print("authCredential : ${credential.toString()}");

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
