// import 'package:flutter/material.dart';
// import '../const/Theme.dart';

// class AddProuctScreen_Note extends StatefulWidget {
//   AddProuctScreen_Note({Key key}) : super(key: key);

//   @override
//   _AddProuctScreen_NoteState createState() => _AddProuctScreen_NoteState();
// }

// class _AddProuctScreen_NoteState extends State<AddProuctScreen_Note> {
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
//           onPressed: () {
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
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),

//             // -----------------Subject name Starts here-----------------//
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//               color: sc_InputBackgroundColor,
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(
//                     Icons.print,
//                     color: sc_ItemTitleColor,
//                   ),
//                   hintText: "Subject Name",
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
//             // -----------------Subject name ends here-----------------//

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
import 'package:shopconn/api/notesApi.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/api/uploadProduct.dart';
import 'package:shopconn/models/notes.dart';
import 'package:shopconn/notifier/notesNotifier.dart';
import '../const/Theme.dart';

class AddProuctScreen_Note extends StatefulWidget {
  String name;
  AddProuctScreen_Note({Key key,@required this.name}) : super(key: key);

  @override
  _AddProuctScreen_NoteState createState() => _AddProuctScreen_NoteState(name);
}

class _AddProuctScreen_NoteState extends State<AddProuctScreen_Note> {

  final GlobalKey <FormState> _formKey= GlobalKey<FormState>();
  Notes _currentNotes;
  String name;
  String _description="Best notes on sell";
  int _price=50;
  List<File> imageList=List();
  List<String> _branchesList=['COMPS','IT','MECH','EXTC','ETRX'];
  String _branch;
  List <String> _yearList=['I','II','III','IV'];
  String _year;
  String _subject="maths";
  String _condition="good";
  String _facultyName="saurabh Bujawade";


    initNotes()
    {
    print("Initial Constructor");
    Future<FirebaseUser> user =getCurrendFirebaseUser();
    user.then((value) => {
      _currentNotes.ownerId=value.uid,
      _currentNotes.postedAt=Timestamp.now(),
      _currentNotes.productCategory="Notes",
    }
    );
    print("After firebase user call");
  }

    void _SelectNotesImages() async {
    File image=await ImagePicker.pickImage(
      source: ImageSource.gallery);
      setState(() {
        imageList.add(image);
      });
  }

  
  uploadNotesData() async {
    print("Upload starting");
    bool ans =await  uploadProduct(_currentNotes, imageList);

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


    _AddProuctScreen_NoteState(this.name){
    initNotes();
  }
  @override
  void initState(){
    super.initState();
    NotesNotifier notesNotifier=Provider.of<NotesNotifier>(context,listen: false);
    _currentNotes=Notes();
    _currentNotes.subject=_subject;
    _currentNotes.description=_description;
    _currentNotes.price=_price;
    _currentNotes.condition=_condition;
    _currentNotes.facultyName=_facultyName;
  }

  @override
   Widget build(BuildContext context) {
    _currentNotes.name=name;
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
                  fontSize: 16.0,
                ),
              ),
            ),

            // -----------------Subject name Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.print,
                    color: sc_ItemTitleColor,
                  ),
                  hintText: "Subject Name",
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
                validator: (String val){
                  if(val.isEmpty){
                    return "Subject name field is empty";
                  }
                  return null;
                },
                onSaved: (String val){
                    _currentNotes.subject=val;
                },
              ),
            ),
            // -----------------Subject name ends here-----------------//

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
          ),
                ),
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
                onSaved:(val){
                    _currentNotes.description=val;
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
                onSaved: (val){
                  _currentNotes.price=int.parse(val);
                },
              ),
            ),
            // -----------------Price ends here-----------------//


              ///......................Year start here............///
Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: 
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                 child: DropdownButtonFormField(
                    decoration: const InputDecoration(  
                 enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),   
          ),  
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
                  prefixIcon: Icon(Icons.print,color:Colors.black,),
                      ),
                      
                 hint:Text('Year',style:TextStyle( color: sc_InputHintTextColor,
                      fontSize: 16.0,),),
                 value: _year,
                 items: _yearList.map((type){
                   return DropdownMenuItem(
                  child: new Text(type),
                  value: type,
              );
                 }).toList(),
                  onChanged: (val){
                   setState((){
                   _year=val;
                 });}, 
                 onSaved: (val)
                 {
                   _currentNotes.year=val;
                 },
            ),
               ),),

//................................year end here.............../////

              


              ///......................Branch start here............///
Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: 
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                 child: DropdownButtonFormField(
                    decoration: const InputDecoration(  
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:sc_PrimaryColor,width:3.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
                  ),
                  prefixIcon: Icon(Icons.print,color:Colors.black,),
                      ),
                      
                 hint:Text('Branch',style:TextStyle( color: sc_InputHintTextColor,
                      fontSize: 16.0,),),
                 value: _branch,
                 items: _branchesList.map((type){
                   return DropdownMenuItem(
                  child: new Text(type),
                  value: type,
              );
                 }).toList(),
                  onChanged: (val){
                   setState((){
                   _branch=val;
                 });}, 
                 onSaved: (val)
                 {
                   _currentNotes.branch=val;
                 },
            ),
               ),),
               //................branch end here..............................//

// -----------------Faculty name Starts here-----------------//
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              color: sc_InputBackgroundColor,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.print,
                    color: sc_ItemTitleColor,
                  ),
                  hintText: "Faculty name",
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
                  // if(val is String){
                  //   return "Price should be in number";
                  // }
                  if(val.isEmpty)
                  {
                    return "Faculty name field is empty.";
                  }
                   return null;
                },
                onSaved:(val)
                {
                  _currentNotes.facultyName=val;
                },
              ),
            ),
            // -----------------faculty name ends here-----------------//


  // -----------------condition Starts here-----------------//
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
                  // if(val is String){
                  //   return "Price should be in number";
                  // }
                  if(val.isEmpty)
                  {
                    return "Condition field is empty.";
                  }
                   return null;
                },
                onSaved:(val)
                {
                  _currentNotes.condition=val;
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
                    _SelectNotesImages();
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
                        print("Error");
                      }
                      else{
                        _formKey.currentState.save();
                        uploadNotesData();
                        print(_currentNotes.toMap());
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
    );
  }
}