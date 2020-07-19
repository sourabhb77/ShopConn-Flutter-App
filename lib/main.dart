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
import 'package:shopconn/screens/boarding/SplashScreen.dart';
import 'package:shopconn/screens/login.dart';
import 'package:shopconn/screens/msg-request.dart';
import 'package:shopconn/services/navigation_service.dart';
import 'notifier/clothesNotifier.dart';
import 'locator.dart';
// fHfBmaCzAYU:APA91bGRk7SdcEr6gEGSX5xl246IKEr7h7VI-WLtm_WqJu3fwv_0iY3-xYy2VfNOw9bXSvOL-Wih6tZiOBQZumlQ8KIQjWAZQ_uKesvOvL_JNjHM9VubphKI0iS-n-FkE4FAYAzIVCen
// fHfBmaCzAYU:APA91bGRk7SdcEr6gEGSX5xl246IKEr7h7VI-WLtm_WqJu3fwv_0iY3-xYy2VfNOw9bXSvOL-Wih6tZiOBQZumlQ8KIQjWAZQ_uKesvOvL_JNjHM9VubphKI0iS-n-FkE4FAYAzIVCen
void main() {
  setupLocator();
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
    // AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShoppConn',
      theme: ThemeData(
          scaffoldBackgroundColor: sc_BackgroundColor,
          // fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText2: TextStyle(color: sc_BodyTextColor),
          )),
      // home: SplashScreen(),
      routes: {
        '/login': (contex) => Login(),
        '/chatPage' : (context) => ChatBox(),
      },
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return SplashScreen();
          // return notifier.user != null ? HomeScreen() : Login();
        },
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
