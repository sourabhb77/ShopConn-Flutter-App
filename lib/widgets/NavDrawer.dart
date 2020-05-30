import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopconn/screens/Profile.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.colorDodge, //Don't what this does?
              color: Colors.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Drawer header',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24.0,
                  ),
                ),
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage("https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10,0, 0),
                  child: Text("Doctor Daddy",
                    style: TextStyle(
                      letterSpacing: 3.0,

                    ),),
                ),
                Text("Doctor Daddy",
                  style: TextStyle(
                  letterSpacing: 5.0,
                  
                ),)
              ],
            ),
          ),
          InkWell(
            onTap: (){
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          );
            },
                      child: ListTile(
              title: Text("Profile"),
              leading: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text("Message"),
          ),
          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
