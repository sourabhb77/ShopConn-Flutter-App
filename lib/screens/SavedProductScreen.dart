import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/widgets/Item.dart';

class SavedProductScreen extends StatefulWidget {
  const SavedProductScreen({Key key}) : super(key: key);

  @override
  _SavedProductScreenState createState() => _SavedProductScreenState();
}

class _SavedProductScreenState extends State<SavedProductScreen> {
  ClothesList clothesData = ClothesList( 
  clotheItem: [
    Clothes(
      "Id1", 
      "Boiler Suit", 
      180,
      "this is very good item you can purchase here",
      ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
      "M"
    ),
    Clothes(
      "Id2", 
      "Boiler Suit", 
      280,
      "this is very good item you can purchase here",
      ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
      "L"
    ),
    Clothes(
      "Id3", 
      "Boiler Suit", 
      480,
      "this is very good item you can purchase here",
      ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
      "XL"
    ),
    Clothes(
      "Id4", 
      "Boiler Suit", 
      320,
      "this is very good item you can purchase here",
      ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
      "XXL"
    ),
    Clothes(
      "Id5", 
      "Boiler Suit", 
      400,
      "this is very good item you can purchase here",
      ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
      "M"
    ),
    
  ]
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Product",
          style: TextStyle(
            color: sc_AppBarTextColor
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: clothesData.clotheItem.map((cloth){
            return Item();
          }).toList(),
        )
      ),
    );
  }
}

