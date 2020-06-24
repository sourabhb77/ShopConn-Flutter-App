import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/api/uploadProduct.dart';
import 'package:shopconn/models/other.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import '../const/Theme.dart';
import 'package:image_picker/image_picker.dart';


class AddProuctScreen_Other extends StatefulWidget {
  String name;
  AddProuctScreen_Other({Key key, @required this.name}) : super(key: key);

  @override
  _AddProuctScreen_OtherState createState() => _AddProuctScreen_OtherState(name);
}

class _AddProuctScreen_OtherState extends State<AddProuctScreen_Other> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Other _currentOther;
  String name;
  String _condition ="Very Good"; //[very good, good , not bad]
  List<File> imageList= List(); //To store Path of each Images
  List<String> tagList = []; // to store tags for searching
  
  initOther()
  {
    print("Initial Constructor");
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
      _currentOther.ownerId= value.uid,
      _currentOther.postedAt=Timestamp.now(),
      _currentOther.productCategory ="Other",

    });
    print("After firebase user call");
  }

  void _SelectImage() async  //Function to keep track of all the image files that are needed to be uploaded
  {
    File image =await ImagePicker.pickImage(
      source: ImageSource.gallery
      );
      setState(() {
        imageList.add(image);
      });
    
  }

  uploadData() async
  {
    print("Upload starting");
    bool ans =await  uploadProduct(_currentOther, imageList);

    print("Upload Finisehd");
    if(ans==true)
    {
        print("\n*******Upload Status********\n");
    print("Success");
    print("\n***************\n");

    }
    else
    {
        print("\n*******book screen********\n");
        print("FAILURE");
    print("\n***************\n");
    }

  }

  addToTagList(String tag){
    tag= tag.toLowerCase();
    for (var i = 0; i < tag.length; i++) {
      for (var j = i; j < tag.length ; j++) {
        tagList.add(tag.substring(i,j+1));
      }
    }
    print(tagList);
  }

  _AddProuctScreen_OtherState(this.name){
    initOther();
  }
  @override
  void initState() {
    super.initState();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    OtherNotifier otherNotifier = Provider.of<OtherNotifier>(context, listen: false);
    _currentOther = Other();
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
                style: TextStyle(
                  fontSize: 15.0,
                  color: sc_ItemTitleColor
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0,),
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

              if (value.length <5  || value.length > 200) {
                return 'Description must be betweem 4 and 200 characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentOther.description =value;
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
          SizedBox(height: 5.0,),
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
                if (pr <0  || pr > 30000) {
                  return 'Price must be greater equal to 0';
                }
              } catch (err) {
                return 'Price must be number';
              }
              return null;
            },
            onSaved: (String value) {
              var pr = int.tryParse(value);
              _currentOther.price =pr;
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
            "Product Condition",
            style: TextStyle(
              fontSize: 16.0,
              color: sc_ItemTitleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.0,),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => setState(() => _condition = "Very Good"),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _condition == "Very Good" ? sc_InputBackgroundColor : sc_AppBarTextColor,
                      border: Border.all(
                        color: _condition == "Very Good" ? sc_PrimaryColor : sc_InputBackgroundColor,
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
                            fontWeight: _condition == "Very Good" ? FontWeight.w500 : FontWeight.normal,
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
                      color: _condition == "Good" ? sc_InputBackgroundColor : sc_AppBarTextColor,
                      border: Border.all(
                        color: _condition == "Good" ? sc_PrimaryColor : sc_InputBackgroundColor,
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
                            fontWeight: _condition == "Good" ? FontWeight.w500 : FontWeight.normal,
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
                      color: _condition == "Not Bad" ? sc_InputBackgroundColor : sc_AppBarTextColor,
                      border: Border.all(
                        color: _condition == "Not Bad" ? sc_PrimaryColor : sc_InputBackgroundColor,
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
                            fontWeight: _condition == "Not Bad" ? FontWeight.w500 : FontWeight.normal,
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

 
 

  @override
  Widget build(BuildContext context) {
    print("\n*******other screen********\n");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
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
              child: Text('Cancel',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
              ),
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
                borderRadius: BorderRadius.circular(8.0)
              ),
              onPressed: () {
                _currentOther.name=name;
                addToTagList(_currentOther.name);
                _currentOther.condition = _condition;
                _currentOther.tagList = tagList;
                if (!_formkey.currentState.validate()) {
                  print("Errororororororo");
                } else { // No Error upload all the details to the database!!
                  _formkey.currentState.save();
                  uploadData();
                  print(_currentOther.toMap());
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

              SizedBox(height: 15.0,),
              _buildCondition(),
              _buildDescriptionField(),
              _buildPriceField(),

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
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                padding: EdgeInsets.fromLTRB(15,0,15,0),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                // mainAxisSpacing: 2,
                
                children: List.generate(imageList.length, (index) {
                  return Container(
                    child: Image(image:FileImage(imageList[index]))
                    ,);
                })
              ),
            ],
          ),
        ),
      ),
    );
  }
}