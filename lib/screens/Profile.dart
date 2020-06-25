import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/widgets/ImagePicker/ImageCapture.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ProfilePicState {Default, DB, PICK}
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File image;
  ProfilePicState state = ProfilePicState.Default;
  bool selected = false;
  String name, imageUrl,mobile,email;
  StorageReference storageReference;
  TextEditingController nameController = TextEditingController(),
      mobileController = TextEditingController(),
      emailController =TextEditingController();
  String _user;
  AuthNotifier authNotifier;

  void LoadUserDetails() async {
    print("*******************************************************");
    _user = await getCurrentUser(authNotifier);
    print("USER ID: ${_user}");
    DocumentSnapshot snapshot = await getProfile(_user);
    print("SnapShot : ${snapshot.data.toString()}");

    setState(() {
      print("setting state");
      imageUrl = snapshot.data["imageUrl"];
      name = snapshot.data["name"];
      mobile=snapshot.data["mobile"];
      email=snapshot.data["email"];
      // nameController= TextEditingController(text: name);
      nameController.text=name;
      mobileController.text=mobile;
      emailController.text=snapshot.data["email"];


      if(imageUrl!=null && imageUrl .length>5)
      {
        state=ProfilePicState.DB;
      }
    });
    print("Image URL : $imageUrl Name : $name");
  }

  @override
  void initState() {
    super.initState();
    LoadUserDetails();
  }


  void uploadToDatabase() async {
    String name = nameController.text, mobile = mobileController.text;

    print("Name : $name, Mobile: $mobile");
    if (name.length == 0 || mobile.length < 2) {
      print("incorrect");
    } else {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print("User ID: ${user.uid}");
      //Firebase Storage
      UpdateProfile(name, mobile, image);
      //Firestore Uploading

    }
  }

  Future<void> _selectImage() async {
    File Timage = await ImagePicker.pickImage(source: ImageSource.gallery);
    Timage = await ImageCropper.cropImage(
      sourcePath: Timage.path,
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
      
      // toolbarColor: Colors.purple,
      // toolbarWidgetColor: Colors.white,
    );
    setState(() {
      image = Timage;
      state=ProfilePicState.PICK;
      selected = true;
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
            onPressed: () {
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
              onTap: () {
                _selectImage();

                //    Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => ImageCapture()),);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child:  state== ProfilePicState.DB ?
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 78,
                ):
                state== ProfilePicState.Default ? 
                CircleAvatar(
                   backgroundImage: NetworkImage("https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"),
                   radius: 78,)
                   : CircleAvatar(radius: 78,
                   backgroundImage: FileImage(image),)
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
                    controller: emailController,
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
                    enabled: false,
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
