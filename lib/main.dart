import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/notifier/filterNotifier.dart';
import 'package:shopconn/notifier/noteNotifier.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/notifier/sortNotifier.dart';
import 'package:shopconn/screens/HomeScreen.dart';
import 'package:shopconn/screens/login.dart';
import 'notifier/clothesNotifier.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => BookNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChatNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ClothesNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => NoteNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => OtherNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => SortNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => FilterNotifier(),
      )
    ],
    child: MyApp(),
  ));
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
          )),
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
