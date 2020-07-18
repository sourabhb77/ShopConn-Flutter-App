import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/reportApi.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Report.dart';
import 'package:shopconn/notifier/authNotifier.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: sc_PrimaryColor,
          elevation: 0,
          title: Text("About Us"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    child: Image(
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      image: AssetImage("assets/images/aboutPageImage.jpg"),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Positioned(
                    bottom: 45,
                    left: 60,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "About ShopConn",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Connect and Shop.",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "How shopconn works ?",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: sc_ItemTitleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Shopconn App generally help you to sell your book, clothes and notes and provide you platform for selling  products . Just fill in the details of products which is to be sell and post it.You can search for products of our interest and buy the product by sending message to owner.App also factilites you with chat system to interact with different user and message to various product owner and chat efficiently with them. ",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: sc_ItemTitleColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: sc_grey,
              height: 8.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                  child: Text(
                    "Know about us",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: sc_ItemTitleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                "https://s3.amazonaws.com/37assets/svn/765-default-avatar.png"),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Sourabh Bujawade",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: sc_ItemTitleColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                "https://s3.amazonaws.com/37assets/svn/765-default-avatar.png"),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Shubham Bhakuni",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: sc_ItemTitleColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                                "https://s3.amazonaws.com/37assets/svn/765-default-avatar.png"),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Mayuresh Kadam",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: sc_ItemTitleColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: sc_grey,
              height: 15.0,
            ),
          ],
        )));
  }
}
