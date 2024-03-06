// To parse this JSON data, do
//
//     final advertisementDetailRequestModel = advertisementDetailRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AdvertisementDetailRequestModel advertisementDetailRequestModelFromJson(
        String str) =>
    AdvertisementDetailRequestModel.fromJson(json.decode(str));

String advertisementDetailRequestModelToJson(
        AdvertisementDetailRequestModel data) =>
    json.encode(data.toJson());

class AdvertisementDetailRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String adId;

  AdvertisementDetailRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.adId,
  });

  factory AdvertisementDetailRequestModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementDetailRequestModel(
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
