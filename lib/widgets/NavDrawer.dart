import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/AddProductScreen.dart';
import 'package:shopconn/screens/Bookmarks.dart';
import 'package:shopconn/screens/MyProdcuts.dart';
import 'package:shopconn/screens/Profile.dart';
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
    AuthNotifier _authNotifier = Provider.of<AuthNotifier>(context,listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              // backgroundBlendMode: BlendMode.colorDodge, //Don't what this does?
              color: Colors.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   'Drawer header',
                //   style: TextStyle(
                //     color: Colors.red,
                //     fontSize: 24.0,
                //   ),
                // ),
                _authNotifier.imageUrl == null
                    ? CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"),
                      )
                    : CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(_authNotifier.imageUrl),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: Text(
                    _authNotifier.eamil ==null? "Email" : _authNotifier.eamil,
                    style: TextStyle(
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                Text(
                  _authNotifier.name == null? "Name": _authNotifier.name,
                  style: TextStyle(
                    letterSpacing: 5.0,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            child: ListTile(
              title: Text("Profile"),
              leading: Icon(Icons.person),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SavedProductScreen()));
            },
            title: Text("Settings"),
            leading: Icon(Icons.settings),
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
            leading: Icon(Icons.add_to_photos),
          )
        ],
      ),
    );
  }
}
