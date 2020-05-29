import 'dart:js';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/notifier/clothes_notifier.dart';
import 'package:shopconn/screens/AddProductScreen_Book.dart';
import 'package:shopconn/screens/AddProductScreen_Cloth.dart';
import 'package:shopconn/screens/AddProductScreen_Note.dart';
import 'package:shopconn/screens/AddProductScreen_Other.dart';
import 'package:shopconn/const/Theme.dart';
// import 'package:shopconn/services/database.dart';

class AddProuctScreen extends StatefulWidget {
  AddProuctScreen({Key key}) : super(key: key);

  @override
  _AddProuctScreenState createState() => _AddProuctScreenState();
}

class _AddProuctScreenState extends State<AddProuctScreen> {
  int _value=0;
  @override
  Widget build(BuildContext context) {
    ClothesNotifier clothesNotifier=Provider.of<ClothesNotifier>(context);
    // print(_value);
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
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Text(
                "Whats Your Product Details ?\nfill here",
                style: TextStyle(
                  color: sc_ItemInfoColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              color: sc_InputBackgroundColor,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.print,
                    color: sc_ItemTitleColor,
                  ),
                  hintText: "Product Name",
                  hintStyle: TextStyle(
                    color: sc_InputHintTextColor,
                    fontSize: 16.0,
                  ),
                  enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: sc_InputHintTextColor, width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Choose Category",
                style: TextStyle(
                  color: sc_ItemInfoColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
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
                  onTap: () => setState(() => _value = 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: _value == 0 ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
                      borderRadius: BorderRadius.all(
                          Radius.circular(13.0) 
                      ),
                    ),
                    child: Image.asset('assets/images/CatBooks.png',),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _value = 1),
                  child: Container(
                    decoration: BoxDecoration(
                      border: _value == 1 ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
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
                  onTap: () => setState(() => _value = 2),
                  child: Container(
                    decoration: BoxDecoration(
                      border: _value == 2 ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
                      borderRadius: BorderRadius.all(
                          Radius.circular(13.0) 
                      ),
                    ),
                    child: Image.asset('assets/images/CatNotes.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _value = 3),
                  child: Container(
                    decoration: BoxDecoration(
                      border: _value == 3 ? Border.all(color: sc_PrimaryColor ,width: 5.0,) : null,
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
                      clothesNotifier.currentClothes=null;
                      if (_value== 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProuctScreen_Book()),
                        );
                      }
                      else if (_value == 1){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProuctScreen_Cloth()),
                        );
                      }
                      else if (_value == 2){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProuctScreen_Note()),
                        );
                      }else if (_value == 3){
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
    );
  }
}