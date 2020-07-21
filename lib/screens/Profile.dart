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
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ProfilePicState { Default, DB, PICK }

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File image;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ProfilePicState state = ProfilePicState.Default;
  bool selected = false;
  String _name, _imageUrl, _mobile, _email;
  StorageReference storageReference;
  TextEditingController nameController = TextEditingController(),
      mobileController = TextEditingController(),
      emailController = TextEditingController();
  AuthNotifier authNotifier;

  void loadUserDetails() async {
    print("*******************************************************");

    setState(() {
      _imageUrl = authNotifier.imageUrl;
      _name = authNotifier.name;
      _email = authNotifier.email;
      _mobile = authNotifier.mobile;
      print("setting state $_imageUrl , $_email $_name $_mobile");

      // _imageUrl = snapshot.data["imageUrl"];
      // _name = snapshot.data["name"];
      // _mobile = snapshot.data["mobile"];
      // _email = snapshot.data["email"];
      // nameController= TextEditingController(text: name);
      nameController.text = _name;
      mobileController.text = _mobile;
      emailController.text = authNotifier.email;
      if (_imageUrl != null && _imageUrl.length > 5) {
        state = ProfilePicState.DB;
      }
    });
    print("Image URL : $_imageUrl Name : $_name");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadUserDetails());
    // loadUserDetails();
  }

  void uploadToDatabase() async {
    String name = nameController.text, mobile = mobileController.text;

    print("Name : $name, Mobile: $mobile");
    if (name.length == 0 || mobile.length < 2) {
      print("incorrect");
      showSnackBar("Fill All deatils Correctly", "red");
    } else {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print("File : $image");
      //Firebase Storage
      if (image != null) {
        await UpdateProfile(name, mobile, image).then((value) {
          if (value == "True") {
            showSnackBar("Upload Successful", "teal");
          } else {
            showSnackBar("Something went wrong $value", "red");
          }
        });
      } else {
        await UpdateProfileNoImage(name, mobile).then((value) {
          if (value == "True") {
            showSnackBar("Upload Successful", "teal");
          } else {
            showSnackBar("Something went wrong $value", "red");
          }
        });
      }
      final FirebaseUser user1 = await FirebaseAuth.instance.currentUser();
      authNotifier.currentUser(user1);
      initializeCurrentUser(authNotifier);
    }
  }

  void showSnackBar(String string, String color) {
    var clr = Colors.teal;
    if (color == "red") {
      clr = Colors.red;
    }
    var snackBar = new SnackBar(
      content: new Text(
        string,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
      backgroundColor: clr,
      action: SnackBarAction(
        label: "Ok",
        textColor: Colors.white,
        onPressed: () {},
      ),
      elevation: 4.0,
    );
    if (_scaffoldKey.currentState != null)
      _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> _selectImage() async {
    File Timage = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);
    Timage = await ImageCropper.cropImage(
      sourcePath: Timage.path,
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
      //   toolbarColor: Colors.purple,
      // toolbarWidgetColor: Colors.white,
    );
    setState(() {
      image = Timage;
      state = ProfilePicState.PICK;
      selected = true;
      print("Selected : $selected");
    });
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Edit Profile"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              uploadToDatabase();
            },
            child: Center(
              child: Text(
                "SAVE",
                style: TextStyle(
                  color: sc_AppBarTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: sc_AppBarBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    )
                  ]),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      state == ProfilePicState.DB
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(_imageUrl),
                              radius: 70,
                            )
                          : state == ProfilePicState.Default
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg"),
                                  radius: 70,
                                )
                              : CircleAvatar(
                                  radius: 70,
                                  backgroundImage: FileImage(image),
                                ),
                      Positioned(
                        bottom: 0,
                        right: -15,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.red,
                            size: 35.0,
                          ),
                          onPressed: () {
                            _selectImage();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                        child: Text(
                          _name != null ? _name : "",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: sc_ItemTitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: emailController,
                    toolbarOptions: ToolbarOptions(
                      paste: true,
                      selectAll: false,
                    ),
                    decoration: InputDecoration(
                      // fillColor: sc_skyblue,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: sc_PrimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                    enabled: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Full Name",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: sc_ItemTitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: nameController,
                    toolbarOptions: ToolbarOptions(
                      paste: true,
                      selectAll: false,
                    ),
                    decoration: InputDecoration(
                      fillColor: sc_InputBackgroundColor,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
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
                      prefixIcon: Icon(Icons.person),
                    ),
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Mobile No.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: sc_ItemTitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: mobileController,
                    toolbarOptions: ToolbarOptions(
                      paste: true,
                      selectAll: false,
                    ),
                    decoration: InputDecoration(
                      fillColor: sc_InputBackgroundColor,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
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
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Text("click"),
      //   elevation: 4,
      //   hoverColor: Colors.green,
      //   splashColor: Colors.green,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => ImageCapture()),
      //     );
      //   },
      //   backgroundColor: Colors.pink,
      // ),
    );
  }
}
