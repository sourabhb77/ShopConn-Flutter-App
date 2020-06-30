import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/filterNotifier.dart';
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
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);

    // List productCategoryList = ["Book", "Clothes", "Note", "Other"];
    // int minPrice, maxPrice;
    // print(filterNotifier.currentMinPrice);
    // print(filterNotifier.currentMinPrice);
    // print("\n**************efhgej\n");
    // if (filterNotifier.currentProductCategory == "") {
    //   // productCategoryList = ["Book", "Clothes", "Note", "Other"];
    //   print(productCategoryList);
    // } else {
    //   switch (filterNotifier.currentProductCategory) {
    //     case "Book":
    //       productCategoryList.clear();
    //       productCategoryList.add("Book");
    //       break;
    //     case "Clothes":
    //       productCategoryList.clear();
    //       productCategoryList.add("Clothes");
    //       break;
    //     case "Note":
    //       productCategoryList.clear();
    //       productCategoryList.add("Note");
    //       break;
    //     case "Other":
    //       productCategoryList.clear();
    //       productCategoryList.add("Other");
    //       break;
    //     default:
    //     // productCategoryList = ["Book", "Clothes", "Note", "Other"];
    //   }
    //   // productCategoryList.add(filterNotifier.currentProductCategory);
    //   print(productCategoryList);
    // }
    int minPrice = 0, maxPrice = 3000;
    dynamic postRef;
    if (filterNotifier.currentProductCategory != "") {
      postRef = Firestore.instance
          .collection("post")
          .where("productCategory",
              isEqualTo: filterNotifier.currentProductCategory)
          .orderBy("price", descending: false)
          .where("price", isLessThanOrEqualTo: filterNotifier.currentMaxPrice)
          .where("price",
              isGreaterThanOrEqualTo: filterNotifier.currentMinPrice);
    } else {
      postRef = Firestore.instance
          .collection("post")
          .orderBy("price", descending: false)
          .where("price", isLessThanOrEqualTo: filterNotifier.currentMaxPrice)
          .where("price",
              isGreaterThanOrEqualTo: filterNotifier.currentMinPrice);
    }

    // if (filterNotifier.currentCondition != "") {
    //   postRef = postRef.where("condition",
    //       isEqualTo: filterNotifier.currentCondition);
    // }

    // postRef = postRef
    //     .where("price", isLessThanOrEqualTo: filterNotifier.currentMaxPrice)
    //     .where("price", isGreaterThanOrEqualTo: filterNotifier.currentMinPrice);

    List inputTagList = query.toLowerCase().split(" ");
    Stream<QuerySnapshot> productStream = postRef
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

    List inputTagList = query.toLowerCase().split(" ");
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
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        // filterNotifier.currentBookCategory = "";
        // filterNotifier.currentBranchBook = "";
        // filterNotifier.currentTypeOfCloth = "";
        // filterNotifier.currentBranchNote = "";
        // filterNotifier.currentYear = "";
        // filterNotifier.currentMaxPrice = 0;
        // filterNotifier.currentMinPrice = 0;
        // filterNotifier.currentCondition = "";
        // filterNotifier.currentProductCategory = "";
        return Container(
          height: 500,
          decoration: BoxDecoration(
            // color: Colors.redAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 1.0,
            minChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Filters",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: sc_ItemTitleColor,
                              ),
                            ),
                            RaisedButton(
                              elevation: 0,
                              color: sc_PrimaryColor,
                              padding:
                                  EdgeInsets.fromLTRB(13.0, 10.0, 13.0, 10.0),
                              child: Text(
                                'Apply Now',
                                style: TextStyle(
                                  color: sc_AppBarTextColor,
                                  fontSize: 18.0,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () {
                                print(
                                    "\n****informing to filter notifier******\n");
                                if (filterNotifier.currentProductCategory ==
                                    "Book") {
                                  filterNotifier.currentTypeOfCloth = "";
                                  filterNotifier.currentYear = "";
                                  filterNotifier.currentBranchNote = "";
                                } else if (filterNotifier
                                        .currentProductCategory ==
                                    "Cloth") {
                                  filterNotifier.currentBookCategory = "";
                                  filterNotifier.currentBranchBook = "";
                                  filterNotifier.currentYear = "";
                                  filterNotifier.currentBranchNote = "";
                                } else if (filterNotifier
                                        .currentProductCategory ==
                                    "Note") {
                                  filterNotifier.currentBookCategory = "";
                                  filterNotifier.currentBranchBook = "";
                                  filterNotifier.currentTypeOfCloth = "";
                                } else if (filterNotifier
                                        .currentProductCategory ==
                                    "Other") {
                                  filterNotifier.currentBookCategory = "";
                                  filterNotifier.currentBranchBook = "";
                                  filterNotifier.currentTypeOfCloth = "";
                                  filterNotifier.currentBranchNote = "";
                                  filterNotifier.currentYear = "";
                                }
                                Navigator.pop(context);
                                print(
                                    "\n****done informing to filter notifier******\n");
                              },
                            ),
                          ],
                        ),
                      ),
                      PriceSlider(),
                      Divider(
                        height: 10.0,
                        color: sc_grey,
                        thickness: 8.0,
                      ),
                      EstheticCondition(),
                      Divider(
                        height: 10.0,
                        color: sc_grey,
                        thickness: 8.0,
                      ),
                      ProductCategory(),
                      Divider(
                        height: 10.0,
                        color: sc_grey,
                        thickness: 8.0,
                      ),
                    ],
                  ),
                ),
              );
            },
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
            width: 20.0,
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

class PriceSlider extends StatefulWidget {
  PriceSlider({Key key}) : super(key: key);

  @override
  _PriceSliderState createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  static double _lower = 0;
  static double _upper = 3000;
  RangeValues values = RangeValues(_lower, _upper);

  @override
  Widget build(BuildContext context) {
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
          child: Text(
            "Price",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        RangeSlider(
          min: _lower,
          max: _upper,
          divisions: 60,
          activeColor: sc_PrimaryColor,
          labels: RangeLabels(
              values.start.toInt().toString(), values.end.toInt().toString()),
          values: values,
          onChanged: (val) {
            setState(() {
              values = val;
            });
            filterNotifier.currentMinPrice = val.start.toInt();
            filterNotifier.currentMinPrice = val.end.toInt();
          },
        ),
      ],
    );
  }
}

class EstheticCondition extends StatefulWidget {
  EstheticCondition({Key key}) : super(key: key);

  @override
  _EstheticConditionState createState() => _EstheticConditionState();
}

class _EstheticConditionState extends State<EstheticCondition> {
  String _condition = "";
  @override
  Widget build(BuildContext context) {
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
            child: Text(
              "Esthetic Condition",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _condition = "Very Good");
                      filterNotifier.currentCondition = "Very Good";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _condition == "Very Good"
                            ? sc_InputBackgroundColor
                            : sc_AppBarTextColor,
                        border: Border.all(
                          color: _condition == "Very Good"
                              ? sc_PrimaryColor
                              : sc_InputBackgroundColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Very Good",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight: _condition == "Very Good"
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _condition = "Good");
                      filterNotifier.currentCondition = "Good";
                    },
                    child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        color: _condition == "Good"
                            ? sc_InputBackgroundColor
                            : sc_AppBarTextColor,
                        border: Border.all(
                          color: _condition == "Good"
                              ? sc_PrimaryColor
                              : sc_InputBackgroundColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Good",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight: _condition == "Good"
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _condition = "Bad");
                      filterNotifier.currentCondition = "Bad";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _condition == "Bad"
                            ? sc_InputBackgroundColor
                            : sc_AppBarTextColor,
                        border: Border.all(
                          color: _condition == "Bad"
                              ? sc_PrimaryColor
                              : sc_InputBackgroundColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bad",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight: _condition == "Bad"
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductCategory extends StatefulWidget {
  ProductCategory({Key key}) : super(key: key);

  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  String _productCat = "";

  String _bookCat = "";
  String _branchBook = "";

  String _typeOfCloth = "";

  String _branchNote = "";
  String _year = '';

  Widget _buildBookOptions(BuildContext context) {
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Text(
              "Book Category",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _bookCat = "Educational");
                    filterNotifier.currentBookCategory = "Educational";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _bookCat == "Educational"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _bookCat == "Educational"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Educational",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _bookCat == "Educational"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _bookCat = "NonEducational");
                    filterNotifier.currentBookCategory = "NonEducational";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _bookCat == "NonEducational"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _bookCat == "NonEducational"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NonEducational",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _bookCat == "NonEducational"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Branch",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchBook = "IT");
                            filterNotifier.currentBranchBook = "IT";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchBook == "IT"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchBook == "IT"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "IT",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchBook == "IT"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchBook = "CS");
                            filterNotifier.currentBranchBook = "CS";
                          },
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              color: _branchBook == "CS"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchBook == "CS"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CS",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchBook == "CS"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchBook = "MECH");
                            filterNotifier.currentBranchBook = "MECH";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchBook == "MECH"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchBook == "MECH"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "MECH",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchBook == "MECH"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchBook = "ETRX");
                            filterNotifier.currentBranchBook = "ETRX";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchBook == "ETRX"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchBook == "ETRX"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ETRX",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchBook == "ETRX"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchBook = "EXTC");
                            filterNotifier.currentBranchBook = "EXTC";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchBook == "EXTC"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchBook == "EXTC"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "EXTC",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchBook == "EXTC"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClothOptions(BuildContext context) {
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Text(
              "Cloth Type",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _typeOfCloth = "Boiler Suit");
                    filterNotifier.currentTypeOfCloth = "Boiler Suit";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _typeOfCloth == "Boiler Suit"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _typeOfCloth == "Boiler Suit"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Boiler Suit",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _typeOfCloth == "Boiler Suit"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _typeOfCloth = "Labcoat");
                    filterNotifier.currentTypeOfCloth = "Labcoat";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _typeOfCloth == "Labcoat"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _typeOfCloth == "Labcoat"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Labcoat",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _typeOfCloth == "Labcoat"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteOptions(BuildContext context) {
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Text(
              "Year",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _year = "FY");
                    filterNotifier.currentYear = "FY";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _year == "FY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _year == "FY"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "FY",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _year == "FY"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _year = "SY");
                    filterNotifier.currentYear = "SY";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _year == "SY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _year == "SY"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SY",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _year == "SY"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _year = "TY");
                    filterNotifier.currentYear = "TY";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _year == "TY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _year == "TY"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TY",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _year == "TY"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _year = "LY");
                    filterNotifier.currentYear = "LY";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _year == "LY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: _year == "LY"
                            ? sc_PrimaryColor
                            : sc_InputBackgroundColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LY",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: _year == "LY"
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Branch",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchNote = "IT");
                            filterNotifier.currentBranchNote = "IT";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchNote == "IT"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchNote == "IT"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "IT",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchNote == "IT"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchNote = "CS");
                            filterNotifier.currentBranchNote = "CS";
                          },
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              color: _branchNote == "CS"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchNote == "CS"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CS",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchNote == "CS"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchNote = "MECH");
                            filterNotifier.currentBranchNote = "MECH";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchNote == "MECH"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchNote == "MECH"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "MECH",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchNote == "MECH"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchNote = "ETRX");
                            filterNotifier.currentBranchNote = "ETRX";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchNote == "ETRX"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchNote == "ETRX"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ETRX",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchNote == "ETRX"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _branchNote = "EXTC");
                            filterNotifier.currentBranchNote = "EXTC";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _branchNote == "EXTC"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: _branchNote == "EXTC"
                                    ? sc_PrimaryColor
                                    : sc_InputBackgroundColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "EXTC",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: sc_ItemTitleColor,
                                    fontWeight: _branchNote == "EXTC"
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Text(
              "Product Category",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _productCat = "Book";
                  });
                  filterNotifier.currentProductCategory = "Book";
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: _productCat == "Book"
                        ? Border.all(
                            color: sc_PrimaryColor,
                            width: 5.0,
                          )
                        : null,
                    borderRadius: BorderRadius.all(Radius.circular(13.0)),
                  ),
                  child: Image.asset(
                    'assets/images/CatBooks.png',
                    height: 70.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _productCat = "Cloth";
                  });
                  filterNotifier.currentProductCategory = "Clothes";
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: _productCat == "Cloth"
                        ? Border.all(
                            color: sc_PrimaryColor,
                            width: 5.0,
                          )
                        : null,
                    borderRadius: BorderRadius.all(Radius.circular(13.0)),
                  ),
                  child: Image.asset(
                    'assets/images/CatClothes.png',
                    height: 70.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _productCat = "Note";
                  });
                  filterNotifier.currentProductCategory = "Note";
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: _productCat == "Note"
                        ? Border.all(
                            color: sc_PrimaryColor,
                            width: 5.0,
                          )
                        : null,
                    borderRadius: BorderRadius.all(Radius.circular(13.0)),
                  ),
                  child: Image.asset(
                    'assets/images/CatNotes.png',
                    height: 70.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _productCat = "Other";
                  });
                  filterNotifier.currentProductCategory = "Other";
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: _productCat == "Other"
                        ? Border.all(
                            color: sc_PrimaryColor,
                            width: 5.0,
                          )
                        : null,
                    borderRadius: BorderRadius.all(Radius.circular(13.0)),
                  ),
                  child: Image.asset(
                    'assets/images/CatOther.png',
                    height: 70.0,
                  ),
                ),
              ),
            ],
          ),

          // different options by diff category

          _productCat == "Book" ? _buildBookOptions(context) : Container(),
          _productCat == "Cloth" ? _buildClothOptions(context) : Container(),
          _productCat == "Note" ? _buildNoteOptions(context) : Container(),
        ],
      ),
    );
  }
}
