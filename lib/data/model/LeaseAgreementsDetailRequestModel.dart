// To parse this JSON data, do
//
//     final leaseAgreementsDetailRequestModel = leaseAgreementsDetailRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

LeaseAgreementsDetailRequestModel leaseAgreementsDetailRequestModelFromJson(
        String str) =>
    LeaseAgreementsDetailRequestModel.fromJson(json.decode(str));

String leaseAgreementsDetailRequestModelToJson(
        LeaseAgreementsDetailRequestModel data) =>
    json.encode(data.toJson());

class LeaseAgreementsDetailRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String sozlesmeId;

  LeaseAgreementsDetailRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.sozlesmeId,
  });

  factory LeaseAgreementsDetailRequestModel.fromJson(
          Map<String, dynamic> json) =>
      LeaseAgreementsDetailRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        sozlesmeId: json["sozlesmeId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "sozlesmeId": sozlesmeId,
      };
}
