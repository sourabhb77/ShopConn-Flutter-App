import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/widgets/Item.dart';
import 'package:shopconn/api/shopconnApi.dart';

class MyPurchase extends StatefulWidget {
  @override
  MyPurchaseState createState() => MyPurchaseState();
}

class MyPurchaseState extends State<MyPurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sc_PrimaryColor,
        title: Text(
          "MyPurchase",
          style: TextStyle(color: sc_AppBarTextColor),
        ),
      ),
      body: FutureBuilder(
        future: getMyPurchase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error Occured!");
          if (!snapshot.hasData)
            return Center(
              child: Text("No Product Purchased"),
            );
          else {
            return ListView.builder(
                itemBuilder: (context, index) {
                  // return Text("data");
                  return ProductItem(
                    data: snapshot.data[index].data,
                  );
                },
                itemCount: snapshot.data.length);
          }
        },
      ),
    );
  }
}
