import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/widgets/CategorySelector.dart';
import 'package:shopconn/widgets/HomeSliver.dart';
import 'package:shopconn/widgets/NavDrawer.dart';
import 'package:shopconn/widgets/ProductDisplay.dart';

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

        //   flexibleSpace: FlexibleSpaceBar(
        //     title:Text("YOLO"),
        //     centerTitle: true,

        //   ),

        // ),
        drawer: NavDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            HomeSliver(),

            
            SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child:CategorySelector(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("NEWLY ADDED",
                      textAlign: TextAlign.start,),
                      Text("SEE MORE",
                      textAlign: TextAlign.end,)
                    ],
                  ),
                ),
                
              ],
            )),

           
            SliverFixedExtentList(
              itemExtent: 100,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ProductDisplay(),
                  );
                }
              ),)
          ],
        ));
  }
}
