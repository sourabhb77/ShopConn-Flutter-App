import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';

const defaultUserName = "Doctor Daddy";

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);
  @override
  State createState() => Chat();
}


class Chat extends State<ChatPage> with TickerProviderStateMixin{
  ChatUser _user = ChatUser();

  final List<Msg> _messages=<Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting =false;
    @override
  Widget build(BuildContext context) {

    ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context);
    setState(() {

      _user = chatNotifier.currentUser;
      print("User: $_user");
    });


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
                      // 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      _user.imageUrl != null ? _user.imageUrl: 'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      height: 45,
                      width: 45,
                      fit: BoxFit.fill,
                    ),
                  )

                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  _user.displayName != null ? _user.displayName : ""
                ),
              ),
            ],

          ),
        backgroundColor: sc_PrimaryColor,
      ),
      body: (
        Column(
          children: < Widget > [
            new Flexible(child: 
            new ListView.builder(itemBuilder: (_,int index)=>_messages[index],
            itemCount:_messages.length,
            reverse:true,
            padding:new EdgeInsets.all(6.0))),
            Divider(height: 1.0,),        
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: sc_InputBackgroundColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: < Widget > [
                  SizedBox(width: 10.0,),
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: _textController,
                      onChanged: (String txt){
                        setState(() {
                          _isWriting=txt.length>0;
                        });
                      },
                      onSubmitted: _submitMsg,
                      decoration: InputDecoration(
                        fillColor: sc_InputBackgroundColor,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 0),
                            child: Icon(
                              IconData(
                                58430,
                                fontFamily: 'MaterialIcons'
                              ),
                            ),
                        ),
                        hintText: 'type here ..',
                        border: InputBorder.none,
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:IconButton(
                            icon: Icon(IconData(
                        57699,
                        fontFamily: 'MaterialIcons',
                        matchTextDirection: true
                      )),
                            onPressed: _isWriting?()=>_submitMsg(_textController.text):
                            null,
                          ),
                  ),
                ],
              ), 
            ),
            SizedBox(height: 3.0,),
          ],
        )
      ),
    );
  }

//message dipose function

  void _submitMsg(String txt){
  _textController.clear();
  setState((){
    _isWriting=false;
  });
  Msg msg = new Msg(
    txt:txt,
    animationController: new AnimationController(
      vsync:this,
      duration: new Duration(milliseconds: 800)
      ),
      );
      setState(() {
        _messages.insert(0,msg);
      });
      msg.animationController.forward();
    
    @override
    void dispose(){
      for (Msg msg in _messages){
        msg.animationController.dispose();
      }
      super.dispose();
    }

}

}

class Msg extends StatelessWidget{
    Msg({this.txt,this.animationController});
    final String txt;
    final AnimationController animationController;

    @override
    Widget build(BuildContext context){
      return new SizeTransition(sizeFactor: new CurvedAnimation(
        parent: animationController,
         curve: Curves.bounceOut
         ),
         axisAlignment: 0.0,
         //message container
         child:new Container(
           margin: const EdgeInsets.symmetric(vertical:8.0),
           child:new Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               new Container(
                 margin:EdgeInsets.only(right:10.0),
                 child: new CircleAvatar(child:new Text(defaultUserName[0])),//can add image here
               ),
               new Expanded(child:Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 10,0),
                 child: new Container(
                  child: new Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   new Text(defaultUserName,
                   style:new TextStyle(fontWeight:FontWeight.w600,
                  ),),
                   new Container(
                     margin: const EdgeInsets.only(top:6.0),
                     child:new Text(txt,
                      style:new TextStyle(fontWeight:FontWeight.w300,)
                   ),)
                 ],)),
               ))
             ],
           ),
         ),
      );
    }
}