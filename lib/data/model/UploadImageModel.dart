// To parse this JSON data, do
//
//     final uploadImageModel = uploadImageModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UploadImageModel uploadImageModelFromJson(String str) =>
    UploadImageModel.fromJson(json.decode(str));

String uploadImageModelToJson(UploadImageModel data) =>
    json.encode(data.toJson());

class UploadImageModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String newPhoto;

  UploadImageModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.newPhoto,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      UploadImageModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        newPhoto: json["newPhoto"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "newPhoto": newPhoto,
      };
}
