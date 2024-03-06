// To parse this JSON data, do
//
//     final createAdsRequestModel = createAdsRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CreateAdsRequestModel createAdsRequestModelFromJson(String str) =>
    CreateAdsRequestModel.fromJson(json.decode(str));

String createAdsRequestModelToJson(CreateAdsRequestModel data) =>
    json.encode(data.toJson());

class CreateAdsRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String categoryId;

  CreateAdsRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.categoryId,
  });

  factory CreateAdsRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateAdsRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "categoryId": categoryId,
      };
}
