import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/noteNotifier.dart';
import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/widgets/Carousel.dart';
import 'package:shopconn/widgets/chatBoxWidget.dart';

class ProductDetailScreen_Note extends StatefulWidget {
  const ProductDetailScreen_Note({Key key}) : super(key: key);

  @override
  _ProductDetailScreen_NoteState createState() =>
      _ProductDetailScreen_NoteState();
}

class _ProductDetailScreen_NoteState extends State<ProductDetailScreen_Note> {
  List imgList = [];
  bool showmore = true;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  void setBool() {
    setState(() => showmore = !showmore);
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);
    imgList = noteNotifier.currentNote.imgList;
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
                  noteNotifier.currentNote.name,
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
              Carousel (imgList: noteNotifier.currentNote.imgList,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Text(
                  'Rs ${noteNotifier.currentNote.price}',
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
                          child: Image.asset('assets/images/CatNotes.png'),
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
                            'Subject',
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
                                noteNotifier.currentNote.subject,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Year',
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
                              noteNotifier.currentNote.year,
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
                              noteNotifier.currentNote.branch,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Faculty Name',
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
                              noteNotifier.currentNote.facultyName,
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
                              noteNotifier.currentNote.condition,
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
                      noteNotifier.currentNote.description,
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
                      noteNotifier.currentNote.ownerId,
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
                                noteNotifier.currentNote.ownerId,
                                chatNotifier,
                                authNotifier))
                            .toString();
                        if (ans == "null") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatBoxWidget(
                                ownerId: noteNotifier.currentNote.ownerId,
                                productId: noteNotifier.currentNote.id,
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
                            addToBookmarks(noteNotifier.currentNote.id);
                        result.then((value) => value == true
                            ? showSnackBar("Added to BookMarks")
                            : showSnackBar("Error Occured"));
                      },
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
    void showSnackBar(String string) {
    var snackBar =
        new SnackBar(content: new Text(string,
        style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,  
        ),
        
        ), backgroundColor: Colors.teal, action: SnackBarAction(
          label: "Ok",
          textColor: Colors.white,

          onPressed: () {
          },
        ),
        elevation: 4.0,
      );
    if(_scaffoldKey.currentState != null)
    _scaffoldKey.currentState.showSnackBar(snackBar);

  }
}
