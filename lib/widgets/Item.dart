import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/models/clothes.dart';
import 'package:shopconn/models/note.dart';
import 'package:shopconn/models/other.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import 'package:shopconn/notifier/noteNotifier.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import 'package:shopconn/screens/ProductDetailScreen_Book.dart';
import 'package:shopconn/screens/ProductDetailScreen_Cloth.dart';
import 'package:shopconn/screens/ProductDetailScreen_Note.dart';
import 'package:shopconn/screens/ProductDetailScreen_Other.dart';

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
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Text(
                              "hye how are you detaw wjhevw ew ja;dfjadkfa sdfa dfasdfa whewh jhbe sfkwej\nwefwglk",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: sc_ItemInfoColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0),
                              child: Text(
                                "Rs 300",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: sc_PrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )),
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

class DeleteableProductItem extends StatelessWidget {
  final dynamic data;
  DeleteableProductItem({this.data});

  @override
  Widget build(BuildContext context) {
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    ClothesNotifier clothNotifier = Provider.of<ClothesNotifier>(context);
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context);

    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete_forever),
        alignment: Alignment.bottomRight,
      ),
           key: Key(data["id"]),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteBookMark(data["id"]);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("item dismissed")));
        } else {
          return;
        }
      },
      child: Container(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(0.0),
              elevation: 0.0,
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {
                  switch (data["productCategory"]) {
                    case "Book":
                      Book book = Book.fromMap(data.data);
                      bookNotifier.currentBook = book;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen_Book()),
                      );
                      break;
                    case "Clothes":
                      Clothes cloth = Clothes.fromMap(data.data);
                      clothNotifier.currentClothes = cloth;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen_Cloth()),
                      );
                      break;
                    case "Note":
                      Note note = Note.fromMap(data.data);
                      noteNotifier.currentNote = note;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen_Note()),
                      );
                      break;
                    case "Other":
                      Other other = Other.fromMap(data.data);
                      otherNotifier.currentOther = other;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen_Other()),
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
                          data["imgList"] != null
                              ? data["imgList"][0]
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
                                data["name"] == null
                                    ? "NULL NAME"
                                    : data["name"],
                                style: TextStyle(
                                  color: sc_ItemTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                data["description"],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: sc_ItemInfoColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  data["price"] != null
                                      ? "Rs ${data["price"]}"
                                      : "NULL PRICE",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: sc_PrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 10.0,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final dynamic data;
  ProductItem({this.data});
  @override
  Widget build(BuildContext context) {
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    ClothesNotifier clothNotifier = Provider.of<ClothesNotifier>(context);
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context);
    return Container(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {
                switch (data["productCategory"]) {
                  case "Book":
                    Book book = Book.fromMap(data.data);
                    bookNotifier.currentBook = book;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen_Book()),
                    );
                    break;
                  case "Clothes":
                    Clothes cloth = Clothes.fromMap(data.data);
                    clothNotifier.currentClothes = cloth;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen_Cloth()),
                    );
                    break;
                  case "Note":
                    Note note = Note.fromMap(data.data);
                    noteNotifier.currentNote = note;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen_Note()),
                    );
                    break;
                  case "Other":
                    Other other = Other.fromMap(data.data);
                    otherNotifier.currentOther = other;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen_Other()),
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
                        data["imgList"] != null
                            ? data["imgList"][0]
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
                              data["name"] == null ? "NULL NAME" : data["name"],
                              style: TextStyle(
                                color: sc_ItemTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Text(
                              data["description"],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: sc_ItemInfoColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                data["price"] != null
                                    ? "Rs ${data["price"]}"
                                    : "NULL PRICE",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: sc_PrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 8.0,
            thickness: 3.0,
            color: sc_grey,
          )
        ],
      ),
    );
  }
}
