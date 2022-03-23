
class UserInformation{

  String? location;
  String? name;
  String? phone;

  UserInformation({ this.location, this.phone, this.name});

  UserInformation.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    phone=json['phone'];
    location=json['location'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'phone':phone,
      'location':location,
    };
  }

}