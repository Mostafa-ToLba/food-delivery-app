class getOrders{
  String? name;
  int? price;
  int? num ;
  String? text;
  int? total;

  String? username='';
  String? phone='';
  String? location='';
  String? uId='';
  String? time='';


  getOrders({this.name,this.price,this.num,this.text,this.username,this.phone,this.location,this.uId,this.time,this.total});

  getOrders.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    price=json['price'];
    num=json['num'];
    text=json['text'];

    username=json['username'];
    phone=json['phone'];
    location=json['location'];
    uId=json['uId'];
    time=json['time'];
    total=json['total'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'price':price,
      'num':num,
      'text':text,

      'username':username,
      'phone':phone,
      'location':location,
      'uId':uId,
      'time':time,
      'total':total,
    };
  }

}
