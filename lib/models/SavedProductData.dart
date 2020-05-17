import 'package:meta/meta.dart';

class ClothesList {
  List<Clothes> clotheItem;
  ClothesList({@required this.clotheItem});
}


class Product {
  String pId;
  String name;
  int price;
  String description;
  List<String> imgList;

  Product(String pId, String name, int price, String description, List<String> imgList){
    this.pId = pId;
    this.name = name;
    this.price = price;
    this.description = description;
    this.imgList = imgList;
  }
}

class Clothes extends Product{
  String size;
  Clothes(String pId, String name,int price, String description,List<String> imgList, String size): super(pId, name, price, description, imgList);

}

class Books extends Product{
  Books(String pId, String name,int price, List<String> imgList, String description): super(pId, name, price, description, imgList);

}

class Notes extends Product{
  Notes(String pId, String name,int price, List<String> imgList, String description): super(pId, name, price, description, imgList);

}

class Other extends Product{
  Other(String pId, String name,int price, String description,List<String> imgList, String size): super(pId, name, price, description, imgList);

}


ClothesList clothesData = ClothesList( 
clotheItem: [
  Clothes(
    "Id1", 
    "Boiler Suit", 
    180,
    "this is very good item you can purchase here",
    ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
    "M"
  ),
  Clothes(
    "Id2", 
    "Boiler Suit", 
    280,
    "this is very good item you can purchase here",
    ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
    "L"
  ),
  Clothes(
    "Id3", 
    "Boiler Suit", 
    480,
    "this is very good item you can purchase here",
    ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
    "XL"
  ),
  Clothes(
    "Id4", 
    "Boiler Suit", 
    320,
    "this is very good item you can purchase here",
    ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
    "XXL"
  ),
  Clothes(
    "Id5", 
    "Boiler Suit", 
    400,
    "this is very good item you can purchase here",
    ["assets/images/1.png","assets/images/2.png","assets/images/3.png",], 
    "M"
  ),
  
]
);