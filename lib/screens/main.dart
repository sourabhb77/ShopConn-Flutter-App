// import 'package:book/signUP.dart';
import 'package:book/Wrapper.dart';
import 'package:book/services/auth.dart';
import 'package:flutter/material.dart';
// import 'package:book/msg-request.dart';
// import 'package:book/login.dart';
import 'package:book/models/user.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
  }
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return StreamProvider<User>.value(
        value: AuthService().user,
              child: MaterialApp(
          title: 'Book',
          home:Wrapper(),
          // home: ChatBox(),
          // home:SignUp(),
        ),
      );
    }
  }