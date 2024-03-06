// To parse this JSON data, do
//
//     final photoAndVideoInfosRequestModel = photoAndVideoInfosRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PhotoAndVideoInfosRequestModel photoAndVideoInfosRequestModelFromJson(
        String str) =>
    PhotoAndVideoInfosRequestModel.fromJson(json.decode(str));

String photoAndVideoInfosRequestModelToJson(
        PhotoAndVideoInfosRequestModel data) =>
    json.encode(data.toJson());

class PhotoAndVideoInfosRequestModel {
  String secretKey;
  String? adId;
  String userId;
  String userEmail;
  String userPassword;
  String category1;
  String category2;
  String category3;
  String category4;
  String category5;
  String category6;
  String category7;
  String category8;
  String asama;
  String resim_kod;

  PhotoAndVideoInfosRequestModel({
    required this.secretKey,
    this.adId,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
    required this.category6,
    required this.category7,
    required this.category8,
    required this.asama,
    required this.resim_kod,
  });

  factory PhotoAndVideoInfosRequestModel.fromJson(Map<String, dynamic> json) =>
      PhotoAndVideoInfosRequestModel(
        secretKey: json["secretKey"],
        adId: json["adId"] ?? "",
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        category1: json["category1"],
        category2: json["category2"],
        category3: json["category3"],
        category4: json["category4"],
        category5: json["category5"],
        category6: json["category6"],
        category7: json["category7"],
        category8: json["category8"],
        asama: json["asama"],
        resim_kod: json["resim_kod"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "adId": adId,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "category1": category1,
        "category2": category2,
        "category3": category3,
        "category4": category4,
        "category5": category5,
        "category6": category6,
        "category7": category7,
        "category8": category8,
        "asama": asama,
        "resim_kod": resim_kod,
      };
}
