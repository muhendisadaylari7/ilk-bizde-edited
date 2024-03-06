// To parse this JSON data, do
//
//     final phoneNumberSaveModel = phoneNumberSaveModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PhoneNumberSaveModel phoneNumberSaveModelFromJson(String str) =>
    PhoneNumberSaveModel.fromJson(json.decode(str));

String phoneNumberSaveModelToJson(PhoneNumberSaveModel data) =>
    json.encode(data.toJson());

class PhoneNumberSaveModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String telNo;
  String telOnay;

  PhoneNumberSaveModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.telNo,
    required this.telOnay,
  });

  factory PhoneNumberSaveModel.fromJson(Map<String, dynamic> json) =>
      PhoneNumberSaveModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        telNo: json["telNo"],
        telOnay: json["telOnay"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "telNo": telNo,
        "telOnay": telOnay,
      };
}
