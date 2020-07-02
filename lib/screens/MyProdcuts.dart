import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/AddProductScreen.dart';
import 'package:shopconn/widgets/Item.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier _authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Products",
          style: TextStyle(color: sc_AppBarTextColor),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("post")
            .where("ownerId", isEqualTo: _authNotifier.userId).orderBy("postedAt",descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("error");

          if (!snapshot.hasData) return Text("Loading...");

          return ListView.builder(
              itemBuilder: (context, index) {
                // return Text("data");
                  return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: DeleteableProductItem(data: snapshot.data.documents[index],),
                            );
              },
              itemCount: snapshot.data.documents.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProuctScreen()),
            );
            print("go to add product screen");
          },
          child: Icon(Icons.add),
          backgroundColor: sc_PrimaryColor),
    );
  }
}
