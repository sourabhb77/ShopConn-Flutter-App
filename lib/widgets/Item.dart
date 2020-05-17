import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';


class Item extends StatefulWidget {
  Item({Key key}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      color: Colors.blueGrey,
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Boiler Suit",
                            style: TextStyle(
                              color: sc_ItemTitleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0 ,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            "hye how are you detaw wjhevw ew\nwhewh jhbe sfkwej\nwefwglk",
                            style: TextStyle(
                              fontSize: 16.0 ,
                              color: sc_ItemInfoColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                            child: Text(
                              "Rs 300",
                              style: TextStyle(
                                fontSize: 20.0 ,
                                color: sc_PrimaryColor,                                
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 5,
            thickness: 1,
            indent: 115,
            endIndent: 0,
          ),
        ],
      ),
    );
  }
}