import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/api/uploadProduct.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import '../const/Theme.dart';
import 'package:image_picker/image_picker.dart';


class AddProuctScreen_Book extends StatefulWidget {
  String name;
  AddProuctScreen_Book({Key key, @required this.name}) : super(key: key);

  @override
  _AddProuctScreen_BookState createState() => _AddProuctScreen_BookState(name);
}

class _AddProuctScreen_BookState extends State<AddProuctScreen_Book> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Book _currentBook;
  String name;
  List<String> authorList = [];
  String _branch = 'IT';
  String _bookCat = "Educational";
  String _condition ="Very Good"; //[very good, good , not bad]
  // List newList = List.from(authorList);
  TextEditingController authorListController = new TextEditingController();
  List<File> imageList= List(); //To store Path of each Images
  

  initBook()
  {
    print("Initial Constructor");
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
      _currentBook.ownerId= value.uid,
      _currentBook.postedAt=Timestamp.now(),
      _currentBook.productCategory ="Book",

    });
    print("After firebase user call");
  }

  
  void _SelectImage() async //Function to keep track of all the image files that are needed to be uploaded
  {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(image);
    });
  }

  uploadData() async
  {
    print("Upload starting");
    bool ans =await  uploadProduct(_currentBook, imageList);

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


  _AddProuctScreen_BookState(this.name)
  {
    initBook();
  }

  

  // _AddProuctScreen_BookState(this.name);


  @override
  void initState() {
    super.initState();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    BookNotifier bookNotifier =
        Provider.of<BookNotifier>(context, listen: false);
    _currentBook = Book();
    _currentBook.branch = _branch;    
  }

  Widget _buildAuthorNameField() {
    return SizedBox(
      width: 230,
      child: TextField(
        controller: authorListController,
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.all(15),
          hintText: "Forouzan",
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
      ),
    );
  }

  _add_authorIntoList(String text){
    if (text.isNotEmpty) {
      setState(() {
        authorList.add(text);
      });
      print(authorList);
      authorListController.clear();
    }
  }


  Widget _buildEditionField() {
    return Container(
      width: 230.0,
      // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Edition",
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
              hintText: "Edition",
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
                return 'Edition is required';
              }
              try {
                var edi = int.tryParse(value);
                if (edi <1  || edi > 10) {
                  return 'Edition must be betweem 1 and 10';
                }
              } catch (err) {
                return 'Edition must be number';
              }
              return null;
            },
            onSaved: (String value) {
              var edi = int.tryParse(value);
              _currentBook.edition =edi;
              print(edi);
            },
          ),
        ],
      ),
    );
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
              _currentBook.description =value;
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
              _currentBook.price =pr;
              print(pr);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPublication() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Publication",
            style: TextStyle(
              fontSize: 16.0,
              color: sc_ItemTitleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.0,),
          TextFormField(
            // maxLines: 5,
            decoration: InputDecoration(
              fillColor: sc_InputBackgroundColor,
              filled: true,
              isDense: true,
              contentPadding: EdgeInsets.all(15),
              hintText: "McGrawHill Educarion",
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
                return 'Publication is required';
              }

              if (value.length <5  || value.length > 100) {
                return 'Publication must be betweem 4 and 100 characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentBook.publication =value;
              print(value);
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
            "Book Condition",
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
          SizedBox(height: 5.0,),
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

              if (value.length <2  || value.length > 100) {
                return 'Subject must be betweem 2 and 100 characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentBook.subject =value;
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
          SizedBox(height: 5.0,),
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
                  _currentBook.branch= newValue;
                });
              },
              items: <String>['IT', 'CS', 'ETRX', 'EXTC','MECH']
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

  Widget _buildBookCategory() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Book Category",
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
                flex: 3,
                child: GestureDetector(
                  onTap: () => setState(() => _bookCat = "Educational"),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _bookCat == "Educational" ? sc_InputBackgroundColor : sc_AppBarTextColor,
                      border: Border.all(
                        color: _bookCat == "Educational" ? sc_PrimaryColor : sc_InputBackgroundColor,
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
                            fontWeight: _bookCat == "Educational" ? FontWeight.w500 : FontWeight.normal,
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
                  onTap: () => setState(() => _bookCat = "NonEducational"),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _bookCat == "NonEducational" ? sc_InputBackgroundColor : sc_AppBarTextColor,
                      border: Border.all(
                        color: _bookCat == "NonEducational" ? sc_PrimaryColor : sc_InputBackgroundColor,
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
                            fontWeight: _bookCat == "NonEducational" ? FontWeight.w500 : FontWeight.normal,
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
    _currentBook.name = name;
    print("\n*******book screen********\n");
    print(_currentBook.name);
    print("\n***************\n");
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

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Author Name",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: sc_ItemTitleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      _buildAuthorNameField(),
                      ButtonTheme(
                        // minWidth: 260,
                        child: RaisedButton(
                          color: sc_PrimaryColor,
                          padding: EdgeInsets.all(13.0),
                          onPressed: () => _add_authorIntoList(authorListController.text),
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 18, color: sc_AppBarTextColor),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                          ),
                        ),
                      ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 1.0, 20.0, 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: authorList.map((authorName){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '$authorName',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemInfoColor,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear,color: Colors.red,),
                          tooltip: 'delete',
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              authorList.remove(authorName);
                            });
                          //  authorList.reload
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildEditionField(),
                    _buildBranch(),
                  ],
                ),
              ),
              _buildPublication(),
              _buildBookCategory(),
              _buildSubject(),
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

// TODO: FOLLOWING ACTIONS SHOULD STICK TO BOTTOM
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: sc_InputBackgroundColor,
                      child: Text('Cancel',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
                        // );
                      },
                    ),
                    RaisedButton(
                      color: sc_PrimaryColor,
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: sc_AppBarTextColor,
                          fontSize: 18.0,
                        ),                      
                      ),
                      onPressed: () {
                        _currentBook.authorList = authorList;
                        _currentBook.bookCategory = _bookCat;
                        _currentBook.condition = _condition;
                        if (!_formkey.currentState.validate()) {
                          print("Errororororororo");
                        } else { // No Error upload all the details to the database!!
                          _formkey.currentState.save();
                          uploadData();
                          print(_currentBook.toMap());
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
              
              
            ],
          ),
        ),
      ),
    );
  }
}
