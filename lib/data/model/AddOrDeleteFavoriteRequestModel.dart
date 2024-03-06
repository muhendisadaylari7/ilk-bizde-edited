// To parse this JSON data, do
//
//     final addOrDeleteFavoriteRequestModel = addOrDeleteFavoriteRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AddOrDeleteFavoriteRequestModel addOrDeleteFavoriteRequestModelFromJson(
        String str) =>
    AddOrDeleteFavoriteRequestModel.fromJson(json.decode(str));

String addOrDeleteFavoriteRequestModelToJson(
        AddOrDeleteFavoriteRequestModel data) =>
    json.encode(data.toJson());

class AddOrDeleteFavoriteRequestModel {
  String id;
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;

  AddOrDeleteFavoriteRequestModel({
    required this.id,
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  factory AddOrDeleteFavoriteRequestModel.fromJson(Map<String, dynamic> json) =>
      AddOrDeleteFavoriteRequestModel(
        id: json["id"],
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
      };
}
