// To parse this JSON data, do
//
//     final deleteAdsVideoRequestModel = deleteAdsVideoRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DeleteAdsVideoRequestModel deleteAdsVideoRequestModelFromJson(String str) =>
    DeleteAdsVideoRequestModel.fromJson(json.decode(str));

String deleteAdsVideoRequestModelToJson(DeleteAdsVideoRequestModel data) =>
    json.encode(data.toJson());

class DeleteAdsVideoRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String adId;

  DeleteAdsVideoRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.adId,
  });

  factory DeleteAdsVideoRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteAdsVideoRequestModel(
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
