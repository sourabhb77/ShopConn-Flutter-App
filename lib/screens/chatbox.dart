import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/widgets/MessageWidgets/ChatMessageBox.dart';

const defaultUserName = "Doctor Daddy";

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);
  @override
  State createState() => Chat();
}

class Chat extends State<ChatPage> with TickerProviderStateMixin {
  ChatUser _user;
  ChatRoom _currentRoom;

  // final List<Msg> _messages = <Msg>[]; //list of messages
  ChatNotifier chatNotifier;
  AuthNotifier authNotifier;
  final TextEditingController _textController = new TextEditingController();

  bool _isWriting = false;

  Future<void> sendMessage(String msg) async {
    if (_currentRoom == null || msg.length == 0) return;
    print("Message written : $msg");
    DocumentReference ref = Firestore.instance
        .collection("rooms/${_currentRoom.id}/chats")
        .document();

    ChatMessage message = ChatMessage();
    message.id = ref.documentID;
    message.message = msg;
    message.sender = authNotifier.userId;
    message.receiver = authNotifier.userId == _currentRoom.members[0]
        ? _currentRoom.members[1]
        : _currentRoom.members[0];

    try {
      await ref.setData(message.toMap());
      var roomRef = Firestore.instance.document("rooms/${_currentRoom.id}");
      await roomRef
          .setData({"timeStamp": FieldValue.serverTimestamp()}, merge: true);
    } catch (err) {
      print("Error occured: $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    chatNotifier = Provider.of<ChatNotifier>(context);
    authNotifier = Provider.of<AuthNotifier>(context);
    _user = chatNotifier.currentUser;
    _currentRoom = chatNotifier.currentRoom;

    // if (_user == null || _currentRoom == null) {
    //   setState(() {
    //     _user = chatNotifier.currentUser;
    //     _currentRoom = chatNotifier.currentRoom;
    //     print("User: $_user");
    //   });
    // }

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
                    _user != null
                        ? _user.imageUrl
                        : 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                    height: 45,
                    width: 45,
                    fit: BoxFit.fill,
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(_user != null ? _user.name : ""),
            ),
          ],
        ),
        backgroundColor: sc_PrimaryColor,
      ),
      body: (Column(
        children: <Widget>[
          // new Flexible(

          //     child: new ListView.builder(
          //         itemBuilder: (_, int index) {
          //           return _messages[index];

          //         } ,
          //         itemCount: _messages.length,
          //         reverse: true,
          //         padding: new EdgeInsets.all(6.0))),
          Flexible(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("rooms/${_currentRoom.id}/chats")
                  .orderBy("timeStamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text("Error");
                if (!snapshot.hasData) return Text("Loading ....");

                return ListView.builder(
                    itemBuilder: (_, int index) {
                      // return Text(snapshot.data.documents[index]["message"]);
                      return ChatMessageBox(
                          message: ChatMessage.fromMap(
                        snapshot.data.documents[index].data,
                      ));
                    },
                    itemCount: snapshot.data.documents.length,
                    reverse: false,
                    padding: EdgeInsets.all(6.0));
              },
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
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
                      controller: _textController,
                      onChanged: (String txt) {
                        setState(() {
                          _isWriting = txt.length > 0;
                        });
                      },
                      onSubmitted: _submitMsg,
                      decoration: InputDecoration(
                        fillColor: sc_InputBackgroundColor,
                        filled: true,
                        // prefixIcon: Padding(
                        //   padding: const EdgeInsetsDirectional.only(start: 0),
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
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendMessage(_textController.text);

                        _isWriting ? _submitMsg(_textController.text) : null;
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
        ],
      )),
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
  }
}

//message dipose function

//   void _submitMsg(String txt) {
//     _textController.clear();
//     setState(() {
//       _isWriting = false;
//     });
//     Msg msg = new Msg(
//       txt: txt,
//       animationController: new AnimationController(
//           vsync: this, duration: new Duration(milliseconds: 800)),
//     );
//     setState(() {
//       _messages.insert(0, msg);
//     });
//     msg.animationController.forward();

//     @override
//     void dispose() {
//       for (Msg msg in _messages) {
//         msg.animationController.dispose();
//       }
//       super.dispose();
//     }
//   }
// }

// class Msg extends StatelessWidget {
//   Msg({this.txt, this.animationController});
//   final String txt;
//   final AnimationController animationController;

//   @override
//   Widget build(BuildContext context) {
//     return new SizeTransition(
//       sizeFactor: new CurvedAnimation(
//           parent: animationController, curve: Curves.bounceOut),
//       axisAlignment: 0.0,
//       //message container
//       child: new Container(
//         margin: const EdgeInsets.symmetric(vertical: 8.0),
//         child: new Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new Container(
//               margin: EdgeInsets.only(right: 10.0),
//               child: new CircleAvatar(
//                   child: new Text(defaultUserName[0])), //can add image here
//             ),
//             new Expanded(
//                 child: Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: new Container(
//                   child: new Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   new Text(
//                     defaultUserName,
//                     style: new TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   new Container(
//                     margin: const EdgeInsets.only(top: 6.0),
//                     child: new Text(txt,
//                         style: new TextStyle(
//                           fontWeight: FontWeight.w300,
//                         )),
//                   )
//                 ],
//               )),
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
