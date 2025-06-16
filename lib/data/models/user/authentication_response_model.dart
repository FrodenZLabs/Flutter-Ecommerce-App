import 'dart:convert';

import 'package:flutter_ecommerce_app/data/models/user/user_model.dart';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) => AuthenticationResponseModel.fromJson(json.decode(str));
String authenticationResponseModelToJson(AuthenticationResponseModel data) => json.encode(data.toJson());

class AuthenticationResponseModel {
  final String token;
  final UserModel user;

  const AuthenticationResponseModel({required this.token, required this.user});

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) => AuthenticationResponseModel(
      token: json["token"],
      user: UserModel.fromJson(json["user"])
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}