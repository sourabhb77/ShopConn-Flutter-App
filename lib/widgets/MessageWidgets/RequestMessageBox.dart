import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/models/Message.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/api/MessageApi.dart';


class RequestBox extends StatelessWidget {
  final ChatUser user;
  RequestBox({this.user});

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
                child: Text(user.email,
                    textAlign: TextAlign.start,
                    style: new TextStyle(fontSize: 15.0, color: Colors.black))),
            Expanded(
                child: IconButton(
              icon: new Icon(
                IconData(59510, fontFamily: 'MaterialIcons'),
                color: Colors.green,
                size: 30.0,
              ),
              onPressed: () {
                print("Accepted");
                var t =makeRoom(user.userId);
                t.then((value) {
                  if(value== true)
                  {
                    print("Room created");
                  }
                  else
                    print("Room creation failed");
                });


                
                //Request is accepted

                //1. remove the request
                //2. Make a new room?
                // add the both the participants.
                // if follwoing nosql model then changes have to be made in both the document refernce
                // add the room model reference in active listeners ? so that all the new messages are forwarded here
                // basically we will be lisening to all the enteries in this room? 
                

                
                },
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

class Messagebox extends StatefulWidget {
   ChatMessage message;

   ChatUser user;

  Messagebox({this.message})
  {
      //1. Get user profile
      loadUser(this.user,message);
  }

  @override
  _MessageboxState createState() => _MessageboxState();
}

class _MessageboxState extends State<Messagebox> {

  @override
  Widget build(BuildContext context) {
    ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context, listen: false);

    return Card(
      elevation: 0.0,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {

          chatNotifier.setChatUser = widget.user.email != null ? widget.user.email : null;
          
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
                    Text(
                      widget.user != null ? widget.user.email : "Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, color: Colors.black)
                    ),
                    Text('I love flutter',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 14.0, color: Colors.grey[400])),
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
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.black)),
                    Text('12.00pm',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 14.0, color: Colors.grey[400])),
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
