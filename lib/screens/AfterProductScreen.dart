import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/models/clothes.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import 'package:shopconn/notifier/noteNotifier.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/screens/AddProductScreen.dart';
import 'package:shopconn/screens/MyProdcuts.dart';
import 'package:shopconn/screens/ProductDetailScreen_Book.dart';
import 'package:shopconn/screens/ProductDetailScreen_Cloth.dart';


class AfterProductScreen extends StatefulWidget {
  String category;
  AfterProductScreen({Key key,@required this.category}):super(key:key);

  @override
  _AfterProductScreenState createState() => _AfterProductScreenState(category);
}

class _AfterProductScreenState extends State<AfterProductScreen> {
  AuthNotifier authNotifier;
  BookNotifier bookNotifier;
  Book currBook;
  String category;

  _AfterProductScreenState(String category);
  
  
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    ClothesNotifier clothNotifier = Provider.of<ClothesNotifier>(context);
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context);
    currBook = bookNotifier.currentBook;
    return Scaffold(
      appBar: AppBar(
         title: Text(
          "",
          style: TextStyle(
            color: sc_AppBarTextColor,
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:SingleChildScrollView( child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     Image.asset(
                         "assets/images/doneImage.png",
                        height: 200,
                        width: 200,
                     ),
                     SizedBox(height:15.0),
                           Text("Thank you !!!!!",
            style: TextStyle(
            color:  sc_PrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 40.0,
           ),
          ),
                     SizedBox(height:15.0),
                    Text("Your product has been posted successfully.",
                style: TextStyle(
                color: sc_ItemInfoColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
             ),
            ),
             SizedBox(height:15.0),
          // Text("Keep posting",
          //   style: TextStyle(
          //   color:  sc_PrimaryColor,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 40.0,
          //  ),
          // ),
          // SizedBox(height:15.0),
          // Text("Do you have anything else to post?",
          //   style: TextStyle(
          //   color: sc_ItemInfoColor,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 20.0,
          //  ),
          // ),
          // SizedBox(height:15.0),
          Row(
             mainAxisAlignment:MainAxisAlignment.spaceEvenly,
             children: <Widget>[
            RaisedButton(
              color: sc_PrimaryColor,
              padding: EdgeInsets.all(13.0),
              child: Text(
                'Post',
                style: TextStyle(
                  color: sc_AppBarTextColor,
                  fontSize: 18.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProuctScreen(),)
                );
              },
            ),
          SizedBox(height:15.0),
           RaisedButton(
              color: sc_PrimaryColor,
              padding: EdgeInsets.all(13.0),
              child: Text(
                'My Posts',
                style: TextStyle(
                  color: sc_AppBarTextColor,
                  fontSize: 18.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>MyProducts())
                );
              },
            ),
          ],), 
          // SizedBox(height:15.0),
                  ],
                ),
              ),
               color:sc_AppBarTextColor,
            ),
          ),
        ],
      ),
    )
    );
  }
}