import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/widgets/ImagePicker/ImageCapture.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File image;
  bool selected=false;
  StorageReference storageReference;
  TextEditingController nameController = TextEditingController(), mobileController = TextEditingController();

  Future<String> _uploadImage(FirebaseUser user) async
  {
    storageReference=FirebaseStorage.instance.ref().child("users/${user.uid}");
    StorageUploadTask task= storageReference.putFile(image);
    final StorageTaskSnapshot downloadUrl = (await task.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL: $url");
    return url; 
  }

  void uploadToDatabase() async
  {
    String name=nameController.text,mobile=mobileController.text;

    print("Name : $name, Mobile: $mobile");
    if(name.length ==0 || mobile.length<2)
    {
      print("incooret");
    }
    else
    {

      
      final FirebaseUser user= await  FirebaseAuth.instance.currentUser();
      print("User ID: ${user.uid}");


      //Firebase Storage
      String imageUrl = await _uploadImage(user);


      //Firestore Uploading
      
      DocumentReference ref= Firestore.instance.document("users/${user.uid}");
      
      
      ref.setData({
        "name":name,
        "mobile":mobile,
        "imageUrl":imageUrl
      },merge: true).then((value) => 
      print("Success")).catchError((error)=>
      {
        print(error)
        
      });
    }
  }

   Future<void> _selectImage() async {
    File Timage =await ImagePicker.pickImage(source: ImageSource.gallery);
    Timage = await ImageCropper.cropImage(
        sourcePath: Timage.path,
        // ratioX: 1.0,
        // ratioY: 1.0,
        // maxWidth: 512,
        // maxHeight: 512,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      );
      setState(() {
        
        image=Timage;
        selected=true;
        print("Selected : $selected");
      });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: ()
            {
              uploadToDatabase();
            },
          )
        ],
        backgroundColor: sc_AppBarBackgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            InkWell(
              onTap: ()
              {
                _selectImage();
               
              //    Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => ImageCapture()),);

              },
              child: selected==true?  Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: CircleAvatar(
                  // child: Image.file(image),
                  backgroundImage: FileImage(image),
                  radius: 78.0,),
                ):
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.teal,
                  child: CircleAvatar(
                    radius: 78.0,
                    backgroundImage: NetworkImage(
                        "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Doctor Daddy",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.perm_phone_msg),
                    onPressed: () => {},
                  ),
                )
              ],
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Container(child: Text("Mail")),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    
                    maxLength: 20,
                    maxLines: 1,
                    toolbarOptions: ToolbarOptions(
                      paste: true,
                      selectAll: false,
                    ),
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.person),
                    ),
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,

                    // cursorRadius: Radius.circular(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    controller: nameController,
                    maxLength: 20,
                    maxLines: 1,
                    toolbarOptions: ToolbarOptions(
                      paste: true,
                      selectAll: false,
                    ),
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,

                    // cursorRadius: Radius.circular(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    maxLength: 20,
                    maxLines: 1,
                    toolbarOptions: ToolbarOptions(
                      paste: true,
                      selectAll: false,
                    ),
                    keyboardType: TextInputType.number,
                    controller: mobileController,
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,

                    // cursorRadius: Radius.circular(100),
                  ),
                ),
              ],
            ),
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("click"),
        elevation: 4,
        hoverColor: Colors.green,
        splashColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImageCapture()),
          );
        },
        backgroundColor: Colors.pink,
      ),
    );
  }
}
