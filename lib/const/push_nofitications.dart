
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/constants.dart' as constants;
import 'package:shopconn/locator.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/services/navigation_service.dart';

class PushNotificationManager {
  PushNotificationManager._();

  factory PushNotificationManager() => _instance;

  static final PushNotificationManager _instance = PushNotificationManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FirebaseMessaging get fcm => _firebaseMessaging;

  String _uid;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _firebaseMessaging.requestNotificationPermissions();
      // _firebaseMessaging.configure();

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      _uid = user.uid;

      _firebaseMessaging.onTokenRefresh.listen((event) {
        var db = Firestore.instance;
        var ref = Firestore.instance.document("users/$_uid");
        db.runTransaction(
            (transaction) => transaction.update(ref, {constants.fcm: event}));
      });

      String token = await _firebaseMessaging.getToken();
      print("FCM TOKEN : $token");


      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");

        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          locator<NavigationService>().navigateTo("/chatPage");
          

          // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
        },
      );
      _initialized = true;

    }

  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    // GlobalKey key = GlobalKey.c
    // final Item item = _itemForMessage(message);
    // Clear away dialogs
    // Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    // if (!item.route.isCurrent) {
    //   Navigator.push(context, item.route);
    // }
  }
}
