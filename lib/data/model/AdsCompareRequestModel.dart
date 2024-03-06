// To parse this JSON data, do
//
//     final adsCompareRequestModel = adsCompareRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AdsCompareRequestModel adsCompareRequestModelFromJson(String str) =>
    AdsCompareRequestModel.fromJson(json.decode(str));

String adsCompareRequestModelToJson(AdsCompareRequestModel data) =>
    json.encode(data.toJson());

class AdsCompareRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String adId;

  AdsCompareRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.adId,
  });

  factory AdsCompareRequestModel.fromJson(Map<String, dynamic> json) =>
      AdsCompareRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        adId: json["adId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "adId": adId,
      };
}
