import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';

class ChatPage extends StatefulWidget {
  String ownerId;
  ChatPage({Key key, @required this.ownerId}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState(ownerId);
}

class _ChatPageState extends State < ChatPage > {
  String ownerId;
  _ChatPageState(this.ownerId);
  String name;
  String profileImg;

  Future<void> loadUserDetails() async {
    DocumentSnapshot snapshot = await getProfile(ownerId);
    setState(() {
      profileImg = snapshot.data["imageUrl"];
      name = snapshot.data["name"];
    });
  }

  @override
  void initState() {
    loadUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(ownerId);
    return Scaffold(
      appBar: AppBar(
        title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              InkWell(
                  onTap: () {
                    print ('Profile');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      profileImg !=null ? profileImg
                      : 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      height: 45,
                      width: 45,
                      fit: BoxFit.fill,
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  name != null ? name : "",
                )
              ),
            ],

          ),
        backgroundColor: sc_PrimaryColor
      ),

      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.white,
          color: sc_InputBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: < Widget > [
            SizedBox(width: 10.0,),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 0),
                child: Icon(
                  IconData(
                    58430,
                    fontFamily: 'MaterialIcons'
                  ),
                ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              flex: 5,
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: sc_InputBackgroundColor,
                  filled: true,
                  // prefixIcon: 
                  hintText: 'type here ..',
                  border: InputBorder.none,
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                IconData(
                  57699,
                  fontFamily: 'MaterialIcons',
                  matchTextDirection: true
                )
              )
            )
          ],
        ), 
      ),

      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: < Widget > [
              Text("sejwhegcbwbewv;evv"),
              SizedBox(height: 3.0,),
            ],
          ),
        )
      
    );
  }
}
// void main()=>runApp(MaterialApp(
//   home: ));