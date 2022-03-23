
class checkenModel{

  String? image;
  String? name;
  int? price;
  String? description;
  bool? availability;
  bool? discount;
  String? text;
  int? beforeDiscount;

  checkenModel({ this.description,this.name, this.image,this.price,this.availability,this.discount,this.text,this.beforeDiscount});

  checkenModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    image=json['image'];
    price=json['price'];
    description=json['description'];
    availability=json['availability'];
    discount=json['discount'];
    text=json['text'];
    beforeDiscount=json['beforeDiscount'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'image':image,
      'price':price,
      'description':description,
      'availability':availability,
      'discount':discount,
      'text':text,
      'beforeDiscount':beforeDiscount,
    };
  }

}
