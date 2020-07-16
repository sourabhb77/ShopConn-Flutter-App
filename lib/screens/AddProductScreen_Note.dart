import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/api/uploadProduct.dart';
import 'package:shopconn/models/note.dart';
import '../const/Theme.dart';
import 'package:image_picker/image_picker.dart';

import 'AfterProductScreen.dart';

class AddProuctScreen_Note extends StatefulWidget {
  String name;
  AddProuctScreen_Note({Key key, @required this.name}) : super(key: key);

  @override
  _AddProuctScreen_NoteState createState() => _AddProuctScreen_NoteState(name);
}

class _AddProuctScreen_NoteState extends State<AddProuctScreen_Note> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Note _currentNote;
  String name;
  String _branch = 'IT';
  String _year = "FY";
  String _condition = "Very Good"; //[very good, good , not bad]
  List<File> imageList = List(); //To store Path of each Images
  List<String> tagList = [];
  String category; // to store tags for searching

  initNote() {
    print("Initial Constructor");
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
          _currentNote.ownerId = value.uid,
          _currentNote.postedAt = Timestamp.now(),
          _currentNote.productCategory = "Note",
        });
    print("After firebase user call");
  }

  void
      _SelectImage() async //Function to keep track of all the image files that are needed to be uploaded
  {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imageList.add(image);
        });
      }
    } catch (e) {
      print("got error $e");
    }
  }

  uploadData() async {
    print("Upload starting");
    bool ans = await uploadProduct(_currentNote, imageList);

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

  void _deleteImage({int index}) {
    setState(() {
      imageList.remove(imageList[index]);
    });
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

  _AddProuctScreen_NoteState(this.name) {
    initNote();
  }
  @override
  void initState() {
    super.initState();
    _currentNote = Note();
    _currentNote.branch = _branch;
    _currentNote.year = _year;
    _currentNote.buyerId = "";
  }

  Widget _buildDescriptionField() {
    return Container(
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
                style: TextStyle(fontSize: 15.0, color: sc_ItemTitleColor),
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
              hintText: "This book is good for something .....",
              hintStyle: TextStyle(
                color: sc_InputHintTextColor,
                fontSize: 16.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: sc_InputBackgroundColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            keyboardType: TextInputType.text,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Description is required';
              }

              if (value.length < 5 || value.length > 200) {
                return 'Description must be betweem 4 and 200 characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentNote.description = value;
              print(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceField() {
    return Container(
      width: 150.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                padding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 10.0),
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
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: sc_InputBackgroundColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            keyboardType: TextInputType.number,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Price is required';
              }
              try {
                var pr = int.tryParse(value);
                if (pr < 0 || pr > 30000) {
                  return 'Price must be greater equal to 0';
                }
              } catch (err) {
                return 'Price must be number';
              }
              return null;
            },
            onSaved: (String value) {
              var pr = int.tryParse(value);
              _currentNote.price = pr;
              print(pr);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCondition() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notes Condition",
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
                  onTap: () => setState(() => _condition = "Very Good"),
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
    );
  }

  Widget _buildSubject() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subject",
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
              hintText: "Advanced Algorithms",
              hintStyle: TextStyle(
                color: sc_InputHintTextColor,
                fontSize: 16.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: sc_InputBackgroundColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            keyboardType: TextInputType.text,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Subject is required';
              }

              if (value.length < 2 || value.length > 100) {
                return 'Subject must be betweem 2 and 100 characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentNote.subject = value;
              addToTagList(_currentNote.subject);
              print(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Faculty Name",
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
              hintText: "Mr. A. B. Cajasc",
              hintStyle: TextStyle(
                color: sc_InputHintTextColor,
                fontSize: 16.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: sc_InputBackgroundColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: sc_InputBackgroundColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            keyboardType: TextInputType.text,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Faculty Name is required';
              }

              if (value.length < 2 || value.length > 100) {
                return 'Faculty Name must be betweem 2 and 100 characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentNote.facultyName = value;
              print(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBranch() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Branch",
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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: DropdownButton<String>(
              value: _branch,
              // icon: Icon(Icons.arrow_downward),
              iconSize: 30,
              // elevation: 16,
              style: TextStyle(color: sc_ItemTitleColor),
              onChanged: (String newValue) {
                setState(() {
                  _branch = newValue;
                  _currentNote.branch = _branch;
                });
              },
              items: <String>['IT', 'CS', 'ETRX', 'EXTC', 'MECH']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearField() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Year",
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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: DropdownButton<String>(
              value: _year,
              // icon: Icon(Icons.arrow_downward),
              iconSize: 30,
              // elevation: 16,
              style: TextStyle(color: sc_ItemTitleColor),
              onChanged: (String newValue) {
                setState(() {
                  _year = newValue;
                  _currentNote.year = newValue;
                });
              },
              items: <String>["FY", "SY", "TY", "LY"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("\n*******note screen********\n");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Your Notes",
          style: TextStyle(
            color: sc_AppBarTextColor,
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
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
                if (imageList.length < 1) {
                  _showMyDialog();
                } else {
                  _currentNote.name = name;
                  addToTagList(_currentNote.name);
                  tagList.add(_currentNote.year.toLowerCase());
                  tagList.add(_currentNote.branch.toLowerCase());
                  _currentNote.condition = _condition;
                  _currentNote.tagList = tagList;
                  if (!_formkey.currentState.validate()) {
                    print("Errororororororo");
                  } else {
                    // No Error upload all the details to the database!!
                    _formkey.currentState.save();
                    uploadData();
                    print(_currentNote.toMap());
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AfterProductScreen(
                          category: _currentNote.productCategory,
                        ),
                      ),
                      (route) => route.isFirst,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              //   child: Text(
              //     "You Are Almost Done !!!!!!",
              //     style: TextStyle(
              //       color: sc_ItemInfoColor,
              //       fontWeight: FontWeight.w500,
              //       fontSize: 16.0,
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 15.0,
              ),

              _buildSubject(),
              _buildFacultyName(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildYearField(),
                    _buildBranch(),
                  ],
                ),
              ),
              // _buildPublication(),
              // _buildBookCategory(),
              _buildCondition(),
              _buildDescriptionField(),
              _buildPriceField(),

              // SizedBox(
              //   height: 30.0,
              // ),

              GestureDetector(
                onTap: () {
                  _SelectImage();
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
                height: 5.0,
              ),
              GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 2,

                  children: List.generate(imageList.length, (index) {
                    return Stack(children: [
                      Container(
                        child: Image(
                          image: FileImage(imageList[index]),
                          height: 300,
                          width: 150,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 30.0,
                          ),
                          onPressed: () {
                            _deleteImage(index: index);
                          },
                        ),
                      ),
                    ]);
                  })),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Photo not uploaded.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You cannot post without uploading a image.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
