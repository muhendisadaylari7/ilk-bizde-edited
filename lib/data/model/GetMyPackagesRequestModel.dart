// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetMyPackagesRequestModel getGetMyPackagesRequestModelFromJson(String str) =>
    GetMyPackagesRequestModel.fromJson(json.decode(str));

String getGetMyPackagesRequestModelToJson(GetMyPackagesRequestModel data) =>
    json.encode(data.toJson());

class GetMyPackagesRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  GetMyPackagesRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory GetMyPackagesRequestModel.fromJson(Map<String, dynamic> json) =>
      GetMyPackagesRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
      };
}
