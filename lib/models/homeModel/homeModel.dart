
class HomeModel {

  HomeDataModel? data;
  HomeModel(this.data);
  HomeModel.fromJson(Map<String, dynamic> json)
  {
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {

  List<ProductModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json)
  {

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}


class ProductModel {
  String? name;
  int? price;
  int? num ;
  String? text;

  String? username='';
  String? phone='';
  String? location='';
  String? uId='';
  String? time='';
  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    num = json['num'];
    text = json['text'];
    username = json['username'];
    phone = json['phone'];
    location = json['location'];
    uId = json['uId'];
    time = json['time'];
  }
}
