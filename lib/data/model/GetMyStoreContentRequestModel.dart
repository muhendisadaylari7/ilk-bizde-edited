// To parse this JSON data, do
//
//     final getBusinessRequestModel = getMyStoreContentRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetMyStoreContentRequesetModel getMyStoreContentRequestModelFromJson(
        String str) =>
    GetMyStoreContentRequesetModel.fromJson(json.decode(str));

String getBusinessRequestModelToJson(GetMyStoreContentRequesetModel data) =>
    json.encode(data.toJson());

class GetMyStoreContentRequesetModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  GetMyStoreContentRequesetModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory GetMyStoreContentRequesetModel.fromJson(Map<String, dynamic> json) =>
      GetMyStoreContentRequesetModel(
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
