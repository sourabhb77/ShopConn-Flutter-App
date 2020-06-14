import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: sc_PrimaryColor,
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5.0,
              tabs: [
                Tab(text:"MESSAGES",),
                Tab(text:"NEW REQUEST"),
              ],
            ),
            leading: Icon(IconData(58135, 
            fontFamily: 'MaterialIcons', matchTextDirection: true), 
            color: Colors.white, size: 30.0, ),
            title: Text('Chat box', style: TextStyle(color: Colors.white), ),
            actions: < Widget > [
            IconButton(icon:  Icon(IconData(59574, 
            fontFamily: 'MaterialIcons'), 
            color: Colors.white, size: 30.0, ), onPressed: ()  {
            }, ),
            IconButton(icon: Icon(IconData(59576, 
            fontFamily: 'MaterialIcons'),
             color: Colors.white, size: 30.0, ), onPressed: ()  {
            }, ), ],
            elevation: 1.0,
          ),
          body: TabBarView(
            children: [
              ListView(
                children: < Widget > [
                  Card(
                    elevation:0.0,
                    child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                    Expanded(child: CircleAvatar(radius: 30.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: < Widget > [
                                Text('Doctor daddy', 
                                textAlign: TextAlign.center, 
                                style: new TextStyle(fontSize: 14.0,
                                 color: Colors.black)),
                                Text('I love flutter', 
                                textAlign: TextAlign.center, 
                                style: new TextStyle(fontSize: 14.0,
                                 color: Colors.grey[400])),
                              ], ), ),
                            SizedBox(width: 100.0),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: < Widget > [
                                Text('yesterday', 
                                textAlign: TextAlign.center,
                                 style: new TextStyle(fontSize: 14.0, 
                                 color: Colors.black)),
                                Text('12.00pm',
                                textAlign: TextAlign.center,
                                 style: new TextStyle(fontSize: 14.0, 
                                 color: Colors.grey[400])),
                              ], ), ),
                          ],
                        ),
                    ),
                  ), ),
                           Card(
                             elevation:0.0,
                             child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            Expanded(child: CircleAvatar(radius: 30.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: < Widget > [
                                Text('Doctor daddy', 
                                textAlign: TextAlign.center, 
                                style: new TextStyle(fontSize: 14.0, 
                                color: Colors.black)),
                                Text('I love flutter',
                                 textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 14.0, 
                                  color: Colors.grey[400])),
                              ], ), ),
                            SizedBox(width: 100.0),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: < Widget > [
                                Text('yesterday', textAlign: TextAlign.center, 
                                style: new TextStyle(fontSize: 14.0, 
                                color: Colors.black)),
                                Text('12.00pm', textAlign: TextAlign.center,
                                 style: new TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                              ], ), ),
                          ],
                        ),
                    ),
                  ), ),
                           Card(
                             elevation:0.0,
                             child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                             Expanded(child: CircleAvatar(radius: 30.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
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
                           Card(
                    elevation:0.0,
                    child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                             Expanded(child: CircleAvatar(radius: 30.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
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
                           Card(
                    elevation:0.0,
                    child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                             Expanded(child: CircleAvatar(radius: 30.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
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
                          Card(
                    elevation:0.0,
                    child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                             Expanded(child: CircleAvatar(radius: 30.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
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
                           Card(
                    elevation:0.0,
                    child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()), );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                             Expanded(child: CircleAvatar(radius: 30.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
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
                ],
              ),
              ListView(
                children: < Widget > [


                      Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                  Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
               Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                  Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                  Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                  Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                  Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                Card(
                     elevation:0.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: Row(
                          children: < Widget > [
                            // SizedBox(width: 5, ),
                               Expanded(flex:2,child: CircleAvatar(radius: 40.0,child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) ), ),
                            SizedBox(width: 10, ),
                            Expanded(flex:6, child: Text('Doctor daddy', textAlign: TextAlign.start, style: new TextStyle(fontSize: 15.0, color: Colors.black))),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(59510, fontFamily: 'MaterialIcons'), color: Colors.green, size: 30.0, ), onPressed: () {}, )),
                            Expanded(flex:2,child: IconButton(icon: new Icon(IconData(57676, fontFamily: 'MaterialIcons'), color: Colors.red, size: 30.0, ), onPressed: () {})),
                          ],
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}