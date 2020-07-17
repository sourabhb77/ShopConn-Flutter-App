import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/screens/AddProductScreen.dart';
import 'package:shopconn/widgets/Item.dart';
import 'dart:math' as math;

import 'package:tuple/tuple.dart';

// import 'package:shopconn/widgets/MessageWidgets/RequestMessageBox.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

enum Action { markAsSold, deleteProduct }

class _MyProductsState extends State<MyProducts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String string) {
    var snackBar = new SnackBar(
      content: new Text(
        string,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
      backgroundColor: Colors.teal,
      action: SnackBarAction(
        label: "Ok",
        textColor: Colors.white,
        onPressed: () {},
      ),
      elevation: 4.0,
    );
    if (_scaffoldKey.currentState != null)
      _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _showModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          AuthNotifier authNotifier =
              Provider.of<AuthNotifier>(context, listen: true);
          ProductNotifier productNotifier =
              Provider.of<ProductNotifier>(context, listen: true);
          List userList = [];
          userList.add(authNotifier.userId);
          String ownerId = "";
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Who is Buyer ?",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: sc_ItemTitleColor,
                            ),
                          ),
                          OutlineButton(
                            // elevation: 0,
                            color: sc_PrimaryColor,
                            padding:
                                EdgeInsets.fromLTRB(13.0, 10.0, 13.0, 10.0),
                            child: Text(
                              'Confirm As SOLD',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            onPressed: () {
                              if (ownerId != "") {
                                markAsSold(
                                  productNotifier.currentProduct["id"],
                                  ownerId,
                                );
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: Firestore.instance
                          .collectionGroup("rooms")
                          .where("members", arrayContainsAny: userList)
                          .orderBy("timeStamp", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return Text("Error");
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          );
                        }
                        if (snapshot.data.documents.length == 0) {
                          return Center(
                            child: Text("No Contacts"),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: sc_PrimaryColor,
                              onTap: () {
                                print("adding buyer");
                                setState(() {
                                  if (authNotifier.userId !=
                                      snapshot
                                          .data.documents[index]["members"][0]
                                          .toString()) {
                                    setState(() {
                                      ownerId = snapshot
                                          .data.documents[index]["members"][0]
                                          .toString();
                                    });
                                  } else if (authNotifier.userId !=
                                      snapshot
                                          .data.documents[index]["members"][1]
                                          .toString()) {
                                    setState(() {
                                      ownerId = snapshot
                                          .data.documents[index]["members"][1]
                                          .toString();
                                    });
                                  } else if (authNotifier.userId ==
                                      snapshot
                                          .data.documents[index]["members"][0]
                                          .toString()) {
                                    setState(() {
                                      ownerId = "";
                                    });
                                  } else if (authNotifier.userId ==
                                      snapshot
                                          .data.documents[index]["members"][1]
                                          .toString()) {
                                    setState(() {
                                      ownerId = "";
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: ownerId ==
                                              snapshot
                                                  .data
                                                  .documents[index]["members"]
                                                      [0]
                                                  .toString() ||
                                          ownerId ==
                                              snapshot
                                                  .data
                                                  .documents[index]["members"]
                                                      [1]
                                                  .toString()
                                      ? Border.all(
                                          color: sc_PrimaryColor,
                                          width: 2.0,
                                        )
                                      : null,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                child: Messagebox(
                                  room: ChatRoom.fromMap(
                                      snapshot.data.documents[index].data),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data.documents.length,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier _authNotifier = Provider.of<AuthNotifier>(context);
    ProductNotifier _productNotifier = Provider.of<ProductNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: sc_PrimaryColor,
        title: Text(
          "My Products",
          style: TextStyle(color: sc_AppBarTextColor),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("post")
            .where("ownerId", isEqualTo: _authNotifier.userId)
            .orderBy("postedAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("error");

          if (!snapshot.hasData) return Text("Loading...");

          return ListView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ProductItem(
                    data: snapshot.data.documents[index],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: PopupMenuButton<Action>(
                      onSelected: (Action result) {
                        if (result == Action.deleteProduct) {
                          Future<bool> res = deleteProduct(
                              snapshot.data.documents[index]["id"]);
                          res.then((value) {
                            if (value == true) {
                              showSnackBar("Product Deleted");
                            } else {
                              showSnackBar("Product not Deleted");
                            }
                          });
                        } else {
                          _productNotifier.currentProduct =
                              snapshot.data.documents[index];
                          _showModalBottomSheet(context);
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<Action>>[
                        snapshot.data.documents[index]["buyerId"].toString() ==
                                ""
                            ? PopupMenuItem<Action>(
                                value: Action.markAsSold,
                                child: Text('Mark As SOLD'),
                              )
                            : null,
                        PopupMenuItem<Action>(
                          value: Action.deleteProduct,
                          child: Text('Delete Product'),
                        ),
                      ],
                    ),
                  ),
                  snapshot.data.documents[index]["buyerId"] != ""
                      ? Positioned(
                          top: 12,
                          left: 4,
                          child: Transform.rotate(
                            angle: -math.pi / 4,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                              color: sc_PrimaryColor,
                              child: Text(
                                'SOLD',
                                style: TextStyle(
                                  color: sc_AppBarTextColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              );
            },
            itemCount: snapshot.data.documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProuctScreen()),
            );
            print("go to add product screen");
          },
          child: Icon(Icons.add),
          backgroundColor: sc_PrimaryColor),
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

  Future<Tuple2<ChatUser, String>> getLatest() async {
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

    return Tuple2(ChatUser.fromMap(ref.data),
        ref2.documents[0].data["message"].toString());
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
        );
      },
    );
  }
}

class ChatCard extends StatelessWidget {
  final ChatUser user;
  ChatCard({this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
                radius: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    user != null
                        ? user.imageUrl.length != 0
                            ? user.imageUrl
                            : 'https://image.freepik.com/free-vector/doctor-character-background_1270-83.jpg'
                        : 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(user != null ? user.name : "name",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
