// To parse this JSON data, do
//
//     final last24HourRequestModel = last24HourRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Last24HourRequestModel last24HourRequestModelFromJson(String str) =>
    Last24HourRequestModel.fromJson(json.decode(str));

String last24HourRequestModelToJson(Last24HourRequestModel data) =>
    json.encode(data.toJson());

class Last24HourRequestModel {
  String secretKey;
  String userId;
  String userPassword;
  String userEmail;
  String categoryId;

  Last24HourRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userPassword,
    required this.userEmail,
    required this.categoryId,
  });

  factory Last24HourRequestModel.fromJson(Map<String, dynamic> json) =>
      Last24HourRequestModel(
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
