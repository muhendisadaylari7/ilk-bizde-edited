// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetBillingRequestModel getGetBillingRequestModelFromJson(String str) =>
    GetBillingRequestModel.fromJson(json.decode(str));

String getGetBillingRequestModelToJson(GetBillingRequestModel data) =>
    json.encode(data.toJson());

class GetBillingRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  GetBillingRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory GetBillingRequestModel.fromJson(Map<String, dynamic> json) =>
      GetBillingRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
      };
}
