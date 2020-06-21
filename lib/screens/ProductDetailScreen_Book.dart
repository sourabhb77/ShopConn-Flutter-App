// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopconn/api/shopconnApi.dart';
// import 'package:shopconn/const/Theme.dart';
// import 'package:shopconn/models/user.dart';
// import 'package:shopconn/notifier/ChatNotifier.dart';
// import 'package:shopconn/notifier/authNotifier.dart';
// import 'package:shopconn/notifier/bookNotifier.dart';
// import 'package:shopconn/screens/chatbox.dart';
// import '../widgets/Carousel.dart';

// class ProductDetailScreen_Book extends StatefulWidget {
//   const ProductDetailScreen_Book({Key key}) : super(key: key);

//   @override
//   _ProductDetailScreen_BookState createState() => _ProductDetailScreen_BookState();
// }

// class _ProductDetailScreen_BookState extends State<ProductDetailScreen_Book> {

//   dynamic _receiver;

//   @override
//   void initState() { 
//     AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
//     BookNotifier bookNotifier = Provider.of<BookNotifier>(context, listen: false);
//     Future<FirebaseUser> user = getCurrendFirebaseUser();
//     user.then((value) => {
//       print(value.displayName),
//     });
//     print("\n**************************\n");
//     super.initState();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     BookNotifier bookNotifier = Provider.of<BookNotifier>(context);
//     ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: sc_AppBarBackgroundColor,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.bookmark),
//             tooltip: 'Saved Product',
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget> [
//               Text(
//                 bookNotifier.currentBook.name,
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w500,
//                   color: sc_ItemTitleColor,
//                 ),
//               ),
//               SizedBox(height: 15.0,),
//               // Container(

//               // ),
//               Carousel(),
//               // SizedBox(
//               //   height: 30.0,
//               // ),
//               Text(
//                 'Rs ${bookNotifier.currentBook.price}',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   color: sc_PrimaryColor,
//                 ),
//               ),
//               SizedBox(
//                 height: 15.0,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       Text(
//                         'Category',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: sc_ItemTitleColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10.0,),
//                       Container(
//                         decoration: new BoxDecoration(
//                             color: sc_skyblue,
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                         height: 70.0,
//                         width: 70.0,
//                         child: Image.asset('assets/images/CatBooks.png'),
//                       ),
//                     ],
//                   ),
//                   Column(
//                       children: <Widget>[
//                         Text(
//                           'Author\'s Name',
//                           style: TextStyle(
//                             color: sc_ItemTitleColor,
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10.0,),
//                         Container(
//                           decoration: new BoxDecoration(
//                             color: sc_skyblue,
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           padding: EdgeInsets.all(10.0),
//                           child: Column(
//                             children: bookNotifier.currentBook.authorList.map((name){
//                               return Text(
//                                 '$name',
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: sc_ItemInfoColor,
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                   ),
//                   Column(
//                       children: <Widget>[
//                         Text(
//                           'Edition',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: sc_ItemTitleColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10.0,),
//                         Container(
//                           decoration: new BoxDecoration(
//                             color: sc_skyblue,
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           // color: sc_skyblue,
//                           height: 70.0,
//                           width: 70.0,
//                           child: Center(
//                             child: Text(
//                               bookNotifier.currentBook.edition.toString(),
//                               style: TextStyle(
//                                 fontSize: 20.0,
//                                 color: sc_ItemInfoColor,
//                               ),
//                             ),
//                           ),
//                         ),                           
//                       ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15.0,
//               ),
//               Text(
//                 'Description',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: sc_ItemTitleColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10.0),
//                     color: sc_grey,
//                     child: Text(
//                       bookNotifier.currentBook.description,
//                       style: TextStyle(
//                         color: sc_ItemTitleColor,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(
//                 height: 15.0,
//               ),
//               Text(
//                 'Owner',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: sc_ItemTitleColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10.0),
//                     color: sc_grey,
//                     child: Text(
//                       'Dr. Daddy',
//                       style: TextStyle(
//                         color: sc_ItemTitleColor,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15.0,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     RaisedButton(
//                       color: sc_PrimaryColor,
//                       child: Text(
//                         'Chat Now',
//                         style: TextStyle(
//                         fontSize: 16.0,
//                         ),
//                       ),
//                       onPressed: () {
//                         chatNotifier.setChatUser = bookNotifier.currentBook.ownerId;
//                         print(bookNotifier.currentBook.ownerId);
//                         Navigator.push(
//                           context,
//                           // MaterialPageRoute(builder: (context) => ChatPage(receiver: bookNotifier.currentBook.ownerId)),
//                           MaterialPageRoute(builder: (context) => ChatPage()),
//                         );
//                       },
//                     ),
//                     OutlineButton(
//                       color: sc_PrimaryColor,
//                       child: Text(
//                         'Add to WishList',
//                         style: TextStyle(
//                         fontSize: 16.0,
//                         ),
//                       ),
//                       onPressed: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(builder: (context) =>AddProuctScreen_Book()),
//                         // );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//       ),
//         ),
//     )
//   );
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopconn/api/MessageApi.dart';
import 'package:shopconn/api/shopconnApi.dart';
import 'package:shopconn/const/Theme.dart';
import 'package:shopconn/models/user.dart';
import 'package:shopconn/notifier/ChatNotifier.dart';
import 'package:shopconn/notifier/authNotifier.dart';
import 'package:shopconn/notifier/bookNotifier.dart';
import 'package:shopconn/notifier/productNotifier.dart';
import 'package:shopconn/screens/chatbox.dart';
import '../widgets/Carousel.dart';

class ProductDetailScreen_Book extends StatefulWidget {
  const ProductDetailScreen_Book({Key key}) : super(key: key);

  @override
  _ProductDetailScreen_BookState createState() => _ProductDetailScreen_BookState();
}

class _ProductDetailScreen_BookState extends State<ProductDetailScreen_Book> {

  dynamic _receiver;
  AuthNotifier authNotifier;
    BookNotifier bookNotifier ;
    ChatNotifier chatNotifier ;

  sendRequest() async
  {
      await sendNewRequest(
        authNotifier.userId,bookNotifier.currentBook.ownerId,
                                        
                                        bookNotifier.currentBook.id
                                        
                                         );
  }

  @override
  void initState() { 
  
    Future<FirebaseUser> user = getCurrendFirebaseUser();
    user.then((value) => {
      print(value.displayName),
    });
    print("\n**************************\n");
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    bookNotifier = Provider.of<BookNotifier>(context);
    chatNotifier = Provider.of<ChatNotifier>(context);
    authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sc_AppBarBackgroundColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            tooltip: 'Saved Product',
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                bookNotifier.currentBook.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: sc_ItemTitleColor,
                ),
              ),
              SizedBox(height: 15.0,),
              // Container(

              // ),
              Carousel(),
              // SizedBox(
              //   height: 30.0,
              // ),
              Text(
                'Rs ${bookNotifier.currentBook.price}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: sc_PrimaryColor,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: sc_ItemTitleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        decoration: new BoxDecoration(
                            color: sc_skyblue,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        height: 70.0,
                        width: 70.0,
                        child: Image.asset('assets/images/CatBooks.png'),
                      ),
                    ],
                  ),
                  Column(
                      children: <Widget>[
                        Text(
                          'Author\'s Name',
                          style: TextStyle(
                            color: sc_ItemTitleColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          decoration: new BoxDecoration(
                            color: sc_skyblue,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: bookNotifier.currentBook.authorList.map((name){
                              return Text(
                                '$name',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: sc_ItemInfoColor,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                  ),
                  Column(
                      children: <Widget>[
                        Text(
                          'Edition',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: sc_ItemTitleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          decoration: new BoxDecoration(
                            color: sc_skyblue,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          // color: sc_skyblue,
                          height: 70.0,
                          width: 70.0,
                          child: Center(
                            child: Text(
                              bookNotifier.currentBook.edition.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: sc_ItemInfoColor,
                              ),
                            ),
                          ),
                        ),                           
                      ],
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16.0,
                  color: sc_ItemTitleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: sc_grey,
                    child: Text(
                      bookNotifier.currentBook.description,
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 15.0,
              ),
              Text(
                'Owner',
                style: TextStyle(
                  fontSize: 16.0,
                  color: sc_ItemTitleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: sc_grey,
                    child: Text(
                      'Dr. Daddy',
                      style: TextStyle(
                        color: sc_ItemTitleColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RaisedButton(
                      color: sc_PrimaryColor,
                      child: Text(
                        'Chat Now',
                        style: TextStyle(
                        fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        chatNotifier.setChatUser = bookNotifier.currentBook.ownerId;
                        print(bookNotifier.currentBook.ownerId);;
                        print("Sending Chat Request NOW ****************");

                        sendRequest();
                        print("REQUEST SENT ************************");

                      
                        // Navigator.push(
                        //   context,
                        //   // MaterialPageRoute(builder: (context) => ChatPage(receiver: bookNotifier.currentBook.ownerId)),
                        //   MaterialPageRoute(builder: (context) => ChatPage()),
                        // );
                      },
                    ),
                    OutlineButton(
                      color: sc_PrimaryColor,
                      child: Text(
                        'Add to WishList',
                        style: TextStyle(
                        fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>AddProuctScreen_Book()),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ],
      ),
        ),
    )
  );
  }
}
