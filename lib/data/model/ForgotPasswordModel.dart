// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) =>
    ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) =>
    json.encode(data.toJson());

class ForgotPasswordModel {
  String email;
  String secretKey;

  ForgotPasswordModel({
    required this.email,
    required this.secretKey,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        email: json["email"],
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "secretKey": secretKey,
      };
}
