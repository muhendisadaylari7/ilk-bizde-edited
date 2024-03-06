// To parse this JSON data, do
//
//     final adsComplaintRequestModel = adsComplaintRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AdsComplaintRequestModel adsComplaintRequestModelFromJson(String str) =>
    AdsComplaintRequestModel.fromJson(json.decode(str));

String adsComplaintRequestModelToJson(AdsComplaintRequestModel data) =>
    json.encode(data.toJson());

class AdsComplaintRequestModel {
  String secretKey;
  String userEmail;
  String userPassword;
  String adId;
  String adComplaintType;
  String adComplaintDesc;

  AdsComplaintRequestModel({
    required this.secretKey,
    required this.userEmail,
    required this.userPassword,
    required this.adId,
    required this.adComplaintType,
    required this.adComplaintDesc,
  });

  factory AdsComplaintRequestModel.fromJson(Map<String, dynamic> json) =>
      AdsComplaintRequestModel(
        secretKey: json["secretKey"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        adId: json["adId"],
        adComplaintType: json["adComplaintType"],
        adComplaintDesc: json["adComplaintDesc"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "adId": adId,
        "adComplaintType": adComplaintType,
        "adComplaintDesc": adComplaintDesc,
      };
}
