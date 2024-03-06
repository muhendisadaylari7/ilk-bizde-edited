// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetAdsRequestModel getGetAdsRequestModelFromJson(String str) =>
    GetAdsRequestModel.fromJson(json.decode(str));

String getGetAdsRequestModelToJson(GetAdsRequestModel data) =>
    json.encode(data.toJson());

class GetAdsRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  GetAdsRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory GetAdsRequestModel.fromJson(Map<String, dynamic> json) =>
      GetAdsRequestModel(
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
