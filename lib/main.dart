import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';

import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/notifier/notesNotifier.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/screens/HomeScreen.dart';
import 'package:shopconn/screens/ProductDetailScreen_Book.dart';
import 'package:shopconn/screens/SavedProductScreen.dart';
import 'package:shopconn/screens/Wrapper.dart';
import 'package:shopconn/screens/boarding/boarding.dart';
import 'package:shopconn/screens/msg-request.dart';
import 'package:shopconn/screens/signUP.dart';
import 'package:shopconn/screens/login.dart';
import 'notifier/clothesNotifier.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatNotifier()
        ),
        ChangeNotifierProvider(
          create: (context) => ClothesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context)=>NotesNotifier(),
          ),
        ChangeNotifierProvider(
          create: (context)=>OtherNotifier(),
          ),
      ],
      child: MyApp(),
    )
  );
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShoppConn',
      theme: ThemeData(
          scaffoldBackgroundColor: sc_BackgroundColor,
          // fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText2: TextStyle(color: sc_BodyTextColor),
          )
      ),
      //home: ChatBox(),
      // home: AddProuctScreen(),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? HomeScreen() : Login();
        },
      ),
    );
  }
}

