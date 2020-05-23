import 'package:flutter/material.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.white, 
    title:Text("Login",style:TextStyle(color:Colors.black)),
    leading: Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true),color:Colors.black,size:30.0,),
    elevation: 0.5,
    ),
    body:
    Container(
      decoration: BoxDecoration(
        gradient:LinearGradient(begin:Alignment.topCenter,
        end:Alignment.bottomCenter,
        colors:[Colors.white,Colors.white],)
      ),
      child:Padding(
        padding: const EdgeInsets.fromLTRB(10.0,0.0, 20.0,5.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              color:Colors.blue[100],
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color:Colors.black,
                  ),
                  hintText: "Email Id",
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
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              color:Colors.blue[100],
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color:Colors.black,
                  ),
                  hintText: "Password",
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
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:<Widget>[Text('Forgot Password?',style: TextStyle(color:Colors.blue[300],fontWeight:FontWeight.bold,fontSize:15.0,),),]),
            SizedBox(height:20.0),
          new SizedBox(
  width: 100.0,
  height: 50.0,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Container(
      color: Colors.blue[300],
      // decoration: BoxDecoration(borderRadius:BorderRadius.circular(10)),
      child: new RaisedButton(
        child: new Text('Login',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.bold,color:Colors.white),),splashColor: Colors.blueAccent,onPressed: (){},),
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
        child: new Text('Log In with Google',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.bold,color:Colors.black),),splashColor: Colors.blueAccent,onPressed: (){}, 
      ),
    ),
  ),
),
SizedBox(height:20.0),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:<Widget>[Text("Don't Have Account?",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),),
  Text("Register here",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0,color: Colors.blue[300]),),]),
          ],
        ),
      ),
  )
  )
    );
  }
}
