

class sliderModel{

  String? image;
  String? name;
  int? price;
  String? description;

  sliderModel({ this.description,this.name, this.image,this.price});

  sliderModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    image=json['image'];
    price=json['price'];
    description=json['description'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'image':image,
      'price':price,
      'description':description,
    };
  }

}
