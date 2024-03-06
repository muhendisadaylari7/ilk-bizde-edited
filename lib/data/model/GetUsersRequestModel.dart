// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetUsersRequesetModel getUsersRequestModelFromJson(String str) =>
    GetUsersRequesetModel.fromJson(json.decode(str));

String getUsersRequestModelToJson(GetUsersRequesetModel data) =>
    json.encode(data.toJson());

class GetUsersRequesetModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  GetUsersRequesetModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory GetUsersRequesetModel.fromJson(Map<String, dynamic> json) =>
      GetUsersRequesetModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword
      };
}
