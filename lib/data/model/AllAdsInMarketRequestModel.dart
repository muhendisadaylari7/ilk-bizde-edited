// To parse this JSON data, do
//
//     final allAdsInMarketRequestModel = allAdsInMarketRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AllAdsInMarketRequestModel allAdsInMarketRequestModelFromJson(String str) =>
    AllAdsInMarketRequestModel.fromJson(json.decode(str));

String allAdsInMarketRequestModelToJson(AllAdsInMarketRequestModel data) =>
    json.encode(data.toJson());

class AllAdsInMarketRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String magazaId;

  AllAdsInMarketRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.magazaId,
  });

  factory AllAdsInMarketRequestModel.fromJson(Map<String, dynamic> json) =>
      AllAdsInMarketRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        magazaId: json["magazaId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "magazaId": magazaId,
      };
}
