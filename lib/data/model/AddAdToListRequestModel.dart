// To parse this JSON data, do
//
//     final getUsersRequestModel = getUsersRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AddAdToListRequestModel getAddAdToListRequestModelFromJson(String str) =>
    AddAdToListRequestModel.fromJson(json.decode(str));

String getAddAdToListRequestModelToJson(AddAdToListRequestModel data) =>
    json.encode(data.toJson());

class AddAdToListRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String listId;
  String adId;

  AddAdToListRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.listId,
    required this.adId,
  });

  factory AddAdToListRequestModel.fromJson(Map<String, dynamic> json) =>
      AddAdToListRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        listId: json["listeId"],
        adId: json["ilanId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "listeId": listId,
        "ilanId": adId,
      };
}
