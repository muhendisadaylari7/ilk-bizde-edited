// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) =>
    NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) =>
    json.encode(data.toJson());

class NotificationResponseModel {
  String notId;
  String? adTitle;
  String notification;
  String notificationDate;

  NotificationResponseModel({
    required this.notId,
    required this.adTitle,
    required this.notification,
    required this.notificationDate,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
        notId: json["notId"],
        adTitle: json["adTitle"] ?? "",
        notification: json["notification"],
        notificationDate: json["notificationDate"],
      );

  Map<String, dynamic> toJson() => {
        "notId": notId,
        "adTitle": adTitle,
        "notification": notification,
        "notificationDate": notificationDate,
      };
}
