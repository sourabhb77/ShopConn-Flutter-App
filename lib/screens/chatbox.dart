import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State < ChatPage > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading:Row(children:<Widget>[
        // Expanded(child:IconButton(icon:new Icon(IconData(58135, fontFamily: 'MaterialIcons', matchTextDirection: true),color:Colors.black,size:50.0,), onPressed:(){Navigator.pop(context);},)),
        // Expanded(child:CircleAvatar(radius:30.0,backgroundColor:Colors.grey[400],child:Image(image:AssetImage('assets/Symbols.png'),),),),]),
        // title: Text('Doctor Daddy'),
        title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              InkWell(
                  onTap: () {
                    print ('Profile');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      'https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg',
                      height: 45,
                      width: 45,
                      fit: BoxFit.fill,
                    ),
                  )

                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Doctor Daddy')
              ),
            ],

          ),
        backgroundColor: sc_PrimaryColor,
      ),
      body: (
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: < Widget > [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.white,
                color: sc_InputBackgroundColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: < Widget > [
                  SizedBox(width: 10.0,),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      decoration: InputDecoration(

                        fillColor: sc_InputBackgroundColor,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 0),
                            child: Icon(
                              IconData(
                                58430,
                                fontFamily: 'MaterialIcons'
                              ),
                            ),
                        ),
                        hintText: 'type here ..',
                        border: InputBorder.none,
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      IconData(
                        57699,
                        fontFamily: 'MaterialIcons',
                        matchTextDirection: true
                      )
                    )
                  )
                ],
              ), 
            ),
            SizedBox(height: 3.0,),
          ],
        )
      ),
    );
  }
}
// void main()=>runApp(MaterialApp(
//   home: ))