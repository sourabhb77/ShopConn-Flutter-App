import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/reportApi.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/Report.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/screens/HomeScreen.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController _reportMessageController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Report _currentReport;
  _ReportScreenState();

  saveReport() async {
    print("Uploading data");
    bool ans = await uploadReport(_currentReport);
    print("Upload Finisehd");
    if (ans == true) {
      print("\n*******Upload Status********\n");
      print("Success");
      print("\n***************\n");
      _reportMessageController.clear();
    } else {
      print("FAILURE");
    }
  }

  void showSnackBar(String string) {
    var snackBar = new SnackBar(
      content: new Text(
        string,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
      backgroundColor: Colors.teal,
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

  @override
  void initState() {
    super.initState();
    _currentReport = Report();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: sc_PrimaryColor,
        elevation: 0,
        title: Text("Report Bug"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.asset(
                "assets/images/reportpage.png",
                height: 200,
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                "Got Some bug, Give us some information",
                style: TextStyle(
                  fontSize: 18.0,
                  color: sc_ItemTitleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      fillColor: sc_InputBackgroundColor,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                      hintText: "Report here......",
                      hintStyle: TextStyle(
                        color: sc_InputHintTextColor,
                        fontSize: 16.0,
                      ),
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
                    ),
                    keyboardType: TextInputType.text,
                    controller: _reportMessageController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Center(
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(40, 13, 40, 13),
                onPressed: () {
                  if (_reportMessageController.text.length < 1) {
                    showSnackBar("Fill report");
                  } else {
                    _currentReport.report = _reportMessageController.text;
                    _currentReport.userId = authNotifier.userId;
                    _currentReport.postedAt = Timestamp.now();
                    saveReport();
                    showSnackBar("Report Succesfully !!");
                    // _showMyDialog();
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: sc_AppBarTextColor,
                    fontSize: 16.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: sc_AppBarBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Thanks for reporting'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Report has been made.'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('Ok'),
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => HomeScreen(),
  //                 ),
  //                 (route) => route.isFirst,
  //               );
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
