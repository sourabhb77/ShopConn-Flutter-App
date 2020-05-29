import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/clothes.dart';
import 'package:shopconn/notifier/clothes_notifier.dart';
import 'dart:js';

class AddProuctScreen_Cloth extends StatefulWidget {
  AddProuctScreen_Cloth({Key key}) : super(key: key);

  @override
  _AddProuctScreen_ClothState createState() => _AddProuctScreen_ClothState();
}

class _AddProuctScreen_ClothState extends State<AddProuctScreen_Cloth> {

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  List _imgList =[];
  Clothes _currentClothes;

  @override
  void initState() {
    super.initState();
    ClothesNotifier clothesNotifier =Provider.of<ClothesNotifier>(context);
    if(clothesNotifier!=null)
    {
      _currentClothes=clothesNotifier.currentClothes;
    }
    else
    {
      _currentClothes=new Clothes();
    }
  }

_saveClothes(context)
{
 if(!_formKey.currentState.validate())
 {
   return;
 }

 _formKey.currentState.save();
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
        child:Form(
          key:_formKey,
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

            // -----------------Size Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
                initialValue: _currentClothes.size,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.print,
                    color: sc_ItemTitleColor,
                  ),
                  hintText: "Size",
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
                validator: (val){
                  if(val.isEmpty)
                  {
                    return "Size is Required.";
                  }
                  // if(val is String)
                  // {
                  //   return "Size should be in integer";
                  // }
                  return null;
              },
              onSaved:(String val){
                _currentClothes.size=val;
              },
              ),
            ),
            // -----------------size ends here-----------------//

             // -----------------Description Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
                maxLines: 5,
                initialValue: _currentClothes.description,
                decoration: InputDecoration(
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
                    borderSide: BorderSide(color: sc_InputHintTextColor, width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                ),
                validator: (val){
                  if(val.isEmpty)
                  {
                    return "Description is required";
                  }
                  if(val.length<50){
                    return "Description should not be less than 50 words";
                  }
                  return null;
                },
                onSaved:(val){ 
                  _currentClothes.description=val;
                  }
              ),
            ),
            // -----------------Description ends here-----------------//

             // -----------------Price Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
                initialValue: _currentClothes.price,
                decoration: InputDecoration(
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
                    borderSide: BorderSide(color: sc_InputHintTextColor, width: 3.0),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                ),
                validator: (val){
                  // if(val is String){
                  //   return "Price should be in number";
                  // }
                  if(val.isEmpty)
                  {
                    return "Price field is empty.";
                  }
                },
                onSaved:(val)
                {
                  _currentClothes.price=val;
                },
              ),
            ),
            // -----------------Price ends here-----------------//

            SizedBox(
              height: 30.0,
            ),

           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: sc_InputBackgroundColor,
                  child: Text('Choose Photo'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
                    // );
                  },
                ),
                Column(
                  children: <Widget> [
                    Text("image1.jpeg"),
                    Text("image2.jpeg"),
                    Text("image3.jpeg"),
                    Text("image4.jpeg"),
                  ],
                )
                
              ],
            ),
            SizedBox(
              height: 30.0,
            ),


// TODO: FOLLOWING ACTIONS SHOULD STICK TO BOTTOM

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      _saveClothes(context);
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