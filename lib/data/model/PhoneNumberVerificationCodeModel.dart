// To parse this JSON data, do
//
//     final phoneNumberVerificationCodeModel = phoneNumberVerificationCodeModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PhoneNumberVerificationCodeModel phoneNumberVerificationCodeModelFromJson(
        String str) =>
    PhoneNumberVerificationCodeModel.fromJson(json.decode(str));

String phoneNumberVerificationCodeModelToJson(
        PhoneNumberVerificationCodeModel data) =>
    json.encode(data.toJson());

class PhoneNumberVerificationCodeModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String telNo;

  PhoneNumberVerificationCodeModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.telNo,
  });

  factory PhoneNumberVerificationCodeModel.fromJson(
          Map<String, dynamic> json) =>
      PhoneNumberVerificationCodeModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        telNo: json["telNo"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "telNo": telNo,
      };
}
