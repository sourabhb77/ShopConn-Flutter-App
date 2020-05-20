import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: Scaffold(
    appBar:AppBar(
      leading: Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true),color:Colors.black,size:30.0,),
      title: Text('Chat box'),
      actions:<Widget>[Icon(IconData(59576, fontFamily: 'MaterialIcons'),color: Colors.black,size: 30.0,) ,
      ],
      backgroundColor: Colors.pink[200],
      ),
      body: (
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children:<Widget>[
            Expanded(child:TextFormField(decoration:const InputDecoration(prefixIcon:Padding(padding:const EdgeInsetsDirectional.only(start:12.0),child: Icon(IconData(59574, fontFamily: 'MaterialIcons'),),),hintText:'Search by Name',)),)],),
            SizedBox(height:20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[  
              Text('Message',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
              VerticalDivider(color:Colors.black),
              Text('New Requests',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),],
            ),
            SizedBox(height:20.0),
            Row(
              children: <Widget>[
                Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/Symbols.png'),),),),
                Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('Doctor daddy',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('I love flutter',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              SizedBox(width:100.0), 
              Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('yesterday',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('12.00pm',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              ],
            ),
            Divider(color: Colors.grey[400],),
            SizedBox(height:20.0),
            Row(
              children: <Widget>[
                Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/Symbols.png'),),),),
                Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('Doctor daddy',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('I love flutter',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              SizedBox(width:100.0), 
              Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('yesterday',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('12.00pm',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              ],
            ),
            Divider(color: Colors.grey[400],),
            SizedBox(height:20.0),
            Row(
              children: <Widget>[
                Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/Symbols.png'),),),),
                Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('Doctor daddy',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('I love flutter',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              SizedBox(width:100.0), 
              Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('yesterday',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('12.00pm',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              ],
            ),
            Divider(color: Colors.grey[400],),
            SizedBox(height:20.0),
            Row(
              children: <Widget>[
                Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/Symbols.png'),),),),
                Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('Doctor daddy',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('I love flutter',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              SizedBox(width:100.0), 
              Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('yesterday',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('12.00pm',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              ],
            ),
            Divider(color: Colors.grey[400],),
            SizedBox(height:20.0),
            Row(
              children: <Widget>[
                Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/Symbols.png'),),),),
                Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('Doctor daddy',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('I love flutter',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              SizedBox(width:100.0), 
              Expanded(child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      Text('yesterday',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.black)),
                                      Text('12.00pm',textAlign:TextAlign.center,style:new TextStyle(fontSize:14.0,color:Colors.grey[400])),
                                      ],),),
              ],
            ),
            Divider(color: Colors.grey[400],),
            SizedBox(height:20.0),
          ],
        )
      ),
    ),
));