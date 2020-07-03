import 'package:flutter/material.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import '../widgets/Carousel.dart';

class ProductDetailScreen_Cloth extends StatefulWidget {
  const ProductDetailScreen_Cloth({Key key}) : super(key: key);

  @override
  _ProductDetailScreen_ClothState createState() =>
      _ProductDetailScreen_ClothState();
}

class _ProductDetailScreen_ClothState extends State<ProductDetailScreen_Cloth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: sc_AppBarBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.bookmark),
              tooltip: 'Saved Product',
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Boiler Suit',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: sc_ItemTitleColor,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Container(

                // ),
                Carousel(),
                // SizedBox(
                //   height: 30.0,
                // ),
                Text(
                  'Rs 400',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: sc_PrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: new BoxDecoration(
                            color: sc_skyblue,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          height: 70.0,
                          width: 70.0,
                          child: Image.asset('assets/images/CatClothes.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            decoration: new BoxDecoration(
                              color: sc_skyblue,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            // color: sc_skyblue,
                            height: 70.0,
                            // width: 70.0,
                            child: Center(
                              child: Text(
                                '6',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: sc_ItemInfoColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: sc_ItemTitleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      color: sc_grey,
                      child: Text(
                        'wejfwgejf wwfgwe wehfw wfgf\nfewgw wefhefgwe hjg\nwsc sdhc sdc kas mhwewebwj scvsc akh',
                        style: TextStyle(
                          color: sc_ItemTitleColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Owner',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: sc_ItemTitleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      color: sc_grey,
                      child: Text(
                        'Dr. Daddy',
                        style: TextStyle(
                          color: sc_ItemTitleColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RaisedButton(
                        color: sc_PrimaryColor,
                        child: Text(
                          'Chat Now',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () {
                          print("On Pressed Chat Now");

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>AddProuctScreen_Book()),
                          // );
                        },
                      ),
                      RaisedButton(
                        color: sc_PrimaryColor,
                        child: Text(
                          'Add to WishList',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () {
                           print("adding book mark");
                          // Future<bool> result =
                          //     addToBookmarks(notifier.currentBook.id);
                          // result.then((value) => print("Result: $value"));
                          
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>AddProuctScreen_Book()),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
