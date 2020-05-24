import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopconn/const/Theme.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  // CarouselController buttonCarouselController = CarouselController();

  List imgList = [
    'https://rukminim1.flixcart.com/image/352/352/jpu324w0/book/3/8/4/database-system-concepts-6e-original-imafbz6nzfbhbsfr.jpeg?q=70',
    'https://d20ohkaloyme4g.cloudfront.net/img/document_thumbnails/0cd25c4f984290d57c8c1703ff27930c/thumb_1200_1553.png',
    'https://images-na.ssl-images-amazon.com/images/I/51ibUItxzcL._SX258_BO1,204,203,200_.jpg',
    ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

 @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
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
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index ? sc_PrimaryColor : sc_grey,
            ),
          );
        }),
      ),
    ]
  );
}