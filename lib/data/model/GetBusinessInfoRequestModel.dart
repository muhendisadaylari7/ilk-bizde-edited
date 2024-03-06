// To parse this JSON data, do
//
//     final getBusinessRequestModel = getBusinessRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetBusinessRequesetModel getBusinessRequestModelFromJson(String str) =>
    GetBusinessRequesetModel.fromJson(json.decode(str));

String getBusinessRequestModelToJson(GetBusinessRequesetModel data) =>
    json.encode(data.toJson());

class GetBusinessRequesetModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  GetBusinessRequesetModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory GetBusinessRequesetModel.fromJson(Map<String, dynamic> json) =>
      GetBusinessRequesetModel(
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
