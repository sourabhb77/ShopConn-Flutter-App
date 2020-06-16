import 'package:flutter/material.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/screens/chatbox.dart';

class RequestBox extends StatelessWidget {
  final String name;
  RequestBox({this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.grey[400],
                child: Image(
                  image: AssetImage('assets/images/Symbols.png'),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 5,
                child: Text(name,
                    textAlign: TextAlign.start,
                    style: new TextStyle(fontSize: 15.0, color: Colors.black))),
            Expanded(
                child: IconButton(
              icon: new Icon(
                IconData(59510, fontFamily: 'MaterialIcons'),
                color: Colors.green,
                size: 30.0,
              ),
              onPressed: () {},
            )),
            Expanded(
                child: IconButton(
                    icon: new Icon(
                      IconData(57676, fontFamily: 'MaterialIcons'),
                      color: Colors.red,
                      size: 30.0,
                    ),
                    onPressed: () {})),
          ],
        ),
      ),
    );
  }
}

class Messagebox extends StatelessWidget {

  final String email;

  Messagebox({this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
                  elevation: 0.0,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CircleAvatar(
                                radius: 30.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: Image.network(
                                    'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(email,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: 14.0, color: Colors.black)),
                                Text('I love flutter',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[400])),
                              ],
                            ),
                          ),
                          SizedBox(width: 100.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('yesterday',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: 14.0, color: Colors.black)),
                                Text('12.00pm',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[400])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                
  }
}
