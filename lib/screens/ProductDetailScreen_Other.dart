import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/other.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import 'package:shopconn/screens/Bookmarks.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/widgets/Carousel.dart';
import 'package:shopconn/widgets/chatBoxWidget.dart';
// import 'package:shopconn/widgets/Carousel.dart';

class ProductDetailScreen_Other extends StatefulWidget {
  const ProductDetailScreen_Other({Key key}) : super(key: key);

  @override
  _ProductDetailScreen_OtherState createState() =>
      _ProductDetailScreen_OtherState();
}

class _ProductDetailScreen_OtherState extends State<ProductDetailScreen_Other> {
  List imgList = [];
  // List<T> map<T>(List list, Function handler) {
  //   List<T> result = [];
  //   for (var i = 0; i < list.length; i++) {
  //     result.add(handler(i, list[i]));
  //   }
  //   return result;
  // }
  bool isBookmarked = false;

  @override
  void didChangeDependencies() {
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    isBookmarkedProduct(otherNotifier.currentOther.id, authNotifier.userId)
        .then((res) {
      setState(() {
        isBookmarked = res;
      });
    });
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context);
    imgList = otherNotifier.currentOther.imgList;
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookMarks()),
                );
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
                  otherNotifier.currentOther.name,
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
              Carousel(imgList: otherNotifier.currentOther.imgList),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Text(
                  'Rs ${otherNotifier.currentOther.price}',
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
                          child: Image.asset('assets/images/CatOther.png'),
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
                            'Any Property',
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
                                'wefkjehlkhf kekjw',
                                style: TextStyle(
                                  fontSize: 16.0,
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
                      otherNotifier.currentOther.description,
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
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
                      otherNotifier.currentOther.condition,
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
                      otherNotifier.currentOther.ownerId,
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
              authNotifier.userId != otherNotifier.currentOther.ownerId
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RaisedButton(
                            onPressed: () async {
                              String ans = (await isPresent(
                                      authNotifier.userId,
                                      otherNotifier.currentOther.ownerId,
                                      chatNotifier,
                                      authNotifier))
                                  .toString();
                              if (ans == "null") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatBoxWidget(
                                      ownerId:
                                          otherNotifier.currentOther.ownerId,
                                      productId: otherNotifier.currentOther.id,
                                    ),
                                  ),
                                );
                              } else if (ans != "null") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage()),
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
                              isBookmarked
                                  ? "Added to Bookmarks"
                                  : 'Add to WishList',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            onPressed: () {
                              if (!isBookmarked) {
                                Future<bool> result = addToBookmarks(
                                    otherNotifier.currentOther.id);
                                result.then((value) => value == true
                                    ? showSnackBar("Added to BookMarks")
                                    : showSnackBar("Error Occured"));
                                setState(() {
                                  isBookmarked = true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  : Container(),
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
