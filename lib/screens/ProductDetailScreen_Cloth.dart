// import 'package:flutter/material.dart';
// import 'package:shopconn/api/shopconnApi.dart';
// import 'package:shopconn/const/Theme.dart';
// import 'package:shopconn/notifier/clothesNotifier.dart';
// import '../widgets/Carousel.dart';

// class ProductDetailScreen_Cloth extends StatefulWidget {
//   const ProductDetailScreen_Cloth({Key key}) : super(key: key);

//   @override
//   _ProductDetailScreen_ClothState createState() =>
//       _ProductDetailScreen_ClothState();
// }

// class _ProductDetailScreen_ClothState extends State<ProductDetailScreen_Cloth> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: sc_AppBarBackgroundColor,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {},
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.search),
//               tooltip: 'Search',
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: Icon(Icons.bookmark),
//               tooltip: 'Saved Product',
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   'Boiler Suit',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w500,
//                     color: sc_ItemTitleColor,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 // Container(

//                 // ),
//                 Carousel(),
//                 // SizedBox(
//                 //   height: 30.0,
//                 // ),
//                 Text(
//                   'Rs 400',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                     color: sc_PrimaryColor,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Column(
//                       children: <Widget>[
//                         Text(
//                           'Category',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: sc_ItemTitleColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         Container(
//                           decoration: new BoxDecoration(
//                             color: sc_skyblue,
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           height: 70.0,
//                           width: 70.0,
//                           child: Image.asset('assets/images/CatClothes.png'),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 50.0,
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             'Size',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               color: sc_ItemTitleColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10.0,
//                           ),
//                           Container(
//                             decoration: new BoxDecoration(
//                               color: sc_skyblue,
//                               borderRadius: BorderRadius.circular(7),
//                             ),
//                             // color: sc_skyblue,
//                             height: 70.0,
//                             // width: 70.0,
//                             child: Center(
//                               child: Text(
//                                 '6',
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                   color: sc_ItemInfoColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Text(
//                   'Description',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: sc_ItemTitleColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10.0),
//                       color: sc_grey,
//                       child: Text(
//                         'wejfwgejf wwfgwe wehfw wfgf\nfewgw wefhefgwe hjg\nwsc sdhc sdc kas mhwewebwj scvsc akh',
//                         style: TextStyle(
//                           color: sc_ItemTitleColor,
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Text(
//                   'Owner',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: sc_ItemTitleColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10.0),
//                       color: sc_grey,
//                       child: Text(
//                         'Dr. Daddy',
//                         style: TextStyle(
//                           color: sc_ItemTitleColor,
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       RaisedButton(
//                         color: sc_PrimaryColor,
//                         child: Text(
//                           'Chat Now',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                           ),
//                         ),
//                         onPressed: () {
//                           print("On Pressed Chat Now");

//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(builder: (context) =>AddProuctScreen_Book()),
//                           // );
//                         },
//                       ),
//                       RaisedButton(
//                         color: sc_PrimaryColor,
//                         child: Text(
//                           'Add to WishList',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                           ),
//                         ),
//                         onPressed: () {
//                            print("adding book mark");
//                           // Future<bool> result =
//                           //     addToBookmarks(notifier.currentBook.id);
//                           // result.then((value) => print("Result: $value"));

//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(builder: (context) =>AddProuctScreen_Book()),
//                           // );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/widgets/chatBoxWidget.dart';
// import 'package:shopconn/screens/SearchScreen.dart';
// import 'package:shopconn/screens/SearchScreen.dart';
import '../widgets/Carousel.dart';

class ProductDetailScreen_Cloth extends StatefulWidget {
  const ProductDetailScreen_Cloth({Key key}) : super(key: key);

  @override
  _ProductDetailScreen_ClothState createState() =>
      _ProductDetailScreen_ClothState();
}

class _ProductDetailScreen_ClothState extends State<ProductDetailScreen_Cloth> {
  bool showmore = true;
  List imgList = [];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

  AuthNotifier authNotifier;
  ClothesNotifier bookNotifier;
  ChatNotifier chatNotifier;

  @override
  Widget build(BuildContext context) {
    ClothesNotifier clothesNotifier = Provider.of<ClothesNotifier>(context);
    imgList = clothesNotifier.currentClothes.imgList;
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        // receiver = bookNotifier.currentBook.ownerId;
                        // sender = authNotifier.userId;
                        // print(isPresent(
                        //     sender, receiver, chatNotifier, authNotifier));
                        String ans = (await isPresent(
                                authNotifier.userId,
                                clothesNotifier.currentClothes.ownerId,
                                chatNotifier,
                                authNotifier))
                            .toString();
                        // change();
                        if (ans == "null") {
                          // print(bookNotifier.currentBook.ownerId);
                          // print("Sending Chat Request NOW ****************");

                          // sendRequest();
                          // print("REQUEST SENT ************************");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatBoxWidget(
                                    ownerId: clothesNotifier
                                        .currentClothes.ownerId)),
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
        )

        // : SingleChildScrollView(
        //     child: Padding(
        //       padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //       child: Column(
        //         // mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(
        //             clothesNotifier.currentClothes.name,
        //             style: TextStyle(
        //               fontSize: 18.0,
        //               fontWeight: FontWeight.w500,
        //               color: sc_ItemTitleColor,
        //             ),
        //           ),
        //           SizedBox(
        //             height: 15.0,
        //           ),
        //           Column(children: <Widget>[
        //             CarouselSlider(
        //               items: imgList.map((imgUrl) {
        //                 return Builder(
        //                   builder: (BuildContext context) {
        //                     return Container(
        //                       // width: MediaQuery.of(context).size.width,
        //                       // height: MediaQuery.of(context).size.height,
        //                       height: 400.0,
        //                       // margin: EdgeInsets.symmetric(horizontal: 10.0),
        //                       decoration: BoxDecoration(
        //                         color: sc_PrimaryColor,
        //                       ),
        //                       child: Image.network(
        //                         imgUrl,
        //                         fit: BoxFit.fill,
        //                       ),
        //                     );
        //                   },
        //                 );
        //               }).toList(),
        //               // carouselController: buttonCarouselController,
        //               options: CarouselOptions(
        //                 autoPlay: false,
        //                 enlargeCenterPage: true,
        //                 viewportFraction: 0.9,
        //                 aspectRatio: 1.0,
        //                 initialPage: 2,
        //                 //   onPageChanged: (_current) {
        //                 //     setState(() {
        //                 //       _current = index;
        //                 //     }
        //                 //   );
        //               ),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: map<Widget>(imgList, (index, url) {
        //                 return Container(
        //                   width: 10.0,
        //                   height: 10.0,
        //                   margin: EdgeInsets.symmetric(
        //                       vertical: 10.0, horizontal: 2.0),
        //                   decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     color: _current == index
        //                         ? sc_PrimaryColor
        //                         : sc_grey,
        //                   ),
        //                 );
        //               }),
        //             ),
        //           ]),
        //           Text(
        //             'Rs ${clothesNotifier.currentClothes.price}',
        //             style: TextStyle(
        //               fontSize: 20.0,
        //               fontWeight: FontWeight.bold,
        //               color: sc_PrimaryColor,
        //             ),
        //           ),
        //           SizedBox(
        //             height: 15.0,
        //           ),
        //           Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: <Widget>[
        //               Column(
        //                 children: <Widget>[
        //                   Text(
        //                     clothesNotifier.currentClothes.productCategory,
        //                     style: TextStyle(
        //                       fontSize: 16.0,
        //                       color: sc_ItemTitleColor,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 10.0,
        //                   ),
        //                   Container(
        //                     decoration: new BoxDecoration(
        //                       color: sc_PrimaryColor,
        //                       borderRadius: BorderRadius.circular(7),
        //                     ),
        //                     height: 70.0,
        //                     width: 70.0,
        //                     child:
        //                         Image.asset('assets/images/CatClothes.png'),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(
        //                 width: 50.0,
        //               ),
        //               Expanded(
        //                 child: Column(
        //                   children: <Widget>[
        //                     Text(
        //                       'Size',
        //                       style: TextStyle(
        //                         fontSize: 16.0,
        //                         color: sc_ItemTitleColor,
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       height: 10.0,
        //                     ),
        //                     Container(
        //                       decoration: new BoxDecoration(
        //                         color: sc_skyblue,
        //                         borderRadius: BorderRadius.circular(7),
        //                       ),
        //                       // color: sc_skyblue,
        //                       height: 70.0,
        //                       // width: 70.0,
        //                       child: Center(
        //                         child: Text(
        //                           clothesNotifier.currentClothes.size
        //                               .toString(),
        //                           style: TextStyle(
        //                             fontSize: 20.0,
        //                             color: sc_ItemInfoColor,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 15.0,
        //           ),
        //           Row(
        //             children: <Widget>[
        //               Expanded(
        //                 flex: 3,
        //                 child: Text("More Features and details",
        //                     style: TextStyle(
        //                         fontSize: 16.0,
        //                         color: sc_ItemTitleColor,
        //                         fontWeight: FontWeight.bold)),
        //               ),
        //               Expanded(
        //                 flex: 1,
        //                 child: IconButton(
        //                     icon: Text("See less",
        //                         style: TextStyle(
        //                             fontSize: 16.0,
        //                             color: sc_skyblue,
        //                             fontWeight: FontWeight.bold)),
        //                     onPressed: () {
        //                       setBool();
        //                     }),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 15.0,
        //           ),
        //           Row(
        //             children: <Widget>[
        //               Expanded(
        //                   child: Column(children: <Widget>[
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
        //                   children: [
        //                     Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(7),
        //                       ),
        //                       child: Text(
        //                         'Type',
        //                         style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           color: sc_onlyScreenTextTitle,
        //                           fontSize: 16.0,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 SizedBox(
        //                   height: 10.0,
        //                 ),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
        //                   children: [
        //                     Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(7),
        //                       ),
        //                       child: Text(
        //                         clothesNotifier.currentClothes.type,
        //                         style: TextStyle(
        //                           color: sc_onlyScreenTextInfo,
        //                           fontSize: 16.0,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ])),
        //               SizedBox(width: 20.0),
        //               Expanded(
        //                   child: Column(children: <Widget>[
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
        //                   children: [
        //                     Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(7),
        //                       ),
        //                       child: Text(
        //                         'Condition',
        //                         style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           color: sc_onlyScreenTextTitle,
        //                           fontSize: 16.0,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 SizedBox(
        //                   height: 10.0,
        //                 ),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
        //                   children: [
        //                     Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(7),
        //                       ),
        //                       child: Text(
        //                         clothesNotifier.currentClothes.condition,
        //                         style: TextStyle(
        //                           color: sc_onlyScreenTextInfo,
        //                           fontSize: 16.0,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ])),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 10.0,
        //           ),
        //           Text(
        //             'Description',
        //             style: TextStyle(
        //               fontSize: 16.0,
        //               color: sc_onlyScreenTextTitle,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           SizedBox(
        //             height: 10.0,
        //           ),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.stretch,
        //             children: [
        //               Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(7),
        //                 ),
        //                 child: Text(
        //                   clothesNotifier.currentClothes.description,
        //                   style: TextStyle(
        //                     color: sc_onlyScreenTextInfo,
        //                     fontSize: 16.0,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 15.0,
        //           ),
        //           Text(
        //             'Owner',
        //             style: TextStyle(
        //               fontSize: 16.0,
        //               color: sc_onlyScreenTextTitle,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           SizedBox(
        //             height: 10.0,
        //           ),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.stretch,
        //             children: [
        //               Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(7),
        //                 ),
        //                 child: Text(
        //                   "Doctor daddy",
        //                   style: TextStyle(
        //                     color: sc_onlyScreenTextInfo,
        //                     fontSize: 16.0,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 50.0,
        //           ),
        //         ],
        //       ),
        //     ),
        //   )
        );
  }
}
