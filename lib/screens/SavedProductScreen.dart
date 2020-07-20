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

class SavedProductScreen extends StatefulWidget {
  const SavedProductScreen({Key key}) : super(key: key);

  @override
  _SavedProductScreenState createState() => _SavedProductScreenState();
}

class _SavedProductScreenState extends State<SavedProductScreen> {
  @override
  void initState() { 
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    ClothesNotifier clothNotifier = Provider.of<ClothesNotifier>(context);
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context);
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
        padding: EdgeInsets.only(top: 10.0),
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
                          switch (productNotifier.productList[index].productCategory) {
                            case "Book":
                              bookNotifier.currentBook=productNotifier.productList[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductDetailScreen_Book()),
                              );
                              break;
                            case "Clothes":
                              clothNotifier.currentClothes=productNotifier.productList[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductDetailScreen_Cloth()),
                              );
                              break;
                            case "Note":
                              noteNotifier.currentNote=productNotifier.productList[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductDetailScreen_Note()),
                              );
                              break;
                            case "Other":
                              otherNotifier.currentOther=productNotifier.productList[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductDetailScreen_Other()),
                              );
                              break;
                            default:
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
                                  productNotifier.productList[index].imgList[0] != null
                                    ? productNotifier.productList[index].imgList[0]
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
                                      productNotifier.productList[index]._name,
                                      style: TextStyle(
                                        color: sc_ItemTitleColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0 ,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    Text(
                                      productNotifier.productList[index].description,
                                      style: TextStyle(
                                        fontSize: 16.0 ,
                                        color: sc_ItemInfoColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Rs ${productNotifier.productList[index].price}",
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
            itemCount: productNotifier.productList.length,
            // itemCount: 1,
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

