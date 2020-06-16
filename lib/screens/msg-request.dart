import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/widgets/MessageWidgets/RequestMessageBox.dart';
import './chatbox.dart';
import '../services/auth.dart';

class ChatBox extends StatefulWidget {
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  // final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
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
          leading: Icon(
            IconData(58135,
                fontFamily: 'MaterialIcons', matchTextDirection: true),
            color: Colors.white,
            size: 30.0,
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
            Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection("users").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData)
                  {
                    return Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),);
                  }
                  else
                  {
                    return ListView.builder(
                      padding: EdgeInsets.all(5.0),
                      itemBuilder: (BuildContext context, index){
                        
                        // print("Data : ${snapshot.data.documents[index]['email']}");
                        return Messagebox(email: snapshot.data.documents[index]['userId']);

                      },
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },),
            ),
            ListView(
              children: <Widget>[
                for(int i =1 ;i<6; i++)
                RequestBox(name: "hello",)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
