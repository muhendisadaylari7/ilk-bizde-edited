// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

RemoveUserRequestModel getRemoveUserRequestModelFromJson(String str) =>
    RemoveUserRequestModel.fromJson(json.decode(str));

String getRemoveUserRequestModelToJson(RemoveUserRequestModel data) =>
    json.encode(data.toJson());

class RemoveUserRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String removedUserId;
  String selectedUserId;

  RemoveUserRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.removedUserId,
    required this.selectedUserId,
  });

  factory RemoveUserRequestModel.fromJson(Map<String, dynamic> json) =>
      RemoveUserRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        removedUserId: json["id"],
        selectedUserId: json["seciliKullanici"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "id": removedUserId,
        "seciliKullanici": selectedUserId,
      };
}
