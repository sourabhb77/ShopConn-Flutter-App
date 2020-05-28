import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/screens/HomeScreen.dart';
import 'package:shopconn/screens/ProductDetailScreen_Book.dart';
import 'package:shopconn/screens/SavedProductScreen.dart';
import 'package:shopconn/screens/Wrapper.dart';
import 'package:shopconn/screens/boarding/boarding.dart';
import 'package:shopconn/screens/signUP.dart';
import 'package:shopconn/screens/login.dart';



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

      // home: AddProuctScreen(),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? HomeScreen() : Login();
        },
      ),
    );
  }
}
