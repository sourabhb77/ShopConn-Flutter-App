import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/MessageApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/screens/Profile.dart';
import 'package:shopconn/screens/chatbox.dart';

const defaultUserChatBoxWidget = "Doctor Daddy";

class ChatBoxWidget extends StatefulWidget {
  String ownerId;
  ChatBoxWidget({Key key, @required this.ownerId}) : super(key: key);
  @override
  _ChatBoxWidgetState createState() => _ChatBoxWidgetState(ownerId);
}

class _ChatBoxWidgetState extends State<ChatBoxWidget>
    with TickerProviderStateMixin {
  String _sender;
  String _user;
  File image;
  ProfilePicState state = ProfilePicState.Default;
  bool selected = false;
  String ChatBoxWidget, imageUrl, ChatBoxWidgetRec, imageUrlRec;
  StorageReference storageReference;
  String ownerId;
  String txt = "I am interested in your product";
  bool one = false;

  final List<Msg> _messages = <Msg>[]; //list of messages
  AuthNotifier authNotifier;
  BookNotifier bookNotifier;
  final TextEditingController _textController = new TextEditingController()
    ..text = "Hey, I am interested in your product";

  bool _isWriting = false;

  bool sentRequest = false;

  _ChatBoxWidgetState(this.ownerId) {
    inituserData();
  }

  sendRequest(String userId, String ownerId, String currentBookId,
      String message) async {
    await sendNewRequest(userId, ownerId, currentBookId, message);
    setState(() {
      sentRequest = true;
    });
  }

  String ownerName, message;
  @override
  void initState() {
    super.initState();
    setState(() {
      message = _textController.text;
    });
    isAlreadyRequested();
  }

  isAlreadyRequested() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;

    CollectionReference ref = Firestore.instance.collection("request");
    QuerySnapshot snap = await ref
        .where("requestedId", isEqualTo: ownerId)
        .where("requesterId", isEqualTo: userId)
        .getDocuments();
    if (snap.documents.length != 0) {
      setState(() {
        sentRequest = true;
      });
    } else {
      setState(() {
        sentRequest = false;
      });
    }
  }

  Future<List<ChatUser>> getNewRequest() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;

    CollectionReference ref = Firestore.instance.collection("request");
    var query = ref
        .where("requestedId", isEqualTo: userId)
        .orderBy('timeStamp', descending: true);

    List<ChatUser> list = List();
    QuerySnapshot snaps = await query.getDocuments();
    for (DocumentSnapshot doc in snaps.documents) {
      var message_req = MessageRequest.fromMap(doc.data);
      DocumentSnapshot user = await Firestore.instance
          .collection("users")
          .document(message_req.requesterId)
          .get();

      print("Chat user data: ${user.data}");

      list.add(ChatUser.fromMap(user.data));
    }
    print("***************************");
    print("list size: ${list.length}");
    print("userID : $userId ");
    print("***************************");

    return list;
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    bookNotifier = Provider.of<BookNotifier>(context);

    void loadUserDetails() async {
      if (imageUrl == null) {
        print("*******************************************************");
        _sender = await getCurrentUser(authNotifier);
        DocumentSnapshot snapshot = await getProfile(_sender);
        print("SnapShot : ${snapshot.data.toString()}");
        setState(() {
          print("setting state");
          imageUrl = snapshot.data["imageUrl"];
          ChatBoxWidget = snapshot.data["ChatBoxWidget"];
        });
      }
      print("Image URL : $imageUrl ChatBoxWidget : $ChatBoxWidget");
    }

    void loadreceiverdetails() async {
      if (ownerName == null || imageUrlRec == null) {
        DocumentSnapshot snapshot = await getProfile(ownerId);
        print("SnapShot : ${snapshot.data.toString()}");
        setState(() {
          print("setting state");
          imageUrlRec = snapshot.data["imageUrl"];
          ownerName = snapshot.data["name"];
          ChatBoxWidgetRec = snapshot.data["ChatBoxWidget"];
        });
      }
      print("Image URL : $imageUrl ChatBoxWidget : $ChatBoxWidget");
    }

    loadUserDetails();
    loadreceiverdetails();
    //Function to send Message

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  print('Profile');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    // 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                    imageUrlRec != null
                        ? imageUrlRec
                        : 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                    height: 45,
                    width: 45,
                    fit: BoxFit.fill,
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(ownerName != null ? ownerName : ""),
            ),
          ],
        ),
        backgroundColor: sc_PrimaryColor,
      ),
      body: Column(
        children: <Widget>[
          new Flexible(
            child: ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: EdgeInsets.all(6.0),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          sentRequest
              ? Container(
                  color: sc_InputBackgroundColor,
                  height: 100.0,
                  child: Center(child: Text("Your request is sent")),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: sc_InputBackgroundColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 5,
                        child: TextField(
                            autofocus: true,
                            controller: _textController,
                            onChanged: (String txt) {
                              setState(() {
                                message = txt;
                                _isWriting = txt.length > 0;
                              });
                            },
                            onSubmitted: _submitMsg,
                            decoration: InputDecoration(
                              fillColor: sc_InputBackgroundColor,
                              filled: true,
                              // prefixIcon: Padding(
                              //   padding:
                              //       const EdgeInsetsDirectional.only(start: 0),
                              //   child: Icon(
                              //     IconData(58430, fontFamily: 'MaterialIcons'),
                              //   ),
                              // ),
                              hintText: 'type here ..',
                              border: InputBorder.none,
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(IconData(57699,
                                fontFamily: 'MaterialIcons',
                                matchTextDirection: true)),
                            onPressed: () {
                              // sendMessage(_textController.text);
                              if (_textController.text != null) {
                                _submitMsg(_textController.text);
                                print(_textController.text);
                                print(
                                    "Sending Chat Request NOW ****************");
                                sendRequest(
                                  authNotifier.userId,
                                  bookNotifier.currentBook.ownerId,
                                  bookNotifier.currentBook.id,
                                  message,
                                );

                                print("REquest send");
                              }
                              // _isWriting ? _submitMsg(_textController.text) : null;
                            }),
                      ),
                    ],
                  ),
                ),
          SizedBox(
            height: 3.0,
          ),
        ],
      ),
    );
  }

  //message dipose function

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      imageUrl: imageUrl,
      ChatBoxWidget: ChatBoxWidget,
      animationController: AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    if (one == false) {
      setState(() {
        _messages.insert(0, msg);
        one = true;
      });
      msg.animationController.forward();
    }
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

void inituserData() {}

class Msg extends StatelessWidget {
  Msg({this.txt, this.imageUrl, this.ChatBoxWidget, this.animationController});
  final String imageUrl;
  final String ChatBoxWidget;
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,
      //message container
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: imageUrl != null
                        ? Image.network(
                            // 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                            imageUrl,
                            height: 45,
                            width: 45,
                            fit: BoxFit.fill,
                          )
                        : CircleAvatar(
                            radius: 28,
                            child: Text(defaultUserChatBoxWidget[0]),
                          ),
                  ),
                ),
                new Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: new Container(
                      child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        ChatBoxWidget == null
                            ? defaultUserChatBoxWidget
                            : ChatBoxWidget,
                        style: new TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        child: new Text(txt,
                            style: new TextStyle(
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                    ],
                  )),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
