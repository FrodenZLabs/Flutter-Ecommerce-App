import 'dart:convert';

import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({required super.id, required super.firstName, required super.lastName, required super.image, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      image: json["image"],
      email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
    "email": email
  };
}