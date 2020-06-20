
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/widgets/MessageWidgets/RequestMessageBox.dart';
import './chatbox.dart';
import '../services/auth.dart';

class ChatBox extends StatefulWidget {
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  // final AuthService _auth=AuthService();

 Stream< List<ChatUser> >  getNewRequests() async*
  {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var list = List<ChatUser>();
    
    var ref = await Firestore.instance.collection("request").where("requesterId",isEqualTo: user.uid).snapshots();
    await for(var query in ref){
      for(DocumentSnapshot doc in query.documents)
      {
        var id = doc["requesterId"] ;
        print("DOC: ${doc.data}");
        var userSnap =  await Firestore.instance.collection("users").document(id).get();
        print("UserSnap: ${userSnap.data}");
        var chatUserObject = ChatUser.fromMap(userSnap.data);
        list.add(chatUserObject);
      }
      yield list;
    }
        
      


  //  yield Firestore.instance.collection("users")
  //  .where("userId",whereIn: userList)
  //  .snapshots();
    // yield ref2;
  }



  
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
                        
                        // print("Data : ${snapshot.data.documents[index]["userId"]}");
                        return Messagebox(email: snapshot.data.documents[index]["email"]);

                      },
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },),
            ),

               StreamBuilder(
                // stream: Firestore.instance.collection("request").where("requesterId", isEqualTo:"12312" ).snapshots(),
                stream: getNewRequests(),

                builder: (context,  snapshot)
                {
                  print("*********************************");
                  print(snapshot);
                  if( snapshot.hasError)
                  {
                    return Text("Error has occured");
                  }
                  if(!snapshot.hasData)
                  {
                    return Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),);
                  }
                  else
                  {
                    return ListView.builder(
                      itemBuilder: (context,index)  {
                      // var ref =  Firestore.instance.collection("user").document(snapshot.data.document[index]["requesterId"]).get();
                      // print("Data: ${snapshot.data[index]["imageUrl"]}");
                       print("Index :  $index");
                      //  return Text("hello");
                        return RequestBox( name:snapshot.data[index].toString());
                      },
                      itemCount: snapshot.data.length,
                    );
                  }

                },
              ),
            


            // ListView(
            //   children: <Widget>[
            //     for(int i =1 ;i<6; i++)
            //     RequestBox(name: "hello",)
            //   ],
            // ),


          ],
        ),
      ),
    );
  }
}