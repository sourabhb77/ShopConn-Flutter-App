// import 'package:meta/meta.dart';

// class ClothesList {
//   List<Clothes> clotheItem;
//   ClothesList({@required this.clotheItem});
// }


// class Product {
  // String pId;
  // String name;
  // int price;
  // String description;
  // List<String> imgList;
  // String productCategory;
  // bool onSell = true;

//   Product({  this.pId, this.name, this.price, this.description, this.imgList, this.productCategory,this.onSell });
// }

// // #Book
// // category -aca and nonaca
// // authorList
// // edition
// // publication
// // condition -- (levels)
// // branch
// // subject

// class Books extends Product{
//   String bookCategory;
//   List<String> authorList;
//   int edition;
//   String publication;
//   String condition; //Esthetic condition
//   String branch;
//   String subject;
//   Books({ this.pId, this.name, this.price, this.description, this.imgList, this.productCategory,this.onSell, this.bookCategory, this.authorList, this.edition, this.publication, this.condition, this.branch, this.subject }): super(pId, name,price, description,imgList, productCategory, onSell );
//   // Books(String pId, String name,int price, List<String> imgList, String description,String author,String publication,int edition): super(pId, name, price, description, imgList);

// }

// class Clothes extends Product{
//   String size;
//   Clothes(String pId, String name,int price, String description,List<String> imgList, String size): super(pId, name, price, description, imgList);

// }

// class Notes extends Product{
//   Notes(String pId, String name,int price, List<String> imgList, String description): super(pId, name, price, description, imgList);

// }

// class Other extends Product{
//   Other(String pId, String name,int price, String description,List<String> imgList, String size): super(pId, name, price, description, imgList);

// }


// ClothesList clothesData = ClothesList( 
// clotheItem: [
//   Clothes(
//     "Id1", 
//     "Boiler Suit", 
//     180,
//     "this is very good item you can purchase here",
//     ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
//     "M"
//   ),
//   Clothes(
//     "Id2", 
//     "Boiler Suit", 
//     280,
//     "this is very good item you can purchase here",
//     ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
//     "L"
//   ),
//   Clothes(
//     "Id3", 
//     "Boiler Suit", 
//     480,
//     "this is very good item you can purchase here",
//     ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
//     "XL"
//   ),
//   Clothes(
//     "Id4", 
//     "Boiler Suit", 
//     320,
//     "this is very good item you can purchase here",
//     ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
//     "XXL"
//   ),
//   Clothes(
//     "Id5", 
//     "Boiler Suit", 
//     400,
//     "this is very good item you can purchase here",
//     ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
//     "M"
//   ),
  
// ]
// );





// #Clothes
// size
// type - labcoat or boiler suit

// #Notes
// subject
// year
// faculty name




import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String id;
  String ownerId;
  String name;
  int price;
  String description;
  List<String> imgList;
  String productCategory;
  bool onSell = true;
  String bookCategory;
  List<String> authorList;
  int edition;
  String publication;
  String condition; //Esthetic condition
  String branch;
  String subject;
  Timestamp postedAt;

  Book();
  
  Book.fromMap(Map<String, dynamic> data){
    // Map data = snapshot.data;
    id = data['id'];
    ownerId = data['ownerId'];
    name = data['name'];
    price = data['price'];
    description = data['description'];
    // imgList = data['imgList'];
    imgList = List.from(data['imgList']);
    productCategory = data['productCategory'];
    onSell = data['onSell'];
    bookCategory = data['bookCategory'];
    // authorList = data['authorList'];
    authorList = List.from(data['authorList']);
    edition = data['edition'];
    publication = data['publication'];
    condition = data['condition'];
    branch = data['branch'];
    subject = data['subject'];
    postedAt = data['postedAt'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'price': price,
      'description': description,
      'imgList': imgList,
      'productCategory': productCategory,
      'onSell': onSell,
      'bookCategory': bookCategory,
      'authorList': authorList,
      'edition': edition,
      'publication': publication,
      'condition': condition,
      'branch': branch,
      'subject': subject,
      'postedAt': postedAt,
    };
  }
}