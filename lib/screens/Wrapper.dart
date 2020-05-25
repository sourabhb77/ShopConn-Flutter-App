import './authenticate.dart';
import './msg-request.dart';
// import 'package:book/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

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