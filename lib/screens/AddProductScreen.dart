import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/screens/AddProductScreen_Book.dart';
import 'package:shopconn/screens/AddProductScreen_Cloth.dart';
import 'package:shopconn/screens/AddProductScreen_Note.dart';
import 'package:shopconn/screens/AddProductScreen_Other.dart';
import '../const/Theme.dart';

class AddProuctScreen extends StatefulWidget {
  AddProuctScreen({Key key}) : super(key: key);

  @override
  _AddProuctScreenState createState() => _AddProuctScreenState();
}

class _AddProuctScreenState extends State<AddProuctScreen> {
  String category= "Book";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // Book _currentBook;
  String name;
  // String category;

  // @override
  // void initState() {
  //   super.initState();
  //   BookNotifier bookNotifier = Provider.of<BookNotifier>(context, listen: false);
  //   _currentBook = Book();
  //   // if (bookNotifier.currentBook != null) {
  //   //   _currentBook = bookNotifier.currentBook;
  //   // } else {
  //   //   _currentBook = Book();
  //   // }
  //   // _imageUrl = _currentFood.image;
  // }


  Widget _buildProductNameField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Name",
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
              hintText: "eg. Boiler Suit, Algorithms",
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
                return 'Product Name is required';
              }

              if (value.length < 5 || value.length > 30) {
                return 'Product Name must be betweem 5 and 30 characters';
              }

              return null;
            },
            onChanged: (String value) {
              // _currentBook.name =value;
              // // print(value);
              setState(() {
                name=value;
              });
              print("\n****************\n");
              print(name);
              print("\n****************\n");
            },
            onSaved: (String value) {
              // _currentBook.name =value;
              // // print(value);
              setState(() {
                name=value;
              });
              print("\n****************\n");
              print(name);
              print("\n****************\n");
            },
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
  // BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    // print(category);
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Text(
                  "Whats Your Product Details ?\nfill here",
                  style: TextStyle(
                    color: sc_ItemInfoColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),

              _buildProductNameField(),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Choose Category",
                  style: TextStyle(
                    color: sc_ItemInfoColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => setState(() => category = "Book"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: category == "Book" ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
                        borderRadius: BorderRadius.all(
                            Radius.circular(13.0) 
                        ),
                      ),
                      child: Image.asset('assets/images/CatBooks.png',),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => category = "Cloth"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: category == "Cloth" ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
                        borderRadius: BorderRadius.all(
                            Radius.circular(13.0) 
                        ),
                      ),
                      child: Image.asset('assets/images/CatClothes.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => setState(() => category="Note"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: category == "Note" ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
                        borderRadius: BorderRadius.all(
                            Radius.circular(13.0) 
                        ),
                      ),
                      child: Image.asset('assets/images/CatNotes.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => category = "Other"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: category == "Other" ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
                        borderRadius: BorderRadius.all(
                            Radius.circular(13.0) 
                        ),
                      ),
                      child: Image.asset('assets/images/CatOther.png'),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20.0,
              ),
              
// TODO: FOLLOWING ACTIONS SHOULD STICK TO BOTTOM
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: sc_InputBackgroundColor,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>AddProuctScreen_Book()),
                        // );
                      },
                    ),
                    RaisedButton(
                      color: sc_PrimaryColor,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: sc_AppBarTextColor,
                          fontSize: 18.0,
                        ),                      
                      ),
                      onPressed: () {
                        if (category== "Book") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddProuctScreen_Book(name:name)),
                          );
                        }
                        else if (category == "Cloth"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddProuctScreen_Cloth()),
                          );
                        }
                        else if (category == "Note"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddProuctScreen_Note()),
                          );
                        }else if (category == "Other"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddProuctScreen_Other()),
                          );
                        }
                        
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