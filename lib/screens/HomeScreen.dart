import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/AddProductScreen.dart';
import 'package:shopconn/screens/OnlyCategoryProductScreen.dart';
import 'package:shopconn/screens/SavedProductScreen.dart';
import 'package:shopconn/screens/login.dart';
// import 'package:shopconn/screens/chatbox.dart';
import 'package:shopconn/screens/msg-request.dart';
import 'package:shopconn/widgets/Item.dart';
// import 'package:shopconn/widgets/MessageWidgets/RequestMessageBox.dart';
import 'package:shopconn/widgets/NavDrawer.dart';
import 'package:shopconn/screens/SearchProductScreen.dart';
// import 'package:shopconn/widgets/ProductDisplay.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

_clearUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('logined', false);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sc_PrimaryColor,
        elevation: 0,
        title: Text(
          "ShopConn",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            tooltip: 'Notification',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatBox()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            tooltip: 'Saved Product',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedProductScreen()),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    color: sc_PrimaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  letterSpacing: 1.0,
                                ),
                                children: <TextSpan>[
                              TextSpan(text: "Find Your\n"),
                              TextSpan(
                                  text: "Product",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  )),
                              TextSpan(text: "  Here"),
                            ])),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("going to search screen");
                            showSearch(
                                context: context,
                                delegate: SearchProduct(category: ""));
                          },
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: sc_AppBarTextColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Icon(
                                    Icons.search,
                                    size: 30.0,
                                  ),
                                ),
                                Text(
                                  "Search Here .....",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),

                //for testing purpose
                GestureDetector(
                  onTap: () {
                    signout(authNotifier);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                    _clearUser();
                  },
                  child: Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),

                //end testing purpose

                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 15, 15.0, 7.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      color: sc_ItemTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlyCategoryProductScreen(
                                    category: "Book")),
                          );
                        },
                        child: Image.asset(
                          'assets/images/CatBooks.png',
                          height: 80.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlyCategoryProductScreen(
                                    category: "Clothes")),
                          );
                        },
                        child: Image.asset(
                          'assets/images/CatClothes.png',
                          height: 80.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlyCategoryProductScreen(
                                    category: "Note")),
                          );
                        },
                        child: Image.asset(
                          'assets/images/CatNotes.png',
                          height: 80.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnlyCategoryProductScreen(
                                    category: "Other")),
                          );
                        },
                        child: Image.asset(
                          'assets/images/CatOther.png',
                          height: 80.0,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Newly Added",
                        style: TextStyle(
                          color: sc_ItemTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "See More",
                        style: TextStyle(
                          color: sc_ItemTitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: Firestore.instance
                  .collection("post")
                  .orderBy('postedAt', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print("NO DATA***********************");
                  return SliverToBoxAdapter(
                      child: Center(
                          child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  )));
                  // ));
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      print(
                          "Home :Posted At: ${snapshot.data.documents[index]["postedAt"]}");

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ProductItem(
                          data: snapshot.data.documents[index],
                        ),
                      );
                    }, childCount: snapshot.data.documents.length),
                  );
                }
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProuctScreen()),
            );
            print("go to add product screen");
          },
          child: Icon(Icons.add),
          backgroundColor: sc_PrimaryColor),
      drawer: NavDrawer(),
    );
  }
}
