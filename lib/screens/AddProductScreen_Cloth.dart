import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/clothes_api.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/clothes.dart';
import 'package:shopconn/notifier/clothesNotifier.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../api/shopconnApi.dart';



class AddProuctScreen_Cloth extends StatefulWidget {
  String name;
  AddProuctScreen_Cloth({Key key,@required this.name}) : super(key: key);

  @override
  _AddProuctScreen_ClothState createState() => _AddProuctScreen_ClothState(name);
}

class _AddProuctScreen_ClothState extends State<AddProuctScreen_Cloth> {

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  Clothes _currentClothes;
  String _description="Clothes to sell";
  // String type="boiler suit";
  String _size="34";
  String name;
  String _price="750";
  List <String> _typeslist=['Boiler suit ','Labcoat'];
  String _type;
  TextEditingController authorListController = new TextEditingController();
  List<File> imageList= List(); 

  initClothes()
  {
    print("Initial Constructor");
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
      _currentClothes.ownerId= value.uid,
      _currentClothes.postedAt=Timestamp.now(),
      _currentClothes.productCategory ="Clothes",

    });
    print("After firebase user call");
  }

    void _SelectClothesImage() async  //Function to keep track of all the image files that are needed to be uploaded
  {
    File image =await ImagePicker.pickImage(
      source: ImageSource.gallery
      );
      setState(() {
        imageList.add(image);
      });
    
  }

  saveClothes()async
{
 print("Uploading data");
 bool ans=await uploadClothesDetails(_currentClothes, imageList);
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

_AddProuctScreen_ClothState(this.name)
{
  initClothes();
}
  @override
  void initState() {
    super.initState();
    ClothesNotifier clothesNotifier =Provider.of<ClothesNotifier>(context,listen:false);
    _currentClothes=Clothes();
    _currentClothes.size= int.parse(_size);
    _currentClothes.description=_description;
    
    _currentClothes.price=int.parse(_price);
  }
  @override
  Widget build(BuildContext context) {
    _currentClothes.name=name;
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
                // initialValue: _currentClothes.size,
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
                keyboardType: TextInputType.number,
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
                _currentClothes.size=int.parse(val);
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
                // initialValue: _currentClothes.description,
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
                keyboardType: TextInputType.text,
                validator: (String val){
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
                // initialValue: _currentClothes.price,
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
                keyboardType: TextInputType.number,
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
                  _currentClothes.price=int.parse(val);
                },
              ),
            ),
            // -----------------Price ends here-----------------//

Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: 
               DropdownButtonFormField(
                  decoration: const InputDecoration(
                   border: const OutlineInputBorder(),
                    ),
               hint:Text('Cloth type'),
               value: _type,
               items: _typeslist.map((type){
                 return DropdownMenuItem(
                child: new Text(type),
                value: type,
              );
               }).toList(), 
               onChanged: (newValue){
                 setState((){
                 _type=newValue;
               });},
            ),),
            //type ends here//
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
                    _SelectClothesImage();
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
                      if(!_formKey.currentState.validate())
                      {
                         print("Errorrr");
                      }
                      else{
                         _formKey.currentState.save();
                          saveClothes();
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