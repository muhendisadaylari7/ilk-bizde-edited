// To parse this JSON data, do
//
//     final generalRequestModel = generalRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GeneralRequestModel generalRequestModelFromJson(String str) =>
    GeneralRequestModel.fromJson(json.decode(str));

String generalRequestModelToJson(GeneralRequestModel data) =>
    json.encode(data.toJson());

class GeneralRequestModel {
  String userId;
  String secretKey;
  String userEmail;
  String userPassword;
  String? pro;

  GeneralRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    this.pro,
  });

  factory GeneralRequestModel.fromJson(Map<String, dynamic> json) =>
      GeneralRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        pro: json["pro"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "pro": pro ?? "",
      };
}
