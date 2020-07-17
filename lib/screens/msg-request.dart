import 'dart:async';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/MessageApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/widgets/MessageWidgets/RequestMessageBox.dart';
// import 'package:stream_transform/stream_transform.dart';
import './chatbox.dart';
import '../services/auth.dart';

class ChatBox extends StatefulWidget {
  Stream<List<ChatUser>> getNewRequestsStream() async* {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var list = List<ChatUser>();

    var ref = await Firestore.instance
        .collection("request")
        .where("requesterId", isEqualTo: user.uid)
        .snapshots();
    await for (var query in ref) {
      for (DocumentSnapshot doc in query.documents) {
        var id = doc["requesterId"];
        print("DOC: ${doc.data}");
        var userSnap =
            await Firestore.instance.collection("users").document(id).get();
        print("UserSnap: ${userSnap.data}");
        var chatUserObject = ChatUser.fromMap(userSnap.data);
        // controller.add(chatUserObject);
        list.add(chatUserObject);
      }
      // controller.add(list);
      yield list;
    }

    //  yield Firestore.instance.collection("users")
    //  .where("userId",whereIn: userList)
    //  .snapshots();
    // yield ref2;
  }

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  // final AuthService _auth=AuthService();

  StreamController<List<QuerySnapshot>> streamController =
      StreamController<List<QuerySnapshot>>();

  AuthNotifier authNotifier;

  List<Stream<QuerySnapshot>> streams;

  Stream s1;

  // final StreamController<List<ChatUser> > controller = StreamController <List<ChatUser > > .broadcast();

  @override
  void initState() {
    s1 = widget.getNewRequestsStream().asBroadcastStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    // getStreams();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: sc_PrimaryColor,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
            tabs: [
              Tab(
                text: "MESSAGES",
              ),
              Tab(text: "NEW REQUEST"),
            ],
          ),
          title: Text(
            'Chat box',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                IconData(59574, fontFamily: 'MaterialIcons'),
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                IconData(59576, fontFamily: 'MaterialIcons'),
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {},
            ),
          ],
          elevation: 1.0,
        ),
        body: TabBarView(
          children: [
            MessageStream(),
            RequestStream(),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatefulWidget {
  @override
  _MessageStreamState createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  // StreamController<List<QuerySnapshot>> _controller;

  StreamController<DocumentSnapshot> controller =
      StreamController<DocumentSnapshot>.broadcast();

  void updateMyUI(DocumentSnapshot snap) => controller.sink.add(snap);

  @override
  void initState() {
    super.initState();
    // loadDetails(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return StreamBuilder(
      stream: Firestore.instance
          .collectionGroup("rooms")
          .where("members", arrayContainsAny: [authNotifier.userId])
          .orderBy("timeStamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        print("User Id: ${authNotifier.userId}");
        if (snapshot.hasError) return Text("Error");
        if (!snapshot.hasData) {
          // return Text("Loading...");
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }
        if (snapshot.data.documents.length == 0) {
          return Center(
            child: Text("No Messages"),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
        print("Snapshot lenght : ${snapshot.data.documents[index].data}");

            return Messagebox(
              room: ChatRoom.fromMap(snapshot.data.documents[index].data),
            );
          },
          itemCount: snapshot.data.documents.length,
        );
      },
    );
  }
}

class RequestStream extends StatefulWidget {
  const RequestStream({Key key}) : super(key: key);

  @override
  _RequestStream createState() => _RequestStream();
}

class _RequestStream extends State<RequestStream> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return StreamBuilder(
      // stream: Firestore.instance.collection("request").where("requesterId", isEqualTo:"12312" ).snapshots(),
      stream: Firestore.instance
          .collection("request")
          .where("requestedId", isEqualTo: authNotifier.userId)
          .orderBy('timeStamp', descending: true)
          .snapshots(),

      builder: (context, snapshot) {
        print("*********************************");
        print(snapshot);
        print("Snapshot request : ${snapshot.data}");
        if (snapshot.hasError) {
          return Text("Error has occured");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        } else if (snapshot.data.documents.length != 0) {
          return ListView.builder(
            itemBuilder: (context, index) {
              print("Length : ${snapshot.data.documents.length}");
              return RequestBox(
                  request: MessageRequest.fromMap(
                      snapshot.data.documents[index].data));
            },
            itemCount: snapshot.data.documents.length,
          );
        } else {
          return Center(
            child: Text("No request"),
          );
        }
      },
    );
  }
}
