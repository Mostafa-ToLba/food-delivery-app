class myOrder{

  String? time;
  var total;


  myOrder({  this.time, this.total});

  myOrder.fromJson(Map<String,dynamic>json)
  {
    time=json['time'];
    total=json['total'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'time':time,
      'total':total,
    };
  }

}