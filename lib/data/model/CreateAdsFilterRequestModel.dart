// To parse this JSON data, do
//
//     final createAdsFilterRequestModel = createAdsFilterRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CreateAdsFilterRequestModel createAdsFilterRequestModelFromJson(String str) =>
    CreateAdsFilterRequestModel.fromJson(json.decode(str));

String createAdsFilterRequestModelToJson(CreateAdsFilterRequestModel data) =>
    json.encode(data.toJson());

class CreateAdsFilterRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String category1;
  String category2;
  String category3;
  String category4;
  String category5;
  String category6;
  String category7;
  String category8;
  String fiyat;

  CreateAdsFilterRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
    required this.category6,
    required this.category7,
    required this.category8,
    required this.fiyat,
  });

  factory CreateAdsFilterRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateAdsFilterRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        category1: json["category_1"],
        category2: json["category_2"],
        category3: json["category_3"],
        category4: json["category_4"],
        category5: json["category_5"],
        category6: json["category_6"],
        category7: json["category_7"],
        category8: json["category_8"],
        fiyat: json["fiyat"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "category_1": category1,
        "category_2": category2,
        "category_3": category3,
        "category_4": category4,
        "category_5": category5,
        "category_6": category6,
        "category_7": category7,
        "category_8": category8,
        "fiyat": fiyat,
      };
}
