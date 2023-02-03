class ShopLoginModel {
  String? message;
  bool? status;
  UserData? data;

  //named constructor
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? points;
  int? credit;
  String? token;
  String? image;

//named constructor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
    image = json['image'];
  }
}
