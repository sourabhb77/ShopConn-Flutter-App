import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/AddProductScreen.dart';
import 'package:shopconn/screens/Bookmarks.dart';
import 'package:shopconn/screens/MyProdcuts.dart';
import 'package:shopconn/screens/Profile.dart';
import 'package:shopconn/screens/SettingScreen.dart';
import 'package:shopconn/screens/SavedProductScreen.dart';
import 'package:shopconn/screens/msg-request.dart';
import 'package:shopconn/screens/Profile.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
  FirebaseUser _user;
  String _imageUrl, _name = "Name", _email = "Email";

  // void getDetails() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   DocumentSnapshot profile = await getProfile(user.uid);
  //   setState(() {
  //     _imageUrl = profile.data["imageUrl"];
  //     _name = profile.data["name"];
  //     _email = profile.data["email"];
  //   });
  // }

  @override
  void initState() {
    // getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier _authNotifier = Provider.of<AuthNotifier>(context);
    _imageUrl = _authNotifier.imageUrl;
    _name = _authNotifier.name;
    _email = _authNotifier.email;
    print("Auth notifier : ${_authNotifier.email}");
    print("image: ${_imageUrl}");
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              // backgroundBlendMode: BlendMode.colorDodge, //Don't what this does?
              color: sc_PrimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 45.0,
                  backgroundImage: NetworkImage(
                    _authNotifier.imageUrl == null
                        ? "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"
                        : _authNotifier.imageUrl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
                  child: Text(
                    _authNotifier.name == null ? "Name" : _authNotifier.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: sc_AppBarTextColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatBox()));
            },
            leading: Icon(Icons.message),
            title: Text("Message"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProducts()));
            },
            title: Text("My Products"),
            leading: Icon(Icons.add_to_photos),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookMarks()));
            },
            title: Text("My Bookmarks"),
            leading: Icon(Icons.bookmark),
          ),
          Container(
            color: sc_grey,
            height: 5.0,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
            title: Text("Settings"),
            leading: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
