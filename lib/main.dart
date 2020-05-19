import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/screens/AddProductScreen.dart';

void main() {
  runApp(MyApp());
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
      home: AddProuctScreen(),
    );
  }
}
