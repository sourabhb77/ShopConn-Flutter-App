import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.white, 
    title:Text("SignUp",style:TextStyle(color:Colors.black)),
    leading: Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true),color:Colors.black,size:30.0,),
    elevation: 0.5,
    ),
    body:
    Container(
      decoration: BoxDecoration(
        gradient:LinearGradient(begin:Alignment.topCenter,
        end:Alignment.bottomCenter,
        colors:[Colors.white,Colors.white])
      ),
      child:Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
            SizedBox(height:20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("First Name:",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),)
              ),
         Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              color:Colors.blue[100],
               child:TextField(
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                  ),
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.blue[300], width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                ),
              ),
            ),
          SizedBox(height:10.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text("Last Name:",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),)
            ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              color:Colors.blue[100],
              child: TextField(
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                  ),
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.blue[300], width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                ),
              ),
            ),
            SizedBox(height:10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Email:",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),)
            ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              color:Colors.blue[100],
              child: TextField(
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                  ),
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.blue[300], width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                ),
              ),
            ),
            SizedBox(height:10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Password:",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),)
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              color:Colors.blue[100],
              child: TextField(
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                  ),
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.blue[300], width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color:  Colors.blue[300], width: 3.0),
                  ),
                ),
              ),
            ),
            SizedBox(height:30.0),
          new SizedBox(
  width: 100.0,
  height: 50.0,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Container(
      color: Colors.blue[300],
      // decoration: BoxDecoration(borderRadius:BorderRadius.circular(10)),
      child: new RaisedButton(
        child: new Text('SignUp',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.bold,color:Colors.white),),splashColor: Colors.blueAccent,),
      ),
    ),
  ),
SizedBox(height:10.0),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:<Widget>[Text('or',style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),),]),
SizedBox(height:10.0),
   new SizedBox(
  width: 100.0,
  height: 50.0,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Container(
      color: Colors.white,
      // decoration: BoxDecoration(borderRadius:BorderRadius.circular(10)),
      child: new RaisedButton(
        child: new Text('SignUp with Google',style: TextStyle(fontSize:20.0,color:Colors.black),),splashColor: Colors.blueAccent, 
      ),
    ),
  ),
),
SizedBox(height:20.0),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:<Widget>[Text("Already Have Account?",style: TextStyle(fontSize:15.0),),
  Text("SignIn here",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0,color: Colors.blue[300]),),]),
          ],
        ),
      ),
  )
  )
));