// To parse this JSON data, do
//
//     final appleLoginRequestModel = appleLoginRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AppleLoginRequestModel appleLoginRequestModelFromJson(String str) =>
    AppleLoginRequestModel.fromJson(json.decode(str));

String appleLoginRequestModelToJson(AppleLoginRequestModel data) =>
    json.encode(data.toJson());

class AppleLoginRequestModel {
  String secretKey;
  String token;
  String name;
  String surname;

  AppleLoginRequestModel({
    required this.secretKey,
    required this.token,
    required this.name,
    required this.surname,
  });

  factory AppleLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      AppleLoginRequestModel(
        secretKey: json["secretKey"],
        token: json["token"],
        name: json["name"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "token": token,
        "name": name,
        "surname": surname,
      };
}
