// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DeleteAdFromListRequestModel getDeleteAdFromListRequestModelFromJson(
        String str) =>
    DeleteAdFromListRequestModel.fromJson(json.decode(str));

String getDeleteAdFromListRequestModelToJson(
        DeleteAdFromListRequestModel data) =>
    json.encode(data.toJson());

class DeleteAdFromListRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String listAdsId;

  DeleteAdFromListRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.listAdsId,
  });

  factory DeleteAdFromListRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteAdFromListRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        listAdsId: json["listAdsId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "listAdsId": listAdsId,
      };
}
