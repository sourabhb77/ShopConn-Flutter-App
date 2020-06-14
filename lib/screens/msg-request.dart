import 'package:flutter/material.dart';
import './chatbox.dart';
import '../services/auth.dart';

class ChatBox extends StatefulWidget {
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State < ChatBox > {
  // final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.chat, semanticLabel: 'Messages', color: Colors.black, )),
                Tab(icon: Icon(Icons.filter_list, semanticLabel: 'New request', color: Colors.black, )),
              ],
            ),
            leading: Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true), color: Colors.black, size: 30.0, ),
            title: Text('Chat box', style: TextStyle(color: Colors.black), ),
            actions: < Widget > [IconButton(icon: Icon(IconData(59576, fontFamily: 'MaterialIcons'), color: Colors.black, size: 30.0, ), onPressed: () {
              // await _auth.signOut();
            }, ), ],
            backgroundColor: Colors.blue[300],
            elevation: 1.0,
          ),
          body: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: < Widget > [
                  Row(
                    children: < Widget > [
                      Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Padding(padding: const EdgeInsetsDirectional.only(start: 12.0), child: Icon(IconData(59574, fontFamily: 'MaterialIcons'), ), ), hintText: 'Search by Name', )), )
                    ], ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: < Widget > [
                      Text('Message', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.black)),
                      VerticalDivider(color: Colors.black),
                      Text('New Requests', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Card(child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            Expanded(child: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[400], child: Image(image: AssetImage('assets/Symbols.png'), ), ), ),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: < Widget > [
                                Text('Doctor daddy', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.black)),
                                Text('I love flutter', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                              ], ), ),
                            SizedBox(width: 100.0),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: < Widget > [
                                Text('yesterday', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.black)),
                                Text('12.00pm', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                              ], ), ),
                          ],
                        ),
                    ),
                  ), ),
                  SizedBox(height: 20.0),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: < Widget > [
                  Row(
                    children: < Widget > [
                      Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Padding(padding: const EdgeInsetsDirectional.only(start: 12.0), child: Icon(IconData(59574, fontFamily: 'MaterialIcons'), ), ), hintText: 'Search', )), )
                    ], ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: < Widget > [
                      Text('Message', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      VerticalDivider(color: Colors.black),
                      Text('New Requests', textAlign: TextAlign.center, style: new TextStyle(fontSize: 14.0, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            SizedBox(width: 5, ),
                            Expanded(child: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[400], child: Image(image: AssetImage('assets/Symbols.png'), ), ), ),
                            SizedBox(width: 5, ),
                            Expanded(flex: 5, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                  SizedBox(height: 10.0),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}