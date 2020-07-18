import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopconn/api/googleSignInApi.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/screens/HomeScreen.dart';

import '../api/shopconnApi.dart';
import '../api/shopconnApi.dart';
import '../notifier/authNotifier.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AuthNotifier authNotifier;
  AuthMode _authMode = AuthMode.Login;
  bool load = false;

  User _user = User();

  @override
  void initState() {
    initializeCurrentUser(authNotifier);
    Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();
    user.then((FirebaseUser _user) {
      if (_user == null) {
        print("User is null");
      } else {
        print("User is not null , uid: ${_user.uid} email: ${_user.email}");
      }
    });
    super.initState();

    //Accessing FCM token
    _firebaseMessaging
        .getToken()
        .then((value) => print("TOKEN: ${value}"))
        .catchError((err) => print("Error token : $err"));
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_authMode == AuthMode.Login) {
      setState(() {
        load = true;
      });
      String result = await login(_user, authNotifier);
      setState(() {
        load = false;
      });
      if (result.compareTo("True") == 0) {
        await prefs.setBool('logined', true);
        print("Intialize AuthNotifier");
        initializeCurrentUser(authNotifier);

        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        var snackBar = new SnackBar(
            content: new Text(result), backgroundColor: Colors.red);

        // Find the Scaffold in the Widget tree and use it to show a SnackBar!
        Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
      }
    } else {
      setState(() {
        load = true;
      });
      String result = await signup(_user, authNotifier);
      setState(() {
        load = false;
      });
      if (result.compareTo("True") == 0) {
        var snackBar = new SnackBar(
            content: new Text("Registered Succesfully, Login Now"),
            backgroundColor: Colors.teal);
        Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
      } else {
        var snackBar = new SnackBar(
            content: new Text(result), backgroundColor: Colors.red);
        Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
      }
    }
  }

  void _sigInGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_authMode == AuthMode.Login) {
      var result = await signInWithGoogle();

      if (result == true) {
        await prefs.setBool('logined', true);
        initializeCurrentUser(authNotifier);

        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        var snackBar = new SnackBar(
            content: new Text("An Error Occured!!, Try again Later!!!"),
            backgroundColor: Colors.red);

        // Find the Scaffold in the Widget tree and use it to show a SnackBar!
        Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
      }
    }
  }

  Widget _buildDisplayNameField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.email,
            color: sc_ItemTitleColor,
          ),
          hintText: "Display Name",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Display Name is required';
          }

          if (value.length < 5 || value.length > 12) {
            return 'Display Name must be betweem 5 and 12 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _user.displayName = value.trim();
          print(value);
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.email,
            color: sc_ItemTitleColor,
          ),
          hintText: "Email",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is required';
          }

          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        },
        onSaved: (String value) {
          _user.email = value.trim();
        },
        autofocus: true,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.lock,
            color: sc_ItemTitleColor,
          ),
          hintText: "Password",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        obscureText: true,
        controller: _passwordController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password is required';
          }

          if (value.length < 5 || value.length > 20) {
            return 'Password must be betweem 5 and 20 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _user.password = value.trim();
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: sc_InputBackgroundColor,
          filled: true,
          prefixIcon: Icon(
            Icons.enhanced_encryption,
            color: sc_ItemTitleColor,
          ),
          hintText: "Confirm Password",
          hintStyle: TextStyle(
            color: sc_InputHintTextColor,
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: sc_PrimaryColor, width: 3.0),
          ),
        ),
        obscureText: true,
        validator: (String value) {
          if (_passwordController.text != value) {
            return 'Passwords do not match';
          }

          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    print("Building login screen");
    if (authNotifier.user != null) {
      print("Authno Notifier");
      // Navigator.of(context).pushReplacement(
      //     new MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _authMode == AuthMode.Login ? 'Login' : 'Register',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0.5,
      ),
      body: Container(
        // constraints: BoxConstraints.expand(
        //   height: MediaQuery.of(context).size.height,
        // ),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(color: sc_AppBarTextColor),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                _authMode == AuthMode.Signup
                    ? _buildDisplayNameField()
                    : Container(),
                _buildEmailField(),
                _buildPasswordField(),
                _authMode == AuthMode.Signup
                    ? _buildConfirmPasswordField()
                    : Container(),
                SizedBox(height: 20),
                ButtonTheme(
                  minWidth: 260,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: sc_PrimaryColor,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => _submitForm(),
                    child: load
                        ? Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            ),
                          )
                        : Text(
                            _authMode == AuthMode.Login ? 'Login' : 'Signup',
                            style: TextStyle(
                                fontSize: 20, color: sc_AppBarTextColor),
                          ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'or',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ButtonTheme(
                  minWidth: 260,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: sc_AppBarTextColor,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () {
                      _sigInGoogle();
                    },
                    child: Text(
                      _authMode == AuthMode.Login
                          ? 'Login with Google'
                          : 'Signup with Google',
                      style: TextStyle(fontSize: 18, color: sc_ItemTitleColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${_authMode == AuthMode.Login ? 'Don\'t Have Account? ' : 'Have Account? '}',
                      style:
                          TextStyle(fontSize: 16.0, color: sc_ItemTitleColor),
                    ),
                    GestureDetector(
                      child: Text(
                        '${_authMode == AuthMode.Login ? 'Register' : 'Login'} Here',
                        style:
                            TextStyle(fontSize: 16.0, color: sc_PrimaryColor),
                      ),
                      onTap: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
