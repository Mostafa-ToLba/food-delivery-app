
class AddToCart{
  String? name;
  int? price;
  int? num ;
  String? text;
  int? NumFromCart;

  String? username;
  String? phone;
  String? location;
  String? uId;
  String? time;
  var total;
  bool? orderIsOk;

  AddToCart({this.name,this.price,this.num,this.text,this.username,this.phone,this.location,this.uId,this.time,this.total,this.NumFromCart,this.orderIsOk});

  AddToCart.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    price=json['price'];
    num=json['num'];
    text=json['text'];
    NumFromCart=json['NumFromCart'];

    username=json['username'];
    phone=json['phone'];
    location=json['location'];
    uId=json['uId'];
    time=json['time'];
    total=json['total'];
    orderIsOk=json['orderIsOk'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'price':price,
      'num':num,
      'text':text,
      'NumFromCart':NumFromCart,
      'username':username,
      'phone':phone,
      'location':location,
      'uId':uId,
      'time':time,
      'total':total,
      'orderIsOk':orderIsOk,
    };
  }

}
