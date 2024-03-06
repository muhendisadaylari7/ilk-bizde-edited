// To parse this JSON data, do
//
//     final newsDetailRequestModel = newsDetailRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

NewsDetailRequestModel newsDetailRequestModelFromJson(String str) =>
    NewsDetailRequestModel.fromJson(json.decode(str));

String newsDetailRequestModelToJson(NewsDetailRequestModel data) =>
    json.encode(data.toJson());

class NewsDetailRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String newsId;

  NewsDetailRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.newsId,
  });

  factory NewsDetailRequestModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        newsId: json["newsId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "newsId": newsId,
      };
}
