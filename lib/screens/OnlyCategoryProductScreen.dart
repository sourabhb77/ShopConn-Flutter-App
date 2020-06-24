import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import 'package:shopconn/notifier/noteNotifier.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/screens/ProductDetailScreen_Book.dart';
import 'package:shopconn/screens/ProductDetailScreen_Cloth.dart';
import 'package:shopconn/screens/ProductDetailScreen_Note.dart';
import 'package:shopconn/screens/ProductDetailScreen_Other.dart';
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
          style: TextStyle(
            color: sc_AppBarTextColor
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: StreamBuilder(
          stream: Firestore.instance.collection("post")
                    .where('productCategory',isEqualTo: category)
                    .snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
            {
              print("NO DATA***********************");
              return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
              );
              // ));
            }
            else{
              return ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemBuilder: (BuildContext context, index) {
                  return ProductItem(data: snapshot.data.documents[index],);
                },
                itemCount: snapshot.data.documents.length,
              );
            }
          }
        ),
      ),
    );
  }



}