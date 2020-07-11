import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/screens/SearchProductScreen.dart';
import 'package:shopconn/widgets/Item.dart';

class OnlyCategoryProductScreen extends StatelessWidget {
  String category;
  OnlyCategoryProductScreen({this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(color: sc_AppBarTextColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchProduct(category: category),
              );
            },
          ),
        ],
        backgroundColor: sc_AppBarBackgroundColor,
      ),
      body: Container(
        // padding: EdgeInsets.only(top: 10.0),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("post")
                .where('productCategory', isEqualTo: category)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("NO DATA***********************");
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ));
                // ));
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(5.0),
                  itemBuilder: (BuildContext context, index) {
                    return ProductItem(
                      data: snapshot.data.documents[index],
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                );
              }
            }),
      ),
    );
  }
}
