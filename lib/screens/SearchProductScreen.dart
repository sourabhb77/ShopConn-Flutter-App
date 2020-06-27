import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/notifier/sortNotifier.dart';
import 'package:shopconn/widgets/Item.dart';

class SearchProduct extends SearchDelegate<dynamic> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    SortNotifier sortNotifier =
        Provider.of<SortNotifier>(context, listen: true);
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        sortNotifier.currentSortParameter = 'name';
        sortNotifier.currentSortDesc = false;
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    SortNotifier sortNotifier =
        Provider.of<SortNotifier>(context, listen: true);
    List inputTagList = query.split(" ");
    Stream<QuerySnapshot> productStream = Firestore.instance
        .collection("post")
        .orderBy(sortNotifier.currentSortParameter,
            descending: sortNotifier.currentSortDesc)
        .where('tagList', arrayContainsAny: inputTagList)
        .snapshots();
    return Scaffold(
      appBar: CustomAppBar(),
      body: StreamBuilder(
        stream: productStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemBuilder: (BuildContext context, index) {
                return ProductItem(
                  data: snapshot.data.documents[index],
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    // final mylist= query.isEmpty
    //               ? []
    //               :productNotifier.productList.where((p)=>p.name.toString().toLowerCase().startsWith(query.toLowerCase())).toList();
    // return ListView.builder(
    //   itemBuilder:(context,index){
    //     return InkWell(
    //       onTap: () {

    //       },
    //       child: Container(
    //         padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //         child: Row(
    //           children: [
    //             Text(
    //               mylist[index].name,
    //               style: TextStyle(
    //                 fontSize: 16.0
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },

    //   itemCount: mylist.length,
    // );

    List inputTagList = query.split(" ");
    Stream<QuerySnapshot> productStream = Firestore.instance
        .collection("post")
        .where('tagList', arrayContainsAny: inputTagList)
        .snapshots();
    return StreamBuilder(
      stream: productStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Row(
                    children: [
                      Text(
                        snapshot.data.documents[index]["name"],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.documents.length,
            ),
          );
        }
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    print("here custon app bar");
    return Container(
      color: sc_PrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: <Widget>[
              Expanded(flex: 3, child: FilterBox()),
              Expanded(flex: 3, child: SortBox()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

enum SingingCharacter { nameAZ, nameZA, priceLH, priceHL }

class SortBox extends StatefulWidget {
  SortBox({Key key}) : super(key: key);

  @override
  _SortBoxState createState() => _SortBoxState();
}

class _SortBoxState extends State<SortBox> {
  SingingCharacter _character = SingingCharacter.nameAZ;
  _showModalBottomSheet(context) {
    SortNotifier sortNotifier =
        Provider.of<SortNotifier>(context, listen: true);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: const Text('Product Name : a-z'),
                leading: Radio(
                  value: SingingCharacter.nameAZ,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      sortNotifier.currentSortParameter = "name";
                      sortNotifier.currentSortDesc = false;
                      _character = value;
                    });
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  setState(() {
                    sortNotifier.currentSortParameter = "name";
                    sortNotifier.currentSortDesc = false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Product Name : z-a'),
                leading: Radio(
                  value: SingingCharacter.nameZA,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      sortNotifier.currentSortParameter = "name";
                      sortNotifier.currentSortDesc = true;
                      _character = value;
                    });
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  setState(() {
                    sortNotifier.currentSortParameter = "name";
                    sortNotifier.currentSortDesc = true;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Price : Low - High'),
                leading: Radio(
                  value: SingingCharacter.priceLH,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      sortNotifier.currentSortParameter = "price";
                      sortNotifier.currentSortDesc = false;
                      _character = value;
                    });
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  setState(() {
                    sortNotifier.currentSortParameter = "price";
                    sortNotifier.currentSortDesc = false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Price : High - Low'),
                leading: Radio(
                  value: SingingCharacter.priceHL,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      sortNotifier.currentSortParameter = "price";
                      sortNotifier.currentSortDesc = true;
                      _character = value;
                    });
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  setState(() {
                    sortNotifier.currentSortParameter = "price";
                    sortNotifier.currentSortDesc = true;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tapped on sort");
        _showModalBottomSheet(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sort, color: sc_AppBarTextColor),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "SORT",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: sc_AppBarTextColor,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class FilterBox extends StatelessWidget {
  _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tapped on filter");
        _showModalBottomSheet(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_list, color: sc_AppBarTextColor),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "FILTER",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: sc_AppBarTextColor,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
