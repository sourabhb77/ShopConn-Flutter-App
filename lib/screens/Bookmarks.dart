import 'package:flutter/material.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/widgets/Item.dart';
import 'package:shopconn/api/shopconnApi.dart';

class BookMarks extends StatefulWidget {
  @override
  BookMarksState createState() => BookMarksState();
}

class BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookmarks",
          style: TextStyle(color: sc_AppBarTextColor),
        ),
      ),
      body: FutureBuilder(
        future: getBookmarks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error Occured!");
          if (!snapshot.hasData)
            return Text("Empty List");
          else {
            return ListView.builder(
                itemBuilder: (context, index) {
                  // return Text("data");
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: DeleteableProductItem(
                      data: snapshot.data[index].data,
                    ),
                  );
                },
                itemCount: snapshot.data.length);
          }
        },
      ),
    );
  }
}
