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
import 'package:shopconn/screens/chatbox.dart';
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
  bool showmore = true;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

  void setBool() {
    setState(() => showmore = !showmore);
  }

  @override
  Widget build(BuildContext context) {
    ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context);
    imgList = otherNotifier.currentOther.imgList;
    return Scaffold(
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
              onPressed: () {},
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
              Column(children: <Widget>[
                CarouselSlider(
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          // width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          height: 400.0,
                          // margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: sc_PrimaryColor,
                          ),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  // carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 1.0,
                    initialPage: 2,
                    //   onPageChanged: (_current) {
                    //     setState(() {
                    //       _current = index;
                    //     }
                    //   );
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(imgList, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? sc_PrimaryColor : sc_grey,
                      ),
                    );
                  }),
                ),
              ]),
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
              Padding(
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
                                ownerId: otherNotifier.currentOther.ownerId,
                                productId: otherNotifier.currentOther.id,
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ));
  }
}
