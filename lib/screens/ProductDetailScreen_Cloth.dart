import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import 'package:shopconn/screens/Bookmarks.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/widgets/Carousel.dart';
import 'package:shopconn/widgets/chatBoxWidget.dart';

class ProductDetailScreen_Cloth extends StatefulWidget {
  const ProductDetailScreen_Cloth({Key key}) : super(key: key);

  @override
  _ProductDetailScreen_ClothState createState() =>
      _ProductDetailScreen_ClothState();
}

class _ProductDetailScreen_ClothState extends State<ProductDetailScreen_Cloth> {
  // bool showmore = true;
  List imgList = [];
  // List<T> map<T>(List list, Function handler) {
  //   List<T> result = [];
  //   for (var i = 0; i < list.length; i++) {
  //     result.add(handler(i, list[i]));
  //   }
  //   return result;
  // }

  // int _current = 0;

  bool isBookmarked = false;

  @override
  void didChangeDependencies() {
    ClothesNotifier clothesNotifier = Provider.of<ClothesNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    isBookmarkedProduct(clothesNotifier.currentClothes.id, authNotifier.userId)
        .then((res) {
      setState(() {
        isBookmarked = res;
      });
    });
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // AuthNotifier authNotifier;
  // ClothesNotifier bookNotifier;
  // ChatNotifier chatNotifier;

  @override
  Widget build(BuildContext context) {
    ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    ClothesNotifier clothesNotifier = Provider.of<ClothesNotifier>(context);
    imgList = clothesNotifier.currentClothes.imgList;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: sc_AppBarBackgroundColor,
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   tooltip: 'Search',
          //   onPressed: () {
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => SearchScreen()));
          //   },
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
                clothesNotifier.currentClothes.name,
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
            Carousel(
              imgList: clothesNotifier.currentClothes.imgList,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Text(
                'Rs ${clothesNotifier.currentClothes.price}',
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
                        clothesNotifier.currentClothes.productCategory,
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
                          color: sc_PrimaryColor,
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
                              clothesNotifier.currentClothes.size.toString(),
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
                            'Type',
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
                            clothesNotifier.currentClothes.type,
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
                            clothesNotifier.currentClothes.condition,
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
                    clothesNotifier.currentClothes.description,
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
                    clothesNotifier.currentClothes.ownerId,
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
            authNotifier.userId != clothesNotifier.currentClothes.ownerId
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            String ans = (await isPresent(
                                    authNotifier.userId,
                                    clothesNotifier.currentClothes.ownerId,
                                    chatNotifier,
                                    authNotifier))
                                .toString();
                            if (ans == "null") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatBoxWidget(
                                    ownerId:
                                        clothesNotifier.currentClothes.ownerId,
                                    productId:
                                        clothesNotifier.currentClothes.id,
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
                                  clothesNotifier.currentClothes.id);
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
      ),
    );
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
