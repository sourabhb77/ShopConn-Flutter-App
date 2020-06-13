import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/screens/ProductDetailScreen_Book.dart';

class SavedProductScreen extends StatefulWidget {
  const SavedProductScreen({Key key}) : super(key: key);

  @override
  _SavedProductScreenState createState() => _SavedProductScreenState();
}

class _SavedProductScreenState extends State<SavedProductScreen> {
  @override
  void initState() { 
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context, listen: false);
    getBooks(bookNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Product",
          style: TextStyle(
            color: sc_AppBarTextColor
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(0.0),
                      elevation: 0.0,
                      child: InkWell(
                        splashColor: Colors.red,
                        onTap: () {
                          bookNotifier.currentBook=bookNotifier.bookList[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductDetailScreen_Book()),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                                color: Colors.blueGrey,
                                child: Image.network(
                                  bookNotifier.bookList[index].imgList[0] != null
                                    ? bookNotifier.bookList[index].imgList[0]
                                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
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
                                      bookNotifier.bookList[index].name,
                                      style: TextStyle(
                                        color: sc_ItemTitleColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0 ,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    Text(
                                      bookNotifier.bookList[index].description,
                                      style: TextStyle(
                                        fontSize: 16.0 ,
                                        color: sc_ItemInfoColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Rs ${bookNotifier.bookList[index].price}",
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
            },
            itemCount: bookNotifier.bookList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 10.0,
                color: Colors.white,
              );
            },
          ),
      ),
    );
  }
}

