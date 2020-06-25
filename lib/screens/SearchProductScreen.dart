import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/widgets/Item.dart';

class  SearchProduct extends SearchDelegate<dynamic>{
  String parameter='name';
  bool desc= false;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon:Icon(Icons.clear),onPressed: (){
      query="";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon:Icon(Icons.arrow_back),onPressed: (){
      close(context,null);
    },);
  }
  
  @override
  Widget buildResults(BuildContext context) {
    List inputTagList = query.split(" ");
    Stream<QuerySnapshot> productStream = Firestore.instance.collection("post")
                  .orderBy('name',descending: false)
                  .where('tagList',arrayContainsAny: inputTagList)
                  .snapshots();
                  
    return Scaffold(
      appBar: CustomAppBar( parameter: parameter, desc: desc ),
      body: StreamBuilder(
        stream: productStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          } 
          else {
            return ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemBuilder: (BuildContext context, index) {
                return ProductItem(data: snapshot.data.documents[index],);
              },
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context,listen: false);
    getProducts(productNotifier);
    // final mylist= query.isEmpty
    //               ? []
    //               :productNotifier.productList.where((p)=>p.name.toString().toLowerCase().startsWith(query.toLowerCase())).toList();
    // return ListView.builder(
    //   itemBuilder:(context,index){
    //     return InkWell(
    //       onTap: () {
            
    //       },
    //       child: Container(
    //         padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //         child: Row(
    //           children: [
    //             Text(
    //               mylist[index].name,
    //               style: TextStyle(
    //                 fontSize: 16.0
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
      
    //   itemCount: mylist.length,
    // );
    
    List inputTagList = query.split(" ");
    Stream<QuerySnapshot> productStream = Firestore.instance.collection("post")
                  .where('tagList',arrayContainsAny: inputTagList)
                  .snapshots();
    return  StreamBuilder(
      stream: productStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        } 
        else {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Row(
                    children: [
                      Text(
                        snapshot.data.documents[index]["name"],
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.documents.length,
            ),
          );
        }
      },
    );
  }

}



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String parameter;
  bool desc;
  CustomAppBar({this.parameter, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sc_PrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: FilterBox()
              ),
              Expanded(
                flex: 3,
                child: SortBox()
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}



class FilterBox extends StatelessWidget {
  
  _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("tapped on filter");
          _showModalBottomSheet(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_list,
              color: sc_AppBarTextColor
            ),
            SizedBox(width: 10.0,),
            Text(
              "FILTER",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: sc_AppBarTextColor,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      );
  }
}



enum SingingCharacter { nameAZ, nameZA }

class SortBox extends StatefulWidget {
  // String parameter;
  // bool desc;

  // SortBox({this.parameter, this.desc});
  SortBox({Key key}) : super(key: key);

  @override
  _SortBoxState createState() => _SortBoxState();
}

class _SortBoxState extends State<SortBox> {
  SingingCharacter _character = SingingCharacter.nameAZ;
  // List<dynamic> x=[];
  // String parameter;
  // bool desc;
  int p=0;
  _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: const Text('Product Name : a-z'),
                leading: Radio(
                  value: SingingCharacter.nameAZ,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character= value;
                      print(_character);
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Product Name : z-a'),
                leading: Radio(
                  value: SingingCharacter.nameZA,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character= value;
                      print(_character);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("tapped on sort");
          _showModalBottomSheet(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sort,
              color: sc_AppBarTextColor
            ),
            SizedBox(width: 10.0,),
            Text(
              "SORT",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: sc_AppBarTextColor,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      );
  }
}