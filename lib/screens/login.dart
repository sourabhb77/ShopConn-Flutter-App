import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/screens/HomeScreen.dart';

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
  AuthMode _authMode = AuthMode.Login;

  User _user = User();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
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
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_authMode == AuthMode.Login) {
      login(_user, authNotifier);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => HomeScreen()));
      await prefs.setBool('logined', true);
    } else {
      signup(_user, authNotifier);
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
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Display Name",
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
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Email",
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
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Password",
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
            Icons.print,
            color: sc_ItemTitleColor,
          ),
          hintText: "Confirm Password",
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
    print("Building login screen");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_authMode == AuthMode.Login ? 'Login' : 'Register',
            style: TextStyle(color: Colors.black)),
        leading: Icon(
          IconData(58135,
              fontFamily: 'MaterialIcons', matchTextDirection: true),
          color: Colors.black,
          size: 30.0,
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
                    color: sc_PrimaryColor,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => _submitForm(),
                    child: Text(
                      _authMode == AuthMode.Login ? 'Login' : 'Signup',
                      style: TextStyle(fontSize: 20, color: sc_AppBarTextColor),
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
                    color: sc_AppBarTextColor,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () {},
                    child: Text(
                      _authMode == AuthMode.Login
                          ? 'Login with Google'
                          : 'Signup with Google',
                      style: TextStyle(fontSize: 18, color: sc_ItemTitleColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 15),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${_authMode == AuthMode.Login ? 'Don\'t Have Account? ' : 'Have Account? '}',
                        style:
                            TextStyle(fontSize: 16.0, color: sc_ItemTitleColor),
                      ),
                      GestureDetector(
                        child: Text(
                          '${_authMode == AuthMode.Login ? 'Register' : 'Login'} with Google',
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
