// To parse this JSON data, do
//
//     final openMarketCategoriesRequestModel = openMarketCategoriesRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

OpenMarketCategoriesRequestModel openMarketCategoriesRequestModelFromJson(
        String str) =>
    OpenMarketCategoriesRequestModel.fromJson(json.decode(str));

String openMarketCategoriesRequestModelToJson(
        OpenMarketCategoriesRequestModel data) =>
    json.encode(data.toJson());

class OpenMarketCategoriesRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String asama;

  OpenMarketCategoriesRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.asama,
  });

  factory OpenMarketCategoriesRequestModel.fromJson(
          Map<String, dynamic> json) =>
      OpenMarketCategoriesRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        asama: json["asama"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "asama": asama,
      };
}
