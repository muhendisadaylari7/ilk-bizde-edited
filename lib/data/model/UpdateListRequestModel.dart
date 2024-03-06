// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UpdateListRequestModel getUpdateListRequestModelFromJson(String str) =>
    UpdateListRequestModel.fromJson(json.decode(str));

String getUpdateListRequestModelToJson(UpdateListRequestModel data) =>
    json.encode(data.toJson());

class UpdateListRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String listId;
  String newTitle;

  UpdateListRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.listId,
    required this.newTitle,
  });

  factory UpdateListRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateListRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        listId: json["listeId"],
        newTitle: json["yeniBaslik"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "listeId": listId,
        "yeniBaslik": newTitle,
      };
}
