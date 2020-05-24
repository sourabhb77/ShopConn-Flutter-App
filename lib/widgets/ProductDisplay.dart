import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductDisplay extends StatefulWidget {
  _ProductDisplay createState() => _ProductDisplay();
}

class _ProductDisplay extends State<ProductDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(image: AssetImage("assets/images/CatNotes.png")),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Wrap(direction: Axis.vertical, children: <Widget>[
                  Text("Item Category",

                  style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold),),
                  Text(
                    "Lorem Ipsum is simply dummy text of the ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  )
                ]),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
