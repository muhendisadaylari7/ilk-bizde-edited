// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

InvateUserRequestModel getInvateUserRequestModelFromJson(String str) =>
    InvateUserRequestModel.fromJson(json.decode(str));

String getInvateUserRequestModelToJson(InvateUserRequestModel data) =>
    json.encode(data.toJson());

class InvateUserRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String invitedUserEmail;

  InvateUserRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.invitedUserEmail,
  });

  factory InvateUserRequestModel.fromJson(Map<String, dynamic> json) =>
      InvateUserRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        invitedUserEmail: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "email": invitedUserEmail,
      };
}
