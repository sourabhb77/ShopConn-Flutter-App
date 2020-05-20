
import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/widgets/CategorySelector.dart';
import 'package:shopconn/widgets/NavDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        // appBar: AppBar(
        //   elevation: 0,
        //   title: Text("Home"),
        //   centerTitle: true,
        // ),
        drawer: NavDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                expandedHeight: 150.0,
                title: Text("SHOPCONN"),
                
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Available seats'),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    tooltip: 'Add new entry',
                    onPressed: () {/* ... */},
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark),
                    tooltip: 'My Bookmarks',
                    onPressed: ()=>{},)
                ],
                ),
                SliverFillRemaining(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: CategorySelector(),
                      )
                  ],)),

                // Column(
                //   children: <Widget>[
                //     CategorySelector()
                //   ],
                // )
                    // SliverFixedExtentList(
      // itemExtent: 50.0,
      // delegate: SliverChildBuilderDelegate(
      //   (BuildContext context, int index) {
      //     return Container(
      //       alignment: Alignment.center,
      //       color: Colors.lightBlue[100 * (index % 9)],
      //       child: Text('List Item $index'),
      //     );
      //   },
      // ),
    // ),
 
          ],
          
          
        ));
  }
}
