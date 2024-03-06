// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetListAdsRequestModel getGetListAdsRequestModelFromJson(String str) =>
    GetListAdsRequestModel.fromJson(json.decode(str));

String getGetListAdsRequestModelToJson(GetListAdsRequestModel data) =>
    json.encode(data.toJson());

class GetListAdsRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String listId;

  GetListAdsRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.listId,
  });

  factory GetListAdsRequestModel.fromJson(Map<String, dynamic> json) =>
      GetListAdsRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        listId: json["listeId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "listeId": listId,
      };
}
