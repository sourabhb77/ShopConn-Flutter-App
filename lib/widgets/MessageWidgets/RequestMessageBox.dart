import 'package:flutter/material.dart';
import 'package:shopconn/models/Message.dart';

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
