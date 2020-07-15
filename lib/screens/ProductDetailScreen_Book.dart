import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/widgets/chatBoxWidget.dart';
import '../widgets/Carousel.dart';

class ProductDetailScreen_Book extends StatefulWidget {
  const ProductDetailScreen_Book({Key key}) : super(key: key);

  @override
  _ProductDetailScreen_BookState createState() =>
      _ProductDetailScreen_BookState();
}

class _ProductDetailScreen_BookState extends State<ProductDetailScreen_Book> {
  String receiver = "XXXXX";
  String sender = "YYYYYYY";
  String ans = "answer";
  AuthNotifier authNotifier;
  BookNotifier bookNotifier;
  ChatNotifier chatNotifier;
  String ownerName = "";
  Book currBook;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
          print(value.displayName),
        });
    print("\n**************************\n");
    super.initState();
  }

  change() {
    setState(() {
      receiver = bookNotifier.currentBook.ownerId;
      sender = authNotifier.userId;
      ans = ans;
    });
  }

  @override
  Widget build(BuildContext context) {
    bookNotifier = Provider.of<BookNotifier>(context);
    chatNotifier = Provider.of<ChatNotifier>(context);
    authNotifier = Provider.of<AuthNotifier>(context);
    currBook = bookNotifier.currentBook;
    // void loadUserDetails() async {
    //   DocumentSnapshot snapshot = await getProfile(bookNotifier.currentBook.ownerId);
    //   setState(() {
    //     ownerName = snapshot.data["name"];
    //   });
    // }
    // loadUserDetails();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: sc_AppBarBackgroundColor,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.search),
            //   tooltip: 'Search',
            //   onPressed: () {},
            // ),
            IconButton(
              icon: Icon(Icons.bookmark),
              tooltip: 'Saved Product',
              onPressed: () {
                Future<bool> result =
                    addToBookmarks(bookNotifier.currentBook.id);
                result.then((value) =>
                    value == true ? Navigator.pop(context) : print("Error"));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: Text(
                  bookNotifier.currentBook.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: sc_ItemTitleColor,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              // Container(

              // ),
              Carousel(imgList: currBook.imgList),
              // SizedBox(
              //   height: 30.0,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Text(
                  'Rs ${bookNotifier.currentBook.price}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: sc_PrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                child: Row(
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
                          child: Image.asset('assets/images/CatBooks.png'),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Author\'s Name',
                          style: TextStyle(
                            color: sc_ItemTitleColor,
                            fontSize: 16.0,
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
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children:
                                bookNotifier.currentBook.authorList.map((name) {
                              return Text(
                                '$name',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: sc_ItemInfoColor,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Edition',
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
                          width: 70.0,
                          child: Center(
                            child: Text(
                              bookNotifier.currentBook.edition.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: sc_ItemInfoColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
                thickness: 10.0,
                color: Color(0xFFf4f6ff),
                // color: Color(0xFF282C3F),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book Category',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: sc_ItemTitleColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              bookNotifier.currentBook.bookCategory,
                              style: TextStyle(
                                color: sc_ItemTitleColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Condition',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: sc_ItemTitleColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              bookNotifier.currentBook.condition,
                              style: TextStyle(
                                color: sc_ItemTitleColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Branch',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      bookNotifier.currentBook.branch,
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Publication',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      bookNotifier.currentBook.publication,
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Subject',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      bookNotifier.currentBook.subject,
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      bookNotifier.currentBook.description,
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                height: 30.0,
                thickness: 10.0,
                color: sc_grey,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Owner',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      bookNotifier.currentBook.ownerId,
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
                thickness: 10.0,
                color: Color(0xFFf4f6ff),
                // color: Color(0xFF282C3F),
              ),
              SizedBox(
                height: 15.0,
              ),
               authNotifier.userId!=bookNotifier.currentBook.ownerId?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        receiver = bookNotifier.currentBook.ownerId;
                        sender = authNotifier.userId;
                        print(isPresent(
                            sender, receiver, chatNotifier, authNotifier));
                        ans = (await isPresent(
                                sender, receiver, chatNotifier, authNotifier))
                            .toString();
                        change();
                        if (ans == "null") {
                          // print(bookNotifier.currentBook.ownerId);
                          // print("Sending Chat Request NOW ****************");

                          // sendRequest();
                          // print("REQUEST SENT ************************");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatBoxWidget(
                                ownerId: bookNotifier.currentBook.ownerId,
                                productId: bookNotifier.currentBook.id,
                              ),
                            ),
                          );
                        } else if (ans != "null") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatPage()),
                          );
                        }
                      },
                      color: sc_PrimaryColor,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Chat now",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_AppBarTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlineButton(
                      color: sc_PrimaryColor,
                      child: Text(
                        'Add to WishList',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        Future<bool> result =
                            addToBookmarks(bookNotifier.currentBook.id);
                        result.then((value) => value == true
                            ? showSnackBar("Added to BookMarks")
                            : showSnackBar("Error Occured"));
                      },
                    ),
                  ],
                ),
              ):Container(),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }

  void showSnackBar(String string) {
    var snackBar = new SnackBar(
      content: new Text(
        string,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
      backgroundColor: Colors.teal,
      action: SnackBarAction(
        label: "Ok",
        textColor: Colors.white,
        onPressed: () {},
      ),
      elevation: 4.0,
    );
    if (_scaffoldKey.currentState != null)
      _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
