// import 'package:shopconn/screens/Wrapper.dart';
import 'dart:js';

import 'package:shopconn/notifier/clothes_notifier.dart';
import 'package:shopconn/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shopconn/screens/AddProductScreen.dart';
import 'package:shopconn/models/user.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(providers:[
      ChangeNotifierProvider(builder: (context)=>ClothesNotifier())
      ],)
  );
  }
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return StreamProvider<User>.value(
        value: AuthService().user,
              child: MaterialApp(
          title: 'Book',
          home:AddProuctScreen(),
          // home:Wrapper(),
          // home: ChatBox(),
          // home:SignUp(),
        ),
      );
    }
  }