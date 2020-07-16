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
  String category;
  SearchProduct({this.category});
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
    FilterNotifier filterNotifier =
        Provider.of<FilterNotifier>(context, listen: true);
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        sortNotifier.currentSortParameter = 'name';
        sortNotifier.currentSortDesc = false;
        filterNotifier.currentBookCategory = "";
        filterNotifier.currentBranchBook = "";
        filterNotifier.currentTypeOfCloth = "";
        filterNotifier.currentBranchNote = "";
        filterNotifier.currentYear = "";
        filterNotifier.currentMaxPrice = 3000;
        filterNotifier.currentMinPrice = 0;
        filterNotifier.currentCondition = "";
        filterNotifier.currentProductCategory = "";
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

    // while filtering ,we can filter by all parameters indepedently but
    // price range is depend on "orderBy" query and we cant use more than 1 "orderBy" query
    // so if we sort by clicking on "SORT" option by price then only our "price" filter is working

    dynamic postRef;
    postRef = Firestore.instance.collection("post");
    if (sortNotifier.currentSortParameter == 'name') {
      postRef =
          postRef.orderBy("name", descending: sortNotifier.currentSortDesc);
    } else if (sortNotifier.currentSortParameter == 'price') {
      postRef = postRef
          .orderBy("price", descending: sortNotifier.currentSortDesc)
          .where("price", isLessThanOrEqualTo: filterNotifier.currentMaxPrice)
          .where("price",
              isGreaterThanOrEqualTo: filterNotifier.currentMinPrice);
    }

    //to specify what type of product we want to search
    if (category.toString() != "") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        filterNotifier.currentProductCategory = category;
      });
    }
    if (filterNotifier.currentProductCategory != "") {
      switch (filterNotifier.currentProductCategory) {
        case "Book":
          postRef = postRef.where("productCategory",
              isEqualTo: filterNotifier.currentProductCategory);

          if (filterNotifier.currentBookCategory != "") {
            postRef = postRef.where("bookCategory",
                isEqualTo: filterNotifier.currentBookCategory);
          }
          if (filterNotifier.currentBranchBook != "") {
            postRef = postRef.where("branch",
                isEqualTo: filterNotifier.currentBranchBook);
          }
          break;

        case "Clothes":
          postRef = postRef.where("productCategory",
              isEqualTo: filterNotifier.currentProductCategory);

          if (filterNotifier.currentTypeOfCloth != "") {
            postRef = postRef.where("type",
                isEqualTo: filterNotifier.currentTypeOfCloth);
          }
          break;
        case "Note":
          postRef = postRef.where("productCategory",
              isEqualTo: filterNotifier.currentProductCategory);

          if (filterNotifier.currentBranchNote != "") {
            postRef = postRef.where("branch",
                isEqualTo: filterNotifier.currentBranchNote);
          }
          if (filterNotifier.currentYear != "") {
            postRef =
                postRef.where("year", isEqualTo: filterNotifier.currentYear);
          }
          break;
        case "Other":
          postRef = postRef.where("productCategory",
              isEqualTo: filterNotifier.currentProductCategory);
          break;
        default:
        // productCategoryList = ["Book", "Clothes", "Note", "Other"];
      }
    }

    if (filterNotifier.currentCondition != "") {
      postRef = postRef.where("condition",
          isEqualTo: filterNotifier.currentCondition);
    }

    List inputTagList = query.toLowerCase().split(" ");
    Stream<QuerySnapshot> productStream =
        postRef.where('tagList', arrayContainsAny: inputTagList).snapshots();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        sortNotifier.currentSortParameter = 'name';
        sortNotifier.currentSortDesc = false;
        filterNotifier.currentBookCategory = "";
        filterNotifier.currentBranchBook = "";
        filterNotifier.currentTypeOfCloth = "";
        filterNotifier.currentBranchNote = "";
        filterNotifier.currentYear = "";
        filterNotifier.currentMaxPrice = 3000;
        filterNotifier.currentMinPrice = 0;
        filterNotifier.currentCondition = "";
        filterNotifier.currentProductCategory = "";
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(category: category),
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
    dynamic suggestRef = Firestore.instance.collection("post");
    switch (category) {
      case "Book":
        suggestRef = suggestRef.where("productCategory", isEqualTo: category);
        break;
      case "Clothes":
        suggestRef = suggestRef.where("productCategory", isEqualTo: category);
        break;
      case "Note":
        suggestRef = suggestRef.where("productCategory", isEqualTo: category);
        break;
      case "Other":
        suggestRef = suggestRef.where("productCategory", isEqualTo: category);
        break;
      default:
    }
    Stream<QuerySnapshot> productStream =
        suggestRef.where('tagList', arrayContainsAny: inputTagList).snapshots();
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
                return ListTile(
                  onTap: () {
                    query = snapshot.data.documents[index]["name"]
                        .toString()
                        .toLowerCase();
                    showResults(context);
                  },
                  leading: SizedBox(),
                  title: Text(
                    snapshot.data.documents[index]["name"],
                    style: TextStyle(fontSize: 16.0),
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
  String category;
  CustomAppBar({this.category});
  @override
  Widget build(BuildContext context) {
    print("building result");
    return Container(
      color: sc_PrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: <Widget>[
              Expanded(flex: 3, child: FilterBox(category: category)),
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
  _showModalBottomSheet(context) {
    SortNotifier sortNotifier =
        Provider.of<SortNotifier>(context, listen: true);
    SingingCharacter _character; // = SingingCharacter.nameAZ;
    if (sortNotifier.currentSortParameter == "name" &&
        sortNotifier.currentSortDesc == false) {
      _character = SingingCharacter.nameAZ;
    } else if (sortNotifier.currentSortParameter == "name" &&
        sortNotifier.currentSortDesc == true) {
      _character = SingingCharacter.nameZA;
    } else if (sortNotifier.currentSortParameter == "price" &&
        sortNotifier.currentSortDesc == false) {
      _character = SingingCharacter.priceLH;
    } else if (sortNotifier.currentSortParameter == "price" &&
        sortNotifier.currentSortDesc == true) {
      _character = SingingCharacter.priceHL;
    } else {
      _character = SingingCharacter.nameAZ;
    }
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
  String category;
  FilterBox({this.category});
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
                            OutlineButton(
                              // elevation: 0,
                              color: sc_PrimaryColor,
                              padding:
                                  EdgeInsets.fromLTRB(13.0, 10.0, 13.0, 10.0),
                              child: Text(
                                'Clear All',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () {
                                filterNotifier.currentBookCategory = "";
                                filterNotifier.currentBranchBook = "";
                                filterNotifier.currentTypeOfCloth = "";
                                filterNotifier.currentBranchNote = "";
                                filterNotifier.currentYear = "";
                                filterNotifier.currentMinPrice = 0;
                                filterNotifier.currentMaxPrice = 3000;
                                filterNotifier.currentCondition = "";
                                if (category != "") {
                                  filterNotifier.currentProductCategory = "";
                                }
                                Navigator.pop(context);
                                print("****cleared******\n");
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
                      ProductCategory(category: category),
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
    SortNotifier sortNotifier =
        Provider.of<SortNotifier>(context, listen: true);
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
            sortNotifier.currentSortParameter = "price";
            sortNotifier.currentSortDesc = false;
            filterNotifier.currentMinPrice = val.start.toInt();
            filterNotifier.currentMaxPrice = val.end.toInt();
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
                      if (filterNotifier.currentCondition != "Very Good") {
                        // setState(() => _condition = "Very Good");
                        filterNotifier.currentCondition = "Very Good";
                      } else {
                        // setState(() => _condition = "");
                        filterNotifier.currentCondition = "";
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: filterNotifier.currentCondition == "Very Good"
                            ? sc_InputBackgroundColor
                            : sc_AppBarTextColor,
                        border: Border.all(
                          color: filterNotifier.currentCondition == "Very Good"
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
                              fontWeight:
                                  filterNotifier.currentCondition == "Very Good"
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
                      if (filterNotifier.currentCondition != "Good") {
                        // setState(() => _condition = "Good");
                        filterNotifier.currentCondition = "Good";
                      } else {
                        // setState(() => _condition = "");
                        filterNotifier.currentCondition = "";
                      }
                    },
                    child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        color: filterNotifier.currentCondition == "Good"
                            ? sc_InputBackgroundColor
                            : sc_AppBarTextColor,
                        border: Border.all(
                          color: filterNotifier.currentCondition == "Good"
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
                              fontWeight:
                                  filterNotifier.currentCondition == "Good"
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
                      if (filterNotifier.currentCondition != "Not Bad") {
                        // setState(() => _condition = "Bad");
                        filterNotifier.currentCondition = "Not Bad";
                      } else {
                        // setState(() => _condition = "");
                        filterNotifier.currentCondition = "";
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: filterNotifier.currentCondition == "Not Bad"
                            ? sc_InputBackgroundColor
                            : sc_AppBarTextColor,
                        border: Border.all(
                          color: filterNotifier.currentCondition == "Not Bad"
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
                            "Not Bad",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight:
                                  filterNotifier.currentCondition == "Not Bad"
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
  String category;
  ProductCategory({Key key, @required this.category}) : super(key: key);

  @override
  _ProductCategoryState createState() => _ProductCategoryState(category);
}

class _ProductCategoryState extends State<ProductCategory> {
  String _productCat = "";

  String _bookCat = "";
  String _branchBook = "";

  String _typeOfCloth = "";

  String _branchNote = "";
  String _year = '';
  String category;
  _ProductCategoryState(this.category);

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
                    if (filterNotifier.currentBookCategory != "Educational") {
                      filterNotifier.currentBookCategory = "Educational";
                    } else {
                      filterNotifier.currentBookCategory = "";
                    }
                    // setState(() => _bookCat = "Educational");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: filterNotifier.currentBookCategory == "Educational"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color:
                            filterNotifier.currentBookCategory == "Educational"
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
                            fontWeight: filterNotifier.currentBookCategory ==
                                    "Educational"
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
                    if (filterNotifier.currentBookCategory !=
                        "NonEducational") {
                      filterNotifier.currentBookCategory = "NonEducational";
                    } else {
                      filterNotifier.currentBookCategory = "";
                    }
                    // setState(() => _bookCat = "NonEducational");
                    // filterNotifier.currentBookCategory = "NonEducational";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          filterNotifier.currentBookCategory == "NonEducational"
                              ? sc_InputBackgroundColor
                              : sc_AppBarTextColor,
                      border: Border.all(
                        color: filterNotifier.currentBookCategory ==
                                "NonEducational"
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
                            fontWeight: filterNotifier.currentBookCategory ==
                                    "NonEducational"
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
                            if (filterNotifier.currentBranchBook != "IT") {
                              filterNotifier.currentBranchBook = "IT";
                            } else {
                              filterNotifier.currentBranchBook = "";
                            }
                            // setState(() => _branchBook = "IT");
                            // filterNotifier.currentBranchBook = "IT";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchBook == "IT"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: filterNotifier.currentBranchBook == "IT"
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
                                    fontWeight:
                                        filterNotifier.currentBranchBook == "IT"
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
                            if (filterNotifier.currentBranchBook != "CS") {
                              filterNotifier.currentBranchBook = "CS";
                            } else {
                              filterNotifier.currentBranchBook = "";
                            }
                            // setState(() => _branchBook = "CS");
                            // filterNotifier.currentBranchBook = "CS";
                          },
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchBook == "CS"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: filterNotifier.currentBranchBook == "CS"
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
                                    fontWeight:
                                        filterNotifier.currentBranchBook == "CS"
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
                            if (filterNotifier.currentBranchBook != "MECH") {
                              filterNotifier.currentBranchBook = "MECH";
                            } else {
                              filterNotifier.currentBranchBook = "";
                            }
                            // setState(() => _branchBook = "MECH");
                            // filterNotifier.currentBranchBook = "MECH";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchBook == "MECH"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color:
                                    filterNotifier.currentBranchBook == "MECH"
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
                                    fontWeight:
                                        filterNotifier.currentBranchBook ==
                                                "MECH"
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
                            if (filterNotifier.currentBranchBook != "ETRX") {
                              filterNotifier.currentBranchBook = "ETRX";
                            } else {
                              filterNotifier.currentBranchBook = "";
                            }
                            // setState(() => _branchBook = "ETRX");
                            // filterNotifier.currentBranchBook = "ETRX";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchBook == "ETRX"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color:
                                    filterNotifier.currentBranchBook == "ETRX"
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
                                    fontWeight:
                                        filterNotifier.currentBranchBook ==
                                                "ETRX"
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
                            if (filterNotifier.currentBranchBook != "EXTC") {
                              filterNotifier.currentBranchBook = "EXTC";
                            } else {
                              filterNotifier.currentBranchBook = "";
                            }
                            // setState(() => _branchBook = "EXTC");
                            // filterNotifier.currentBranchBook = "EXTC";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchBook == "EXTC"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color:
                                    filterNotifier.currentBranchBook == "EXTC"
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
                                    fontWeight:
                                        filterNotifier.currentBranchBook ==
                                                "EXTC"
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
                    if (filterNotifier.currentTypeOfCloth != "Boiler Suit") {
                      filterNotifier.currentTypeOfCloth = "Boiler Suit";
                    } else {
                      filterNotifier.currentTypeOfCloth = "";
                    }
                    // setState(() => _typeOfCloth = "Boiler Suit");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: filterNotifier.currentTypeOfCloth == "Boiler Suit"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color:
                            filterNotifier.currentTypeOfCloth == "Boiler Suit"
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
                            fontWeight: filterNotifier.currentTypeOfCloth ==
                                    "Boiler Suit"
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
                    if (filterNotifier.currentTypeOfCloth != "Labcoat") {
                      filterNotifier.currentTypeOfCloth = "Labcoat";
                    } else {
                      filterNotifier.currentTypeOfCloth = "";
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: filterNotifier.currentTypeOfCloth == "Labcoat"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: filterNotifier.currentTypeOfCloth == "Labcoat"
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
                            fontWeight:
                                filterNotifier.currentTypeOfCloth == "Labcoat"
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
                    if (filterNotifier.currentYear != "FY") {
                      filterNotifier.currentYear = "FY";
                    } else {
                      filterNotifier.currentYear = "";
                    }
                    // setState(() => _year = "FY");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: filterNotifier.currentYear == "FY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: filterNotifier.currentYear == "FY"
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
                            fontWeight: filterNotifier.currentYear == "FY"
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
                    if (filterNotifier.currentYear != "SY") {
                      filterNotifier.currentYear = "SY";
                    } else {
                      filterNotifier.currentYear = "";
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: filterNotifier.currentYear == "SY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: filterNotifier.currentYear == "SY"
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
                            fontWeight: filterNotifier.currentYear == "SY"
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
                    if (filterNotifier.currentYear != "TY") {
                      filterNotifier.currentYear = "TY";
                    } else {
                      filterNotifier.currentYear = "";
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: filterNotifier.currentYear == "TY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: filterNotifier.currentYear == "TY"
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
                            fontWeight: filterNotifier.currentYear == "TY"
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
                    if (filterNotifier.currentYear != "LY") {
                      filterNotifier.currentYear = "LY";
                    } else {
                      filterNotifier.currentYear = "";
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: filterNotifier.currentYear == "LY"
                          ? sc_InputBackgroundColor
                          : sc_AppBarTextColor,
                      border: Border.all(
                        color: filterNotifier.currentYear == "LY"
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
                            fontWeight: filterNotifier.currentYear == "LY"
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
                            if (filterNotifier.currentBranchNote != "IT") {
                              filterNotifier.currentBranchNote = "IT";
                            } else {
                              filterNotifier.currentBranchNote = "";
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchNote == "IT"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: filterNotifier.currentBranchNote == "IT"
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
                                    fontWeight:
                                        filterNotifier.currentBranchNote == "IT"
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
                            if (filterNotifier.currentBranchNote != "CS") {
                              filterNotifier.currentBranchNote = "CS";
                            } else {
                              filterNotifier.currentBranchNote = "";
                            }
                          },
                          child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchNote == "CS"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color: filterNotifier.currentBranchNote == "CS"
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
                                    fontWeight:
                                        filterNotifier.currentBranchNote == "CS"
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
                            if (filterNotifier.currentBranchNote != "MECH") {
                              filterNotifier.currentBranchNote = "MECH";
                            } else {
                              filterNotifier.currentBranchNote = "";
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchNote == "MECH"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color:
                                    filterNotifier.currentBranchNote == "MECH"
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
                                    fontWeight:
                                        filterNotifier.currentBranchNote ==
                                                "MECH"
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
                            if (filterNotifier.currentBranchNote != "ETRX") {
                              filterNotifier.currentBranchNote = "ETRX";
                            } else {
                              filterNotifier.currentBranchNote = "";
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchNote == "ETRX"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color:
                                    filterNotifier.currentBranchNote == "ETRX"
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
                                    fontWeight:
                                        filterNotifier.currentBranchNote ==
                                                "ETRX"
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
                            if (filterNotifier.currentBranchNote != "EXTC") {
                              filterNotifier.currentBranchNote = "EXTC";
                            } else {
                              filterNotifier.currentBranchNote = "";
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: filterNotifier.currentBranchNote == "EXTC"
                                  ? sc_InputBackgroundColor
                                  : sc_AppBarTextColor,
                              border: Border.all(
                                color:
                                    filterNotifier.currentBranchNote == "EXTC"
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
                                    fontWeight:
                                        filterNotifier.currentBranchNote ==
                                                "EXTC"
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
          category != ""
              ? Container()
              : Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    "Product Category",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
          category != ""
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (filterNotifier.currentProductCategory != "Book") {
                          filterNotifier.currentProductCategory = "Book";
                        } else {
                          filterNotifier.currentProductCategory = "";
                        }
                        filterNotifier.currentTypeOfCloth = "";
                        filterNotifier.currentBranchNote = "";
                        filterNotifier.currentYear = "";
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              filterNotifier.currentProductCategory == "Book"
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
                        if (filterNotifier.currentProductCategory !=
                            "Clothes") {
                          filterNotifier.currentProductCategory = "Clothes";
                        } else {
                          filterNotifier.currentProductCategory = "";
                        }
                        filterNotifier.currentBookCategory = "";
                        filterNotifier.currentBranchBook = "";
                        filterNotifier.currentYear = "";
                        filterNotifier.currentBranchNote = "";
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              filterNotifier.currentProductCategory == "Clothes"
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
                        if (filterNotifier.currentProductCategory != "Note") {
                          filterNotifier.currentProductCategory = "Note";
                        } else {
                          filterNotifier.currentProductCategory = "";
                        }
                        filterNotifier.currentBookCategory = "";
                        filterNotifier.currentBranchBook = "";
                        filterNotifier.currentTypeOfCloth = "";
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              filterNotifier.currentProductCategory == "Note"
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
                        if (filterNotifier.currentProductCategory != "Other") {
                          filterNotifier.currentProductCategory = "Other";
                        } else {
                          filterNotifier.currentProductCategory = "";
                        }
                        filterNotifier.currentBookCategory = "";
                        filterNotifier.currentBranchBook = "";
                        filterNotifier.currentTypeOfCloth = "";
                        filterNotifier.currentBranchNote = "";
                        filterNotifier.currentYear = "";
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              filterNotifier.currentProductCategory == "Other"
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
          filterNotifier.currentProductCategory == "Book"
              ? _buildBookOptions(context)
              : Container(),
          filterNotifier.currentProductCategory == "Clothes"
              ? _buildClothOptions(context)
              : Container(),
          filterNotifier.currentProductCategory == "Note"
              ? _buildNoteOptions(context)
              : Container(),
        ],
      ),
    );
  }
}
