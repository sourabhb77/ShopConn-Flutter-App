import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/AboutUsScreen.dart';
import 'package:shopconn/screens/Bookmarks.dart';
import 'package:shopconn/screens/MyProdcuts.dart';
import 'package:shopconn/screens/MyPurchase.dart';
import 'package:shopconn/screens/Profile.dart';
import 'package:shopconn/screens/ReportScreen.dart';
import 'package:shopconn/screens/SavedProductScreen.dart';
import 'package:shopconn/screens/login.dart';
import 'package:shopconn/screens/msg-request.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String name, imageUrl, mobile, email;
  String _user;
  AuthNotifier authNotifier;
  void loadUserDetails() async {
    _user = await getCurrentUser(authNotifier);
    DocumentSnapshot snapshot = await getProfile(_user);
    setState(() {
      imageUrl = snapshot.data["imageUrl"];
      name = snapshot.data["name"];
      mobile = snapshot.data["mobile"];
      email = snapshot.data["email"];
    });
  }

  _clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logined', false);
  }

  @override
  void initState() {
    loadUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sc_PrimaryColor,
        elevation: 0,
        title: Text("My Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: sc_PrimaryColor,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              imageUrl == null
                                  ? "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"
                                  : imageUrl,
                            ),
                            radius: 45,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                  color: sc_grey,
                                  fontSize: 16.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                name == null ? "" : name,
                                style: TextStyle(
                                  color: sc_AppBarTextColor,
                                  fontSize: 18.0,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                email == null ? "" : email,
                                style: TextStyle(
                                  color: sc_AppBarTextColor,
                                  fontSize: 16.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    // splashRadius: 30.0,
                    padding: EdgeInsets.all(0),
                    splashColor: sc_PrimaryColor,
                  ),
                ],
              ),
            ),
            Container(
              color: sc_grey,
              height: 10.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProducts()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Products",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: sc_grey,
              height: 2.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPurchase()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Purchase",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: sc_grey,
              height: 2.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBox()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Messages",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: sc_grey,
              height: 2.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookMarks()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Saved Products",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: sc_grey,
              height: 8.0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 17.0, 15.0, 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: sc_grey,
              height: 2.0,
            ),
            InkWell(
              onTap: () {
                signout(authNotifier);
                // Navigator.of(context).popUntil((route) => false);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => Login()));

                _clearUser();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LOG OUT",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: sc_grey,
              height: 8.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 17.0, 15.0, 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: sc_grey,
              height: 2.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReportScreen()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Report Bug",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: sc_grey,
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
