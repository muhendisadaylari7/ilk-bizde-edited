// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) =>
    ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) =>
    json.encode(data.toJson());

class ChangePasswordModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String currentPassword;
  String newPassword;
  String newPassword2;

  ChangePasswordModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.currentPassword,
    required this.newPassword,
    required this.newPassword2,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        currentPassword: json["currentPassword"],
        newPassword: json["newPassword"],
        newPassword2: json["newPassword2"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "newPassword2": newPassword2,
      };
}
