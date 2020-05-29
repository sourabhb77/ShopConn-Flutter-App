import 'package:shopconn/screens/authenticate.dart';
import 'package:shopconn/screens/msg-request.dart';
// import 'package:book/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if(user==null)
    {
      return Authenticate();
    }
    else
    {
      return ChatBox();
    }
  }
}