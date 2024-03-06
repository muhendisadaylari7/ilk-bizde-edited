// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DeleteListRequestModel getDeleteListRequestModelFromJson(String str) =>
    DeleteListRequestModel.fromJson(json.decode(str));

String getDeleteListRequestModelToJson(DeleteListRequestModel data) =>
    json.encode(data.toJson());

class DeleteListRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String listId;

  DeleteListRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.listId,
  });

  factory DeleteListRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteListRequestModel(
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
