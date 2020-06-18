// import 'package:flutter/material.dart';
// import '../const/Theme.dart';

// class AddProuctScreen_Other extends StatefulWidget {
//   AddProuctScreen_Other({Key key}) : super(key: key);

//   @override
//   _AddProuctScreen_OtherState createState() => _AddProuctScreen_OtherState();
// }

// class _AddProuctScreen_OtherState extends State<AddProuctScreen_Other> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Add Product",
//           style: TextStyle(
//             color: sc_AppBarTextColor,
//           ),
//         ),
//         backgroundColor: sc_AppBarBackgroundColor,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//            onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//               child: Text(
//                 "You Are Almost Done !!!!!!",
//                 style: TextStyle(
//                   color: sc_ItemInfoColor,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),

//              // -----------------Description Starts here-----------------//
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//               color: sc_InputBackgroundColor,
//               child: TextField(
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(
//                     Icons.print,
//                     color: sc_ItemTitleColor,
//                   ),
//                   hintText: "Description",
//                   hintStyle: TextStyle(
//                     color: sc_InputHintTextColor,
//                     fontSize: 16.0,
//                   ),
//                   enabledBorder: UnderlineInputBorder(      
//                     borderSide: BorderSide(color: sc_InputHintTextColor, width: 3.0),   
//                   ),  
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
//                   ),
//                   border: UnderlineInputBorder(
//                     borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
//                   ),
//                 ),
//               ),
//             ),
//             // -----------------Description ends here-----------------//

//              // -----------------Price Starts here-----------------//
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//               color: sc_InputBackgroundColor,
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(
//                     Icons.print,
//                     color: sc_ItemTitleColor,
//                   ),
//                   hintText: "Price",
//                   hintStyle: TextStyle(
//                     color: sc_InputHintTextColor,
//                     fontSize: 16.0,
//                   ),
//                   enabledBorder: UnderlineInputBorder(      
//                     borderSide: BorderSide(color: sc_InputHintTextColor, width: 3.0),   
//                   ),  
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
//                   ),
//                   border: UnderlineInputBorder(
//                     borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
//                   ),
//                 ),
//               ),
//             ),
//             // -----------------Price ends here-----------------//

//             SizedBox(
//               height: 30.0,
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 RaisedButton(
//                   color: sc_InputBackgroundColor,
//                   child: Text('Choose Photo'),
//                   onPressed: () {
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
//                     // );
//                   },
//                 ),
//                 Column(
//                   children: <Widget> [
//                     Text("image1.jpeg"),
//                     Text("image2.jpeg"),
//                     Text("image3.jpeg"),
//                     Text("image4.jpeg"),
//                   ],
//                 )
                
//               ],
//             ),

//             SizedBox(
//               height: 30.0,
//             ),

// // TODO: FOLLOWING ACTIONS SHOULD STICK TO BOTTOM
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   RaisedButton(
//                     color: sc_InputBackgroundColor,
//                     child: Text('Cancel',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                       ),
//                     ),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
//                       // );
//                     },
//                   ),
//                   RaisedButton(
//                     color: sc_PrimaryColor,
//                     child: Text(
//                       'Post',
//                       style: TextStyle(
//                         color: sc_AppBarTextColor,
//                         fontSize: 18.0,
//                       ),                      
//                     ),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => SavedProductScreen()),
//                       // );
//                     },
//                   ),
                  
//                 ],
//               ),
//             ),
            
            
//           ],
//         ),
//       ),
//     );
//   }
// }










import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/clothes_api.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/models/other.dart';
import 'package:shopconn/notifier/otherNotifier.dart';
import '../const/Theme.dart';
import 'package:shopconn/api/otherApi.dart';

class AddProuctScreen_Other extends StatefulWidget {
  String name;
  AddProuctScreen_Other({Key key,@required this.name}) : super(key: key);

  @override
  _AddProuctScreen_OtherState createState() => _AddProuctScreen_OtherState(name);
}

class _AddProuctScreen_OtherState extends State<AddProuctScreen_Other> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Other _currentOther;
  List<File> imageList=List();
  String name;
  String _description="Product to sell";
  int _price=250;
  String _condition="good";
  
  initOther(){
     print("Initial Constructor");
    Future<FirebaseUser> user =getCurrendFirebaseUser();
    user.then((value) => {
      _currentOther.ownerId=value.uid,
      _currentOther.postedAt=Timestamp.now(),
      _currentOther.productCategory="Other",
    }
    );
    print("After firebase user call");
  }


void _SelectOtherImages() async {
    File image=await ImagePicker.pickImage(
      source: ImageSource.gallery);
      setState(() {
        imageList.add(image);
      });
  }

  saveOther()async
{
 print("Uploading data");
 bool ans=await uploadClothesDetails(_currentOther, imageList);
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
  
_AddProuctScreen_OtherState(this.name)
{
  initOther();
}
  @override
  void initState() {
    super.initState();
    OtherNotifier otherNotifier =Provider.of<OtherNotifier>(context,listen:false);
    _currentOther=Other();
    _currentOther.description=_description;
    _currentOther.price=_price;
    _currentOther.condition=_condition;
  }

  @override
  Widget build(BuildContext context) {
    _currentOther.name=name;
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

             // -----------------Description Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
                maxLines: 5,
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
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),),
            keyboardType:TextInputType.text,
                validator: (String val){
                  if(val.isEmpty){
                    return "Description field is Empty.";
                  }
                  else if(val.length>20 && val.length<50){
                    return "Description should between 20 to 50 word";
                  }
                  return null;
                },
                onSaved: (val){
                  _currentOther.description=val;
                },
              ),
            ),
            // -----------------Description ends here-----------------//

             // -----------------Price Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
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
                validator:(String val){
                  if(val.isEmpty){
                    return "Price field cannot be empty.";
                  }
                  if(int.parse(val)<0){
                    return "Price cannot be zero or less.";
                  }
                   return null;
                },
                 onSaved:(val)
                {
                  _currentOther.price=int.parse(val);
                },
              ),
            ),
            // -----------------Price ends here-----------------//

            SizedBox(
              height: 30.0,
            ),


                // -----------------Condition Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
                decoration: InputDecoration(
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
                validator: (val){
                  if(val.isEmpty)
                  {
                    return "Condition field is empty.";
                  }
                   return null;
                },
                 onSaved:(val)
                {
                  _currentOther.condition=val;
                },
              ),
            ),
            // -----------------Condition ends here-----------------//


            
            
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
                    _SelectOtherImages();
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
            SizedBox(
              height: 30.0,
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
                       if(!_formKey.currentState.validate())
                      {
                         print("Errorrr");
                      }
                      else{
                         _formKey.currentState.save();
                          saveOther();
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