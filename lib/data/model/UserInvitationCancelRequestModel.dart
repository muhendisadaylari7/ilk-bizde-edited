// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserInvitationCancelRequestModel getUserInvitationCancelRequestModelFromJson(
        String str) =>
    UserInvitationCancelRequestModel.fromJson(json.decode(str));

String getUserInvitationCancelRequestModelToJson(
        UserInvitationCancelRequestModel data) =>
    json.encode(data.toJson());

class UserInvitationCancelRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String cancelledUserId;

  UserInvitationCancelRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.cancelledUserId,
  });

  factory UserInvitationCancelRequestModel.fromJson(
          Map<String, dynamic> json) =>
      UserInvitationCancelRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        cancelledUserId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "id": cancelledUserId,
      };
}
