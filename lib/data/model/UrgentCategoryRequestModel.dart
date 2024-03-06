// To parse this JSON data, do
//
//     final urgentCategoryRequestModel = urgentCategoryRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UrgentCategoryRequestModel urgentCategoryRequestModelFromJson(String str) =>
    UrgentCategoryRequestModel.fromJson(json.decode(str));

String urgentCategoryRequestModelToJson(UrgentCategoryRequestModel data) =>
    json.encode(data.toJson());

class UrgentCategoryRequestModel {
  String secretKey;
  String userId;
  String userPassword;
  String userEmail;
  String categoryId;

  UrgentCategoryRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userPassword,
    required this.userEmail,
    required this.categoryId,
  });

  factory UrgentCategoryRequestModel.fromJson(Map<String, dynamic> json) =>
      UrgentCategoryRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userPassword: json["userPassword"],
        userEmail: json["userEmail"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userPassword": userPassword,
        "userEmail": userEmail,
        "categoryId": categoryId,
      };
}
