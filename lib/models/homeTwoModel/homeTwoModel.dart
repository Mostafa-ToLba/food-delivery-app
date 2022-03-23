
class getListHoriModel{
  String? name;
  String? image;

  getListHoriModel({this.name,this.image});

  getListHoriModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    image=json['image'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'image':image,
    };
  }
}
