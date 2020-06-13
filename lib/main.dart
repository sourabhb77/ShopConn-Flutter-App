import 'package:firebase_auth/firebase_auth.dart';
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








// Container(
//                   child: Column(
//                     children: [
//                       Card(
//                         margin: EdgeInsets.all(0.0),
//                         elevation: 0.0,
//                         child: InkWell(
//                           splashColor: Colors.red,
//                           onTap: () {},
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                 flex: 2,
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(horizontal: 15.0),
//                                   color: Colors.blueGrey,
//                                   child: Image.network(
//                                     'https://picsum.photos/250?image=9',
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 4,
//                                 child: Container(
//                                   padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: <Widget>[
//                                       Text(
//                                         bookNotifier.bookList[index].name,
//                                         style: TextStyle(
//                                           color: sc_ItemTitleColor,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18.0 ,
//                                           letterSpacing: 1.0,
//                                         ),
//                                       ),
//                                       Text(
//                                         bookNotifier.bookList[index].description,
//                                         style: TextStyle(
//                                           fontSize: 16.0 ,
//                                           color: sc_ItemInfoColor,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
//                                         child: Text(
//                                           bookNotifier.bookList[index].price.toString(),
//                                           style: TextStyle(
//                                             fontSize: 20.0 ,
//                                             color: sc_PrimaryColor,                                
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
                      
//                     ],
//                   ),
//                 );