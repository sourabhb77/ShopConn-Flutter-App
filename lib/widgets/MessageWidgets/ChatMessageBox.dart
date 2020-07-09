import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';

class ChatMessageBox extends StatelessWidget {
  final ChatMessage message;
  ChatMessageBox({this.message});

  @override
  Widget build(BuildContext context) {
    AuthNotifier authnotifier = Provider.of<AuthNotifier>(context);

    bool sender = authnotifier.userId == message.sender;

    return 1 == 0
        ? Column(
            crossAxisAlignment:
                sender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: new Text(message.message,
                    style: new TextStyle(
                      fontWeight: FontWeight.w300,
                    )),
              ),
            ],
          )
        : text(context);
  }

  Widget text(BuildContext context) {
    int hour = message.timeStamp != null ? message.timeStamp.toDate().hour : 0;
    int minute =
        message.timeStamp != null ? message.timeStamp.toDate().minute : 0;

    AuthNotifier authnotifier = Provider.of<AuthNotifier>(context);

    bool sender = authnotifier.userId == message.sender;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: sc_AppBarBackgroundColor, //Change color!!!
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Column(
                crossAxisAlignment:
                    sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message != null ? message.message : "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "$hour:$minute",
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

const defaultUserName = "Doctor Daddy";

class ChatBoxImage extends StatelessWidget {
  final String imageUrl;
  ChatBoxImage({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: imageUrl != null
            ? Image.network(
                imageUrl,
                height: 45,
                width: 45,
                fit: BoxFit.fill,
              )
            : CircleAvatar(
                radius: 28,
                child: Text(defaultUserName[0]),
              ),
      ),
    );
  }
}
