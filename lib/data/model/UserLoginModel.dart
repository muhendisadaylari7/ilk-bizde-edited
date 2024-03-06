// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) =>
    UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  String email;
  String password;
  String secretKey;

  UserLoginModel({
    required this.email,
    required this.password,
    required this.secretKey,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        email: json["email"],
        password: json["password"],
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "secretKey": secretKey,
      };
}
