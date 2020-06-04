import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import '../const/Theme.dart';
import 'package:image_picker/image_picker.dart';


enum BookType { edu, nonedu }

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
  List authorList = [];
  BookType _bookType =BookType.edu;
  String _branch = 'IT';
  // List newList = List.from(authorList);
  TextEditingController authorListController = new TextEditingController();
  List<File> imageList= List(); //To store Path of each Images
  
  void _SelectImage() async  //Function to keep track of all the image files that are needed to be uploaded
  {
    File image =await ImagePicker.pickImage(
      source: ImageSource.gallery
      );
      setState(() {
        imageList.add(image);
      });
    
  }

  _AddProuctScreen_BookState(this.name);
  @override
  void initState() {
    super.initState();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context, listen: false);
    _currentBook = Book();
    _currentBook.branch = _branch;
    // dynamic uid = getCurrentUser(authNotifier);
    // if (bookNotifier.currentBook != null) {
    //   _currentBook = bookNotifier.currentBook;
    // } else {
    //   _currentBook = Book();
    // }
    // _imageUrl = _currentFood.image;
  }

  Widget _buildAuthorNameField() {
    return SizedBox(
      width: 230,
      child: TextField(
        controller: authorListController,
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Author Name",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
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
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Edition",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Edition is required';
          }
          var edi = int.parse(value);
          if (edi <1  || edi > 10) {
            return 'Edition must be betweem 1 and 10';
          }

          return null;
        },
        onSaved: (String value) {
          var edi = int.parse(value);
          _currentBook.edition =edi;
          print(edi);
        },
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        maxLines: 5,
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Description",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
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
    );
  }

  Widget _buildPriceField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Price",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Price is required';
          }
          var pr = int.parse(value);
          if (pr <0  || pr > 30000) {
            return 'Price must be greater equal to 0';
          }

          return null;
        },
        onSaved: (String value) {
          var pr = int.parse(value);
          _currentBook.price =pr;
          print(pr);
        },
      ),
    );
  }

  Widget _buildBookCategory() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Educational'),
          leading: Radio(
            value: BookType.edu,
            groupValue: _bookType,
            onChanged: (BookType value) {
              setState(() {
                _bookType = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Not Educational'),
          leading: Radio(
            value: BookType.nonedu,
            groupValue: _bookType,
            onChanged: (BookType value) {
              setState(() {
                _bookType = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPublication() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        // maxLines: 5,
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Publication",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
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
    );
  }

  Widget _buildCondition() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        // maxLines: 5,
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Condition",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Condition is required';
          }

          if (value.length <5  || value.length > 100) {
            return 'Condition must be betweem 4 and 100 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _currentBook.condition =value;
          print(value);
        },
      ),
    );
  }

  Widget _buildSubject() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        // maxLines: 5,
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Subject",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Subject is required';
          }

          if (value.length <5  || value.length > 100) {
            return 'Subject must be betweem 4 and 100 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _currentBook.subject =value;
          print(value);
        },
      ),
    );
  }

  Widget _buildBranch() {
    return DropdownButton<String>(
      value: _branch,
      // icon: Icon(Icons.arrow_downward),    
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: sc_ItemTitleColor),
      underline: Container(
        height: 3,
        color: sc_PrimaryColor,
      ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    _currentBook.name=name;
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
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //    onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          autovalidate: true,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Text(
                  "You Are Almost Done !!!!!!",
                  style: TextStyle(
                    color: sc_ItemInfoColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
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
                    ),
                  ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 1.0, 20.0, 1.0),
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
                          icon: Icon(Icons.clear),
                          tooltip: 'delete',
                          iconSize: 30,
                          onPressed: () {
                           authorList.remove(authorName);
                          //  authorList.reload
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),


              _buildEditionField(),
              _buildPublication(),
              _buildCondition(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildBranch(),
              ),
              _buildSubject(),
              _buildDescriptionField(),
              _buildPriceField(),
              _buildBookCategory(),

              SizedBox(
                height: 30.0,
              ),

              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: sc_InputBackgroundColor,
                  child: Text('Choose Photo'),
                  onPressed: () {
                    _SelectImage();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
                    // );
                  },
                ),
                // Column(
                //   children: <Widget> [
                //     Text("image1.jpeg"),
                //     Text("image2.jpeg"),
                //     Text("image3.jpeg"),
                //     Text("image4.jpeg"),
                //   ],
                // )
                
              ],
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