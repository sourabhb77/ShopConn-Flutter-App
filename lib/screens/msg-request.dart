import 'package:flutter/material.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/services/auth.dart';
import 'package:shopconn/const/Theme.dart';

class ChatBox extends StatefulWidget {
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
          backgroundColor:sc_AppBarBackgroundColor,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.chat,semanticLabel:'Messages',color: Colors.black,)),
                Tab(icon: Icon(Icons.filter_list,semanticLabel: 'New request',color: Colors.black,)),
              ],
            ),
           leading: Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true),color:sc_AppBarTextColor,size:30.0,),
      title: Text('Chat box',style:TextStyle(color:sc_AppBarTextColor),),
      actions:<Widget>[IconButton(icon:Icon(IconData(59576, fontFamily: 'MaterialIcons'),color: Colors.black,size: 30.0,), onPressed:()async{await _auth.signOut();},) ,
      ],
      elevation: 1.0,
          ),
          body: TabBarView(
            children: [
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children:<Widget>[
            Expanded(child:TextFormField(
              decoration:const InputDecoration(prefixIcon:Padding(padding:const EdgeInsetsDirectional.only(start:12.0),
              child: Icon(IconData(59574, fontFamily: 'MaterialIcons'),),),
              hintText:'Search by Name',
              // hintStyle:TextStyle(color:sc_InputHintTextColor,),
              )),)],),
            SizedBox(height:20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[  
              Text('Message',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_ItemTitleColor)),
              VerticalDivider(color:Colors.black),
              Text('New Requests',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_messageColor)),],
            ),
            SizedBox(height:20.0),
            Card(child:InkWell(
              splashColor:Colors.blue.withAlpha(30),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>ChatPage()),);
              } ,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0,8.0,0.0,8.0),
                child: Row(
                children: <Widget>[
                  Expanded(child:CircleAvatar(radius:30.0,backgroundColor:sc_imageBackgroundColor,child:Image(image:AssetImage('assets/images/Symbols.png'),),),),
                  Expanded(child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                        Text('Doctor daddy',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_ItemTitleColor)),
                                        Text('I love flutter',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_messageColor)),
                                        ],),),
                SizedBox(width:100.0), 
                Expanded(child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                        Text('yesterday',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_ItemTitleColor)),
                                        Text('12.00pm',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_messageColor)),
                                        ],),),
                ],
            ),
              ),
            ),
            ),
            SizedBox(height:20.0),
          ],
        ),
              Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children:<Widget>[
            Expanded(child:TextFormField(decoration:const InputDecoration(prefixIcon:Padding(padding:const EdgeInsetsDirectional.only(start:12.0),child: Icon(IconData(59574, fontFamily: 'MaterialIcons'),),),hintText:'Search',)),)],),
            SizedBox(height:20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[  
              Text('Message',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_messageColor)),
              VerticalDivider(color:Colors.black),
              Text('New Requests',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:sc_ItemTitleColor)),],
            ),
            SizedBox(height:10.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0,8.0,0.0,8.0),
                child: Row(
                children: <Widget>[
                  SizedBox(width: 5,),
                  Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/images/Symbols.png'),),),),
                  SizedBox(width: 5,),
                  Expanded(flex:5,child:Text('Doctor daddy',textAlign:TextAlign.start,style:new TextStyle(fontSize:15.0,color:sc_ItemTitleColor))),
                  Expanded(child:IconButton(icon:new Icon(IconData(59510, fontFamily: 'MaterialIcons'),color: Colors.green,size: 30.0,),onPressed:(){},)),
                  Expanded(child:IconButton(icon:new Icon(IconData(57676, fontFamily: 'MaterialIcons'),color:Colors.red,size: 30.0,),onPressed:(){})),
                ],
            ),
              ),
            ),
            SizedBox(height:10.0),

          ],
        ),
            ],
          ),
        ),
      ),
    );
  }
}