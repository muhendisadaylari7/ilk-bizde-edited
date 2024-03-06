// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CreateNewListRequestModel getCreateNewListRequestModelFromJson(String str) =>
    CreateNewListRequestModel.fromJson(json.decode(str));

String getCreateNewListRequestModelToJson(CreateNewListRequestModel data) =>
    json.encode(data.toJson());

class CreateNewListRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String title;

  CreateNewListRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.title,
  });

  factory CreateNewListRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateNewListRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        title: json["baslik"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "baslik": title,
      };
}
