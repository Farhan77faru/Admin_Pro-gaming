// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

UserModel UserModelFromJson(String str) =>
 UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) =>
 json.encode(data.toJson());

class UserModel{
  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.notificationToken,
    this.image,
  });
String email;
String password;
String id;
String? image;
String? notificationToken;
 
 factory UserModel.fromJson(Map<String, dynamic> json)=> UserModel(
  email: json["email"],
  password: json["password"],
  id: json["id"],
  image: json["image"],
  notificationToken: json["notificationToken"]??"",
  );

 Map<String,dynamic> toJson() => {
  "email":email, 
  "password": password,
  "id" : id,
  "image":image,
  "notificationToken":notificationToken
 } ;

 
UserModel copyWith({
String? name,image,password
  }) =>
  UserModel(
  id: id,
  email: email,
  image: image??this.image,
  password: password??this.password,
  notificationToken: notificationToken
 
  
      );
 
}