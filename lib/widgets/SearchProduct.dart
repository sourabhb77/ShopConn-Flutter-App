import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/widgets/Item.dart';

class  SearchProduct extends SearchDelegate<dynamic>{

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
                  .where('tagList',arrayContainsAny: inputTagList)
                  .snapshots();
                  
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: StreamBuilder(
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
          return ListView.builder(
            padding: EdgeInsets.all(5.0),
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
          );
        }
      },
    );
  }

}