// To parse this JSON data, do
//
//     final getBusinessRequestModel = getStoreTotalVisitorNumberRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetStoreTotalVisitorNumberRequestModel
    getStoreTotalVisitorNumberRequestModelFromJson(String str) =>
        GetStoreTotalVisitorNumberRequestModel.fromJson(json.decode(str));

String getBusinessRequestModelToJson(
        GetStoreTotalVisitorNumberRequestModel data) =>
    json.encode(data.toJson());

class GetStoreTotalVisitorNumberRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String storeId;

  GetStoreTotalVisitorNumberRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.storeId,
  });

  factory GetStoreTotalVisitorNumberRequestModel.fromJson(
          Map<String, dynamic> json) =>
      GetStoreTotalVisitorNumberRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        storeId: json["magazaId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "magazaId": storeId,
      };
}
