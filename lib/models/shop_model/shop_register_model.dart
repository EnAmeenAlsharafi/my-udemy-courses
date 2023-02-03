import 'package:flutter/material.dart';

class RegisterModel {
  bool? status;
  String? message;
  Data? data;
  RegisterModel.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;
  Data.fromJson(Map json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
