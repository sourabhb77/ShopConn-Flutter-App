import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shopconn/models/BoardingSlider.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<BoardingSlider> sliderList = List<BoardingSlider>();
  PageController pageController =PageController(initialPage: 0);
  int currIndex = 0; //current Index for the Boarding screen Tile

  Widget pageIndicator(bool isCurrentPage) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 12 : 6,
      width: isCurrentPage ? 12 : 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
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
            height: Platform.isIOS? 70: 60,
            padding: EdgeInsets.symmetric(horizontal:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      pageController.animateToPage(sliderList.length-1,duration: Duration(milliseconds: 1000),curve: Curves.linear);
                    },
                    child: Text("Skip"),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < sliderList.length; ++i)
                        pageIndicator(currIndex == i),
                    ],
                  ),
                  InkWell(
                    onTap: () 
                    {
                      pageController.animateToPage(currIndex+1, duration: Duration(milliseconds: 1000), curve: Curves.linear);
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            )
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () => {
                      setState((){
                        currIndex++;
                      })
                    },
                    child: Text("SignUP"),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < sliderList.length; ++i)
                        pageIndicator(currIndex == i),
                    ],
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Text("LogIN"),
                  ),
                ],
              ),
            ),
    );
  }
}

class SliderTile extends StatelessWidget {
  String imagePath, title, description;
  SliderTile({this.imagePath, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 28,
          ),
          Text(description),
          SizedBox(
            height: 12,
          ),
          Text(title)
        ],
      ),
    );
  }
}
