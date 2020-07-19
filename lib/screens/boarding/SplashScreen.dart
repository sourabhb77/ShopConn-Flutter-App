import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/push_nofitications.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/HomeScreen.dart';
import 'package:shopconn/screens/boarding/boarding.dart';
import 'package:shopconn/screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  Future checkFirstSeen() async {
    //   AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    // initializeCurrentUser(authNotifier);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    bool _logined = (prefs.getBool('logined') ?? false);
    if (_seen) {
      if (!_logined) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else {
        AuthNotifier authNotifier =
            Provider.of<AuthNotifier>(context, listen: true);
        initializeCurrentUser(authNotifier);
        Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
        user.then((FirebaseUser _user) {
          if (_user == null) {
            print("User is null");
          } else {
            print("User is not null , uid: ${_user.uid} email: ${_user.email}");
          }
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BoardingScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
