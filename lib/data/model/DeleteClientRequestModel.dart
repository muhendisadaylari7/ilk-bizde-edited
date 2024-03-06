// To parse this JSON data, do
//
//     final deleteClientRequestModel = deleteClientRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DeleteClientRequestModel deleteClientRequestModelFromJson(String str) =>
    DeleteClientRequestModel.fromJson(json.decode(str));

String deleteClientRequestModelToJson(DeleteClientRequestModel data) =>
    json.encode(data.toJson());

class DeleteClientRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String id;

  DeleteClientRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.id,
  });

  factory DeleteClientRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteClientRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "id": id,
      };
}
