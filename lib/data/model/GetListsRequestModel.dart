// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GetListsRequestModel getGetListsRequestModelFromJson(String str) =>
    GetListsRequestModel.fromJson(json.decode(str));

String getGetListsRequestModelToJson(GetListsRequestModel data) =>
    json.encode(data.toJson());

class GetListsRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  GetListsRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory GetListsRequestModel.fromJson(Map<String, dynamic> json) =>
      GetListsRequestModel(
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
