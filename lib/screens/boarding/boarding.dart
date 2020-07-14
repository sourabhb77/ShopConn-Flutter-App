// import 'dart:io';

// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopconn/const/Theme.dart';
// import 'package:shopconn/models/BoardingSlider.dart';
// import 'package:shopconn/notifier/authNotifier.dart';
// import 'package:shopconn/screens/login.dart';

// class BoardingScreen extends StatefulWidget {
//   @override
//   _BoardingScreenState createState() => _BoardingScreenState();
// }

// class _BoardingScreenState extends State<BoardingScreen> {
//   List<BoardingSlider> sliderList = List<BoardingSlider>();
//   PageController pageController = PageController(initialPage: 0);
//   int currIndex = 0; //current Index for the Boarding screen Tile

//   Widget pageIndicator(bool isCurrentPage) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 2.0),
//       height: isCurrentPage ? 10 : 6,
//       width: isCurrentPage ? 10 : 6,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: isCurrentPage ? Colors.grey[700] : Colors.grey[400],
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     sliderList = getSliderList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         controller: pageController,
//         onPageChanged: (value) => setState(() {
//           currIndex = value;
//         }),
//         itemCount: sliderList.length,
//         itemBuilder: (context, index) {
//           return SliderTile(
//             title: sliderList[index].getTitle(),
//             imagePath: sliderList[index].getImagePath(),
//             description: sliderList[index].getDescription(),
//           );
//         },
//       ),
//       bottomSheet: currIndex != sliderList.length - 1
//           ? Container(
//               height: 60,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   InkWell(
//                     onTap: () {
//                       pageController.animateToPage(sliderList.length - 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                     child: Container(
//                       child: Text(
//                         "SKIP",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w900,
//                           letterSpacing: 1.0,
//                         ),
//                       ),
//                       height: 60,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                     ),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       for (int i = 0; i < sliderList.length; ++i)
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
//                           child: pageIndicator(currIndex == i),
//                         ),
//                     ],
//                   ),
//                   InkWell(
//                     onTap: () {
//                       pageController.animateToPage(currIndex + 1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.linear);
//                     },
//                     child: Container(
//                       // color: sc_PrimaryColor,
//                       height: 60,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                       child: Text(
//                         "NEXT",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w900,
//                           letterSpacing: 1.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : InkWell(
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => Login()),
//                 );
//               },
//               child: Container(
//                 height: 50,
//                 margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   color: sc_PrimaryColor,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       "GET STARTED",
//                       style: TextStyle(
//                         color: sc_AppBarTextColor,
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w900,
//                         letterSpacing: 1.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class SliderTile extends StatelessWidget {
//   final String imagePath, title, description;
//   SliderTile({this.imagePath, this.title, this.description});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 100.0,
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
//             height: 300.0,
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           Text(
//             title,
//             style: TextStyle(
//               color: sc_ItemTitleColor,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
//             child: Text(
//               description,
//               style: TextStyle(
//                 fontSize: 15.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/BoardingSlider.dart';
// import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/login.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<BoardingSlider> sliderList = List<BoardingSlider>();
  PageController pageController = PageController(initialPage: 0);
  int currIndex = 0; //current Index for the Boarding screen Tile

  Widget pageIndicator(bool isCurrentPage) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10 : 6,
      width: isCurrentPage ? 10 : 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isCurrentPage ? Colors.grey[700] : Colors.grey[400],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    sliderList = getSliderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (value) => setState(() {
          currIndex = value;
        }),
        itemCount: sliderList.length,
        itemBuilder: (context, index) {
          return SliderTile(
            title: sliderList[index].getTitle(),
            imagePath: sliderList[index].getImagePath(),
            description: sliderList[index].getDescription(),
          );
        },
      ),
      bottomSheet: currIndex != sliderList.length - 1
          ? Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      pageController.animateToPage(sliderList.length - 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    child: Container(
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < sliderList.length; ++i)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: pageIndicator(currIndex == i),
                        ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      pageController.animateToPage(currIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    child: Container(
                      // color: sc_PrimaryColor,
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: sc_PrimaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "GET STARTED",
                      style: TextStyle(
                        color: sc_AppBarTextColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class SliderTile extends StatelessWidget {
  final String imagePath, title, description;
  SliderTile({this.imagePath, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            height: 250.0,
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: sc_ItemTitleColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
            child: Center(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
