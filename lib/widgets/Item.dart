import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/screens/ProductDetailScreen_Book.dart';


class Item extends StatefulWidget {
  Item({Key key}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      color: Colors.blueGrey,
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Boiler Suit",
                            style: TextStyle(
                              color: sc_ItemTitleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0 ,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            "hye how are you detaw wjhevw ew ja;dfjadkfa sdfa dfasdfa whewh jhbe sfkwej\nwefwglk",
                            style: TextStyle(
                              fontSize: 16.0 ,
                              color: sc_ItemInfoColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                            child: Text(
                              "Rs 300",
                              style: TextStyle(
                                fontSize: 20.0 ,
                                color: sc_PrimaryColor,                                
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}


class ProductItem extends StatelessWidget {
  dynamic data;
  ProductItem({this.data});
  @override
  Widget build(BuildContext context) {
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    return Container(
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(0.0),
                      elevation: 0.0,
                      child: InkWell(
                        splashColor: Colors.red,
                        onTap: () {
                          if(data["productCategory"]== "Book"){
                            bookNotifier.currentBook=Book.fromMap(data.data);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductDetailScreen_Book()),
                            );
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                                color: Colors.blueGrey,
                                child: Image.network(
                                  data["imgList"] != null
                                    ? data["imgList"][0]
                                     :'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                  // width: 120,
                                  // fit: BoxFit.fitWidth,
                                  height: 130,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                     data["name"]== null ? "NULL NAME" : data["name"],
                                      style: TextStyle(
                                        color: sc_ItemTitleColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0 ,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    Text(
                                      data["description"],
                                      style: TextStyle(
                                        fontSize: 16.0 ,
                                        color: sc_ItemInfoColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        data["price"] != null  ? 
                                        "Rs ${data["price"]}" : "NULL PRICE",
                                        style: TextStyle(
                                          fontSize: 20.0 ,
                                          color: sc_PrimaryColor,                                
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              );
  }
}