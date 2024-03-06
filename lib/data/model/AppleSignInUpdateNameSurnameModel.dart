// To parse this JSON data, do
//
//     final appleSignInUpdateNameSurnameModel = appleSignInUpdateNameSurnameModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AppleSignInUpdateNameSurnameModel appleSignInUpdateNameSurnameModelFromJson(
        String str) =>
    AppleSignInUpdateNameSurnameModel.fromJson(json.decode(str));

String appleSignInUpdateNameSurnameModelToJson(
        AppleSignInUpdateNameSurnameModel data) =>
    json.encode(data.toJson());

class AppleSignInUpdateNameSurnameModel {
  String secretKey;
  String userId;
  String ad;
  String soyad;

  AppleSignInUpdateNameSurnameModel({
    required this.secretKey,
    required this.userId,
    required this.ad,
    required this.soyad,
  });

  factory AppleSignInUpdateNameSurnameModel.fromJson(
          Map<String, dynamic> json) =>
      AppleSignInUpdateNameSurnameModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        ad: json["ad"],
        soyad: json["soyad"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "ad": ad,
        "soyad": soyad,
      };
}
