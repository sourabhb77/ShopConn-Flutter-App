// import 'package:book/signUP.dart';
import 'package:flutter/material.dart';
import 'package:book/msg-request.dart';
// import 'package:book/login.dart';

void main(){
  runApp(MyApp());
  }
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Book',
        // home:Login()
        home: ChatBox(),
        // home:SignUp(),

      );
    }
  }