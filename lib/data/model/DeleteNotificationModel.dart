// To parse this JSON data, do
//
//     final deleteNotificationModel = deleteNotificationModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DeleteNotificationModel deleteNotificationModelFromJson(String str) =>
    DeleteNotificationModel.fromJson(json.decode(str));

String deleteNotificationModelToJson(DeleteNotificationModel data) =>
    json.encode(data.toJson());

class DeleteNotificationModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String notId;

  DeleteNotificationModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.notId,
  });

  factory DeleteNotificationModel.fromJson(Map<String, dynamic> json) =>
      DeleteNotificationModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        notId: json["notId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "notId": notId,
      };
}
