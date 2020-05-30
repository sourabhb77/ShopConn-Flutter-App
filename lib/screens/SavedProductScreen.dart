import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/SavedProductData.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/widgets/Item.dart';

class SavedProductScreen extends StatefulWidget {
  const SavedProductScreen({Key key}) : super(key: key);

  @override
  _SavedProductScreenState createState() => _SavedProductScreenState();
}

class _SavedProductScreenState extends State<SavedProductScreen> {
  @override
  void initState() { 
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context, listen: false);
    getBooks(bookNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Product",
          style: TextStyle(
            color: sc_AppBarTextColor
          ),
        ),
        backgroundColor: sc_AppBarBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()=> signout(authNotifier),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.separated(
              itemBuilder: (BuildContext context, int index){
                return Item();
              },
              separatorBuilder: (BuildContext context, int index){
                return const Divider(
                  color: Colors.grey,
                  height: 5,
                  thickness: 1,
                  indent: 115,
                  endIndent: 0,
                );
              },            
              itemCount: bookNotifier.bookList.length
            )

          ],
        ),
      ),
    );
  }
}

