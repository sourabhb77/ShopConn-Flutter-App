class  BoardingSlider
{
  String imagePath;
  String title,description;
  BoardingSlider({this.imagePath,this.title,this.description});

  void setTitle(String title)
  {
    this.title=title;
  }
  String getTitle()
  {
    return this.title;
  }

  void setImagePath(String path)
  {
    this.imagePath=path;
  }

  String getImagePath() 
  {
    return this.imagePath;
  }

  void setDescription(String  des)
  {
    this.description=des;
  }

  String getDescription()
  {
    return this.description;
  } 
}  


List<BoardingSlider> getSliderList()
{
  List<BoardingSlider> list= List<BoardingSlider>();
  BoardingSlider l1=BoardingSlider(imagePath:"assets/images/game.png",title:"Page 1",description:"This is page 1");
  BoardingSlider l2=BoardingSlider(imagePath:"assets/images/error.png",title:"Page 2",description:"This is page 2");
  BoardingSlider l3=BoardingSlider(imagePath:"assets/images/game.png",title:"Page 3",description:"This is page 3");


  list.add(l1);
  list.add(l2);
  list.add(l3);

  return list;
}