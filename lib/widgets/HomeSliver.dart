import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/screens/Profile.dart';

class HomeSliver extends StatefulWidget {
  @override
  _HomeSliver createState() => _HomeSliver();
}

class _HomeSliver extends State<HomeSliver> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180.0,
      title: Text("SHOPCONN"),
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 80, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                        TextSpan(text: "Find Your\n"),
                        TextSpan(
                            text: "Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                        TextSpan(text: " Here"),
                      ]))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                cursorColor:Colors.green,
                
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  
                  hintText: "Subject Name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  
                ),
                
              ),
            ),
          ],
        ),
        collapseMode: CollapseMode.parallax,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_circle),
          tooltip: 'Add new entry',
          onPressed: () {/* ... */
               Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Profile()),
                      );
          },
        ),
        IconButton(
          icon: Icon(Icons.bookmark),
          tooltip: 'My Bookmarks',
          onPressed: () => {},
        )
      ],
    );

  }
}
