import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: sc_AppBarBackgroundColor,
        automaticallyImplyLeading: true,
     
      ),
      body: Column(
        
        children: <Widget>[
              Container(
                
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                
                child: CircleAvatar(
                    radius: 80.0,                    
                    backgroundColor: Colors.teal,
                    child: CircleAvatar(
                      radius: 78.0,
                    backgroundImage: NetworkImage("https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"),
                    ),
                  ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text("Doctor Daddy",
                      style: TextStyle(
                        
                        fontSize: 20.0,
                      ),),
                    ),
                    Container(
                      child: IconButton(icon: Icon(Icons.perm_phone_msg),
                      onPressed: ()=>{},),)
                ]
                ,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                Container(
                  child:Text("Mail")
                ),

                Padding(
                  padding: const EdgeInsets.only(left:15,right:15),
                  child: TextField(
                  maxLength: 20,
                  maxLines: 1,                
                  toolbarOptions: ToolbarOptions(
                    paste: true,
                    selectAll: false,
                  ),
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',                    
                    prefixIcon: Icon(Icons.person),
                    
                      
                  ),
                  textCapitalization: TextCapitalization.words,
                  autocorrect: false,
                  
                  
                  // cursorRadius: Radius.circular(100),
              ),),
              Padding(
                padding: const EdgeInsets.only(left:15,right:15),
                child: TextField(
                  maxLength: 20,
                  maxLines: 1,                
                  toolbarOptions: ToolbarOptions(
                    paste: true,
                    selectAll: false,
                  ),
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',                    
                    prefixIcon: Icon(Icons.person),
                    
                      
                  ),
                  textCapitalization: TextCapitalization.words,
                  autocorrect: false,
                  
                  
                  // cursorRadius: Radius.circular(100),
              
                   
                ),
              ),
              Padding(
              padding: const EdgeInsets.only(left:15,right:15),
              child:TextField(
                  maxLength: 20,
                  maxLines: 1,                
                  toolbarOptions: ToolbarOptions(
                    paste: true,
                    selectAll: false,
                  ),
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',                    
                    prefixIcon: Icon(Icons.person),
                    
                      
                  ),
                  textCapitalization: TextCapitalization.words,
                  autocorrect: false,
                  
                  
                  // cursorRadius: Radius.circular(100),
              ),
              ),
              RichText(
              text: TextSpan(
              text: 'Hello ',
              // style: DefaultTextStyle.of(context).style,
              // children: <TextSpan>[
              //   TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
              //   TextSpan(text: ' world!'),
              //   ],
              ),
            )
              ],),
              Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              color:  Color(0xFF35C5CF),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.print,
                    color: Color(0xFF000000),
                  ),
                  hintText: "Product Name",
                  hintStyle: TextStyle(
                    color: sc_PrimaryColor,
                    fontSize: 16.0,
                  ),
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: sc_ItemInfoColor, width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                ),
              ),
            ),

            ],),


      floatingActionButton: FloatingActionButton(
        child: Text("click"),
        elevation: 4,
        hoverColor: Colors.green,
        splashColor: Colors.green,
        onPressed: (){},
        backgroundColor: Colors.pink,

      ),
    );
  }
}