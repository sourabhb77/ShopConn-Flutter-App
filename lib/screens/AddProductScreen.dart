import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopconn/screens/SavedProductScreen.dart';
import 'package:shopconn/widgets/CategorySelector.dart';


class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              // Text("sdkjvlkj"),
              CategorySelector(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0,top: 15.0),
                child: TextField(
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Book Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextField(
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Author Name',
                  ),
                ),
              ),
              TextField(
                // obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edition',
                ),
              ),
              TextField(
                // obscureText: true,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              TextField(
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',

                ),
              ),
              RaisedButton(
                child: Text('Open route'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SavedProductScreen()),
                  );
                },
              ),
            ]
            // children: 
          ),
        ),
      )
    );
  }
}