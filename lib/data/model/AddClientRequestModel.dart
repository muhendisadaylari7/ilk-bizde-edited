// To parse this JSON data, do
//
//     final addClientRequestModel = addClientRequestModelFromJson(jsonString);

import 'dart:convert';

AddClientRequestModel addClientRequestModelFromJson(String str) =>
    AddClientRequestModel.fromJson(json.decode(str));

String addClientRequestModelToJson(AddClientRequestModel data) =>
    json.encode(data.toJson());

class AddClientRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String email;

  AddClientRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.email,
  });

  factory AddClientRequestModel.fromJson(Map<String, dynamic> json) =>
      AddClientRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "email": email,
      };
}
