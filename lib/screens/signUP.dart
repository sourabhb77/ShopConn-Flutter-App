import 'package:flutter/material.dart';
import 'package:shopconn/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
 SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth=AuthService();
  final _formkey = GlobalKey<FormState>();
  String firstname='';
  String lastname='';
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.white, 
    title:Text("SignUp",style:TextStyle(color:Colors.black)),
    leading: Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true),color:Colors.black,size:30.0,),
    elevation: 0.5,
    ),
    body:SingleChildScrollView(
      child:
      Form(
        key:_formkey,
        child:
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
              color: Color(0xFFEBF7FA),
               child:TextFormField(
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
                validator:(val)=> val.isEmpty?"Enter an first name":null,
                onChanged: (val){
                  setState(()=>firstname=val);
                },
              ),
            ),
          SizedBox(height:10.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text("Last Name:",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),)
            ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              color: Color(0xFFEBF7FA),
              child: TextFormField(
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
                validator:(val)=> val.isEmpty?"Enter an last name":null,
                 onChanged: (val){
                  setState(()=>lastname=val);
                },
              ),
            ),
            SizedBox(height:10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Email:",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),)
            ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              color: Color(0xFFEBF7FA),
              child: TextFormField(
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
                validator:(val)=> val.isEmpty?"Enter an email":null,
                 onChanged: (val){
                  setState(()=>email=val);
                },
              ),
            ),
            SizedBox(height:10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Password:",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0),)
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              color: Color(0xFFEBF7FA),
              child: TextFormField(
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
                obscureText: true,
                validator:(val)=> val.length<8?"Enter an password 8 character long":null,
                 onChanged: (val){
                  setState(()=>password=val);
                },
              ),
            ),
            SizedBox(height:12.0),
            Text(
              error,
              style:TextStyle(color: Colors.red,fontSize: 14.0),
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
        child: new Text('SignUp',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.bold,color:Colors.white),),splashColor: Colors.blueAccent,onPressed: ()async{
         if(_formkey.currentState.validate()){
           dynamic  result= await _auth.registerwithEmailAndPassword(email, password);
           if(result==null)
           {
             setState(() {
               error ='Please enter valid details.';
             });
           }
         }
        },),
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
        child: new Text('SignUp with Google',style: TextStyle(fontSize:20.0,color:Colors.black),),splashColor: Colors.blueAccent,onPressed: (){},
      ),
    ),
  ),
),
SizedBox(height:20.0),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:<Widget>[Text("Already Have Account?",style: TextStyle(fontSize:15.0),),
    FlatButton(onPressed: (){
      widget.toggleView();
    },padding:EdgeInsets.all(0.0), child:Text("SignIn here",style: TextStyle(fontWeight:FontWeight.bold,fontSize:15.0,color: Colors.blue[300]),))
  ]),
          ],
        ),
      ),
  )
  )));
  }
}
