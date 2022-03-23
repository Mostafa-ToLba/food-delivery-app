
class makeOrderModel{
  String? itemName;
  int? price;
  String? instructions;
  int? num ;
  String? name;
  String? phone;
  String? location;
  String? uId;
  String? time;


  makeOrderModel({ this.itemName,this.price,this.instructions,this.num,this.name,this.phone,this.location,this.uId,this.time});

  makeOrderModel.fromJson(Map<String,dynamic>json)
  {
    itemName=json['itemName'];
    price=json['price'];
    instructions=json['instructions'];
    num=json['num'];
    name=json['name'];
    phone=json['phone'];
    location=json['location'];
    uId=json['uId'];
    time=json['time'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'itemName':itemName,
      'price':price,
      'instructions':instructions,
      'num':num,
      'name':name,
      'phone':phone,
      'location':location,
      'uId':uId,
      'time':time,
    };
  }

}
