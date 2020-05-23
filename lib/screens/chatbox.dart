import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(
      leading:Row(children:<Widget>[
      Expanded(child:IconButton(icon:new Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true),color:Colors.black,size:50.0,), onPressed:(){Navigator.pop(context);},)),
      Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/Symbols.png'),),),),]),
      title: Text('Doctor Daddy'),
      backgroundColor: Colors.blue[300],
      ),
      body: (
        Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: <Widget>[
            Container( 
                color:Colors.blue[300],
                padding:EdgeInsets.all(10),
                child:Row(
               children: <Widget>[
                 Expanded(flex:17,child:TextFormField(decoration:const InputDecoration(fillColor:Colors.white,prefixIcon:Padding(padding:const EdgeInsetsDirectional.only(start:12.0),child:Icon(IconData(58430, fontFamily: 'MaterialIcons')),),hintText:'Messages',)),),
                 Expanded(child:Icon(IconData(57699, fontFamily: 'MaterialIcons', matchTextDirection: true)))
           ],
            ),),
           ],
        )
    ),
);
  }
}
// void main()=>runApp(MaterialApp(
//   home: ));