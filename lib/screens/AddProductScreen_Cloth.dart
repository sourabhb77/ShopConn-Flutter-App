import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/uploadProduct.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/clothes.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:shopconn/screens/SavedProductScreen.dart';

import '../api/shopconnApi.dart';

class AddProuctScreen_Cloth extends StatefulWidget {
  String name;
  AddProuctScreen_Cloth({Key key, @required this.name}) : super(key: key);

  @override
  _AddProuctScreen_ClothState createState() =>
      _AddProuctScreen_ClothState(name);
}

class _AddProuctScreen_ClothState extends State<AddProuctScreen_Cloth> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Clothes _currentClothes;
  String _description = "Clothes to sell";
  int _size = 34;
  String name;
  int _price = 750;
  List<String> _typeslist = ['Boiler Suit', 'Labcoat'];
  String _type;
  String _condition = "good";
  TextEditingController authorListController = new TextEditingController();
  List<File> imageList = List();
  List<String> tagList = []; // to store tags for searching

  initClothes() {
    print("Initial Constructor");
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
          _currentClothes.ownerId = value.uid,
          _currentClothes.postedAt = Timestamp.now(),
          _currentClothes.productCategory = "Clothes",
        });
    print("After firebase user call");
  }

  void
      _SelectClothesImage() async //Function to keep track of all the image files that are needed to be uploaded
  {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(image);
    });
  }

  saveClothes() async {
    print("Uploading data");
    bool ans = await uploadProduct(_currentClothes, imageList);
    print("Upload Finisehd");
    if (ans == true) {
      print("\n*******Upload Status********\n");
      print("Success");
      print("\n***************\n");
    } else {
      print("\n*******book screen********\n");
      print("FAILURE");
      print("\n***************\n");
    }
  }

  addToTagList(String tag) {
    tag = tag.toLowerCase();
    for (var i = 0; i < tag.length; i++) {
      for (var j = i; j < tag.length; j++) {
        tagList.add(tag.substring(i, j + 1));
      }
    }
    print(tagList);
  }

  _AddProuctScreen_ClothState(this.name) {
    initClothes();
  }
  @override
  void initState() {
    super.initState();
    ClothesNotifier clothesNotifier =
        Provider.of<ClothesNotifier>(context, listen: false);
    _currentClothes = Clothes();
    _currentClothes.size = _size;
    _currentClothes.description = _description;
    _currentClothes.price = _price;
    _currentClothes.condition = _condition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(
            color: sc_AppBarTextColor,
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Text(
                  "You Are Almost Done !!!!!!",
                  style: TextStyle(
                    color: sc_ItemInfoColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),

              // -----------------Size Starts here-----------------//
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Size",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                        fillColor: sc_InputBackgroundColor,
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.all(15),
                        hintText: "36",
                        hintStyle: TextStyle(
                          color: sc_InputHintTextColor,
                          fontSize: 16.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(color: sc_InputBackgroundColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: sc_InputBackgroundColor),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: sc_InputBackgroundColor),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Size is Required.";
                        }
                        // if(val is String)
                        // {
                        //   return "Size should be in integer";
                        // }
                        return null;
                      },
                      onSaved: (String val) {
                        _currentClothes.size = int.parse(val);
                      },
                    ),
                  ],
                ),
              ),
              // -----------------size ends here-----------------//

              //..............Description start here.......................//

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "optional",
                            style: TextStyle(
                                fontSize: 15.0, color: sc_ItemTitleColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          fillColor: sc_InputBackgroundColor,
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: "This product is good for something .....",
                          hintStyle: TextStyle(
                            color: sc_InputHintTextColor,
                            fontSize: 16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: sc_InputBackgroundColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: sc_InputBackgroundColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: sc_InputBackgroundColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (String val) {
                          if (val.isEmpty) {
                            return "Description field is Empty.";
                          } else if (val.length < 20 || val.length > 50) {
                            return "Description should between 20 to 50 word";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _currentClothes.description = val;
                        },
                      ),
                    ]),
              ),
              //..............Description end here.......................//

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // -----------------Price Starts here-----------------//
                  Expanded(
                    child: Container(
                      width: 150.0,
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              fillColor: sc_InputBackgroundColor,
                              filled: true,
                              isDense: true,
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 12.0, 10.0, 10.0),
                                child: Text(
                                  "Rs",
                                  style: TextStyle(
                                    color: sc_ItemTitleColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              hintText: "200",
                              hintStyle: TextStyle(
                                color: sc_InputHintTextColor,
                                fontSize: 16.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: sc_InputBackgroundColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: sc_InputBackgroundColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: sc_InputBackgroundColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              // if(val is String){
                              //   return "Price should be in number";
                              // }
                              if (val.isEmpty) {
                                return "Price field is empty.";
                              }
                            },
                            onSaved: (val) {
                              _currentClothes.price = int.parse(val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // -----------------Price ends here-----------------//

                  //...................clothtype start here.............//

                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cloth type",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: sc_ItemTitleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: sc_InputBackgroundColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButton<String>(
                                // icon: Icon(Icons.arrow_downward),
                                iconSize: 30,
                                // elevation: 16,
                                style: TextStyle(color: sc_ItemTitleColor),
                                hint: Text(
                                  'Cloth type',
                                  style: TextStyle(
                                    color: sc_InputHintTextColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                value: _type,
                                items: _typeslist.map((type) {
                                  return DropdownMenuItem(
                                    child: new Text(type),
                                    value: type,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _type = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //...................clothtype end here.............////
                ],
              ),

              // -----------------Condition Starts here-----------------//
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cloth Condition",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _condition = "Very Good"),
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
                            onTap: () => setState(() => _condition = "Good"),
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
                            onTap: () => setState(() => _condition = "Not Bad"),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _condition == "Not Bad"
                                    ? sc_InputBackgroundColor
                                    : sc_AppBarTextColor,
                                border: Border.all(
                                  color: _condition == "Not Bad"
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
                                      fontWeight: _condition == "Not Bad"
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
                    )
                  ],
                ),
              ),
              // -----------------Condition ends here-----------------//
              //type ends here//
              SizedBox(
                height: 30.0,
              ),

              GestureDetector(
                onTap: () {
                  _SelectClothesImage();
                },
                child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: sc_InputBackgroundColor,
                    border: Border.all(
                      color: sc_PrimaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Choose Photo",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: sc_ItemTitleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 2,

                  children: List.generate(imageList.length, (index) {
                    return Container(
                      child: Image(image: FileImage(imageList[index])),
                    );
                  })),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            OutlineButton(
              padding: EdgeInsets.all(13.0),
              color: sc_InputBackgroundColor,
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              color: sc_PrimaryColor,
              padding: EdgeInsets.all(13.0),
              child: Text(
                'Post',
                style: TextStyle(
                  color: sc_AppBarTextColor,
                  fontSize: 18.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                _currentClothes.type = _type;
                tagList.add(_currentClothes.type.toLowerCase());
                _currentClothes.name = name;
                addToTagList(_currentClothes.name);
                _currentClothes.tagList = tagList;
                if (!_formKey.currentState.validate()) {
                  print("Errorrr");
                } else {
                  _formKey.currentState.save();
                  saveClothes();
                }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
