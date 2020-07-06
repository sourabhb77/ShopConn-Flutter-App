  
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

const defaultUserName = "Doctor Daddy";

class ChatBoxWidget extends StatefulWidget {
  String ownerId;
  ChatBoxWidget({Key key,@required this.ownerId}) : super(key: key);
  @override
  _ChatBoxWidgetState createState() => _ChatBoxWidgetState(ownerId);
}

class _ChatBoxWidgetState extends State<ChatBoxWidget> with TickerProviderStateMixin {
  String _sender;
  String _user;
  File image;
  ProfilePicState state = ProfilePicState.Default;
  bool selected = false;
  String name, imageUrl,nameRec,imageUrlRec;
  StorageReference storageReference;
  String ownerId;
  String txt="I am interested in your product";
  bool one=false;


  final List<Msg> _messages = <Msg>[]; //list of messages
  AuthNotifier authNotifier;
  final TextEditingController _textController = new TextEditingController();

  bool _isWriting = false;

    
  _ChatBoxWidgetState(this.ownerId)
  {
    inituserData();
          }
            
              @override
              
              Widget build(BuildContext context) {
                authNotifier = Provider.of<AuthNotifier>(context);
            
            
                  void LoadUserDetails() async {
                print("*******************************************************");
                _sender = await getCurrentUser(authNotifier);
                DocumentSnapshot snapshot = await getProfile(_sender);
                print("SnapShot : ${snapshot.data.toString()}");
            
                setState(() {
                  print("setting state");
                  imageUrl = snapshot.data["imageUrl"];
                  name = snapshot.data["name"];
            
            
                  if(imageUrl!=null && imageUrl .length>5)
                  {
                    state=ProfilePicState.DB;
                  }
                });
                print("Image URL : $imageUrl Name : $name");
              }
            
             void Loadreceiverdetails()async{
                DocumentSnapshot snapshot = await getProfile(ownerId);
                print("SnapShot : ${snapshot.data.toString()}");
            
                setState(() {
                  print("setting state");
                  imageUrlRec = snapshot.data["imageUrl"];
                  nameRec = snapshot.data["name"];
            
            
                  if(imageUrlRec!=null && imageUrlRec .length>5)
                  {
                    state=ProfilePicState.DB;
                  }
                });
                print("Image URL : $imageUrl Name : $name");
             }
              LoadUserDetails();
              Loadreceiverdetails();
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
                          child: Text(nameRec!=null?nameRec:""),
                        ),
                      ],
                    ),
                    backgroundColor: sc_PrimaryColor,
                  ),
                  body:Column(
                    children: <Widget>[
                      new Flexible(
                        child: ListView.builder(itemBuilder: (_,int index)=>
                        _messages[index],
                        itemCount: _messages.length,
                        reverse: true,
                        padding: EdgeInsets.all(6.0),
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
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 6,
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
                                    prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 0),
                                      child: Icon(
                                        IconData(58430, fontFamily: 'MaterialIcons'),
                                      ),
                                    ),
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
                  ),
                );
              }
            
            //message dipose function
            
              void _submitMsg(String txt) {
                _textController.clear();
                setState(() {
                  _isWriting = false;
                });
                Msg msg= new Msg(
                  txt:txt,
                  imageUrl:imageUrl,
                  name:name,
                  animationController: AnimationController(vsync: this,
                  duration:new Duration(milliseconds: 800)),
                );
                if(one==false){
                setState(() {
                  _messages.insert(0, msg);
                  one=true;
                });
                msg.animationController.forward();
                }
            }
            
             @override 
            void dispose(){
              for (Msg msg in _messages){
                msg.animationController.dispose();
              }
              super.dispose();
            }

            }
    
    void inituserData() {
}



       class Msg extends StatelessWidget {
      Msg({this.txt,this.imageUrl,this.name,this.animationController});
      final String imageUrl;
      final String name; 
      final String txt;
      final AnimationController animationController;
    
      @override
      Widget build(BuildContext context) {
        return new SizeTransition(
          sizeFactor: new CurvedAnimation(
              parent: animationController, curve: Curves.bounceOut),
          axisAlignment: 0.0,
          //message container
          child: Flexible(
                   child: Column(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                     Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                          new Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child:  ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child:imageUrl!=null? Image.network(
                            // 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                            imageUrl,
                            height: 45,
                            width: 45,
                            fit: BoxFit.fill,
                          ):
                          CircleAvatar(
                            radius:28,
                            child:Text(defaultUserName[0]),
                          ),
                        ),),
                          new Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: new Container(
                                child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  name==null?defaultUserName:name,
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
                  ),
        );
      }
}
    