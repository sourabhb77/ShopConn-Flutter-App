import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/api/MessageApi.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:tuple/tuple.dart';

class RequestBox extends StatelessWidget {
  // final ChatUser user;
  final MessageRequest request;
  RequestBox({this.request});

  Future<ChatUser> getUserProfile() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String id = request.requesterId;

    var ref = await Firestore.instance.document("users/$id").get();

    return ChatUser.fromMap(ref.data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserProfile(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Text("Error Loading..");
        }
        if (!snap.hasData) {
          return Text("Loading...");
        }
        return RequestCard(user: snap.data, request: request);
      },
    );
  }
}

class RequestCard extends StatelessWidget {
  final ChatUser user;
  final MessageRequest request;
  RequestCard({this.user, this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: sc_PrimaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            // Expanded(
            //   child: CircleAvatar(
            //     radius: 30.0,
            //     backgroundColor: Colors.grey[400],
            //     child: user.imageUrl != null? Image(
            //       image:NetworkImage(user.imageUrl)): Image(
            //       image: AssetImage('assets/images/Symbols.png'),
            //     ),
            //   ),
            // ),
            Expanded(
              child: CircleAvatar(
                radius: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    user != null
                        ? user.imageUrl.length != 0
                            ? user.imageUrl
                            : 'https://image.freepik.com/free-vector/doctor-character-background_1270-83.jpg'
                        : 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(request.requestMessage)
                ],
              ),
            ),
            Expanded(
                child: IconButton(
              icon: new Icon(
                Icons.check,
                color: Colors.green,
                size: 30.0,
              ),
              onPressed: () {
                print("Accepted");
                var t = makeRoom(user.userId, request.requestMessage);
                t.then((value) {
                  if (value == true) {
                    print("Room created");
                  } else
                    print("Room creation failed");
                });
                deleteRequest(request.id);
              },
            )),
            Expanded(
              child: IconButton(
                icon: new Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: 30.0,
                ),
                onPressed: () {
                  deleteRequest(request.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Messagebox extends StatefulWidget {
  ChatRoom room;
  Messagebox({this.room});

  @override
  _MessageboxState createState() => _MessageboxState();
}

class _MessageboxState extends State<Messagebox> {
  ChatUser user;
  ChatMessage _latestMessage;
  String _chatUserId;

  void loadRoomDetails() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String id = user.uid == widget.room.members[0]
        ? widget.room.members[1]
        : widget.room.members[0];

    var ref =
        await Firestore.instance.collection("users").document("$id").get();
    var ref2 = await Firestore.instance
        .collection("rooms/${widget.room.id}/chats")
        .orderBy("timeStamp", descending: true)
        .limit(1)
        .getDocuments();

    setState(() {
      this._chatUserId = id;
      this.user = ChatUser.fromMap(ref.data);
      this._latestMessage = ChatMessage.fromMap(ref2.documents[0].data);
    });
  }

  Future<Tuple3<ChatUser, String, Timestamp>> getLatest() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String id = user.uid == widget.room.members[0]
        ? widget.room.members[1]
        : widget.room.members[0];

    var ref = await Firestore.instance.document("users/$id").get();
    var ref2 = await Firestore.instance
        .collection("rooms/${widget.room.id}/chats")
        .orderBy("timeStamp", descending: true)
        .limit(1)
        .getDocuments();

    return Tuple3(
      ChatUser.fromMap(ref.data),
      ref2.documents[0].data["message"].toString(),
      ref2.documents[0].data["timeStamp"],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null)
      // loadRoomDetails();
      ChatNotifier chatNotifier =
          Provider.of<ChatNotifier>(context, listen: false);
    return FutureBuilder(
      future: getLatest(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error Loading...");
        }
        if (!snapshot.hasData) return Text("Loading....");
        return ChatCard(
            user: snapshot.data.item1,
            latestMessage: snapshot.data.item2,
            lastSeen: snapshot.data.item3,
            room: widget.room);
      },
    );
  }
}

class ChatCard extends StatelessWidget {
  final ChatUser user;
  final String latestMessage;
  final ChatRoom room;
  final Timestamp lastSeen;

  ChatCard({this.user, this.latestMessage, this.room, this.lastSeen});
  @override
  Widget build(BuildContext context) {
    ChatNotifier chatNotifier =
        Provider.of<ChatNotifier>(context, listen: false);
    return Card(
      elevation: 0.0,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          // chatNotifier.setChatUser = user != null ? user.email : null;
          chatNotifier.setChatUserObject = user;
          chatNotifier.setCurrentRoom = room;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    user != null
                        ? user.imageUrl.length != 0
                            ? user.imageUrl
                            : 'https://image.freepik.com/free-vector/doctor-character-background_1270-83.jpg'
                        : 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(user != null ? user.name : "Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.0, color: Colors.black)),
                    Text(
                      latestMessage.length > 12
                          ? latestMessage.substring(0, 12) + "..."
                          : latestMessage,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 100.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      lastSeen != null
                          ? lastSeen.toDate().day.toString() +
                              "/" +
                              lastSeen.toDate().month.toString() +
                              "/" +
                              lastSeen.toDate().year.toString()
                          : "",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      lastSeen != null
                          ? lastSeen.toDate().hour.toString() +
                              ":" +
                              lastSeen.toDate().minute.toString()
                          : "",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
