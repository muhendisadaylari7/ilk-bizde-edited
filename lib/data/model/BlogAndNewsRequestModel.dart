// To parse this JSON data, do
//
//     final blogAndNewsRequestModel = blogAndNewsRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

BlogAndNewsRequestModel blogAndNewsRequestModelFromJson(String str) =>
    BlogAndNewsRequestModel.fromJson(json.decode(str));

String blogAndNewsRequestModelToJson(BlogAndNewsRequestModel data) =>
    json.encode(data.toJson());

class BlogAndNewsRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String page;

  BlogAndNewsRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.page,
  });

  factory BlogAndNewsRequestModel.fromJson(Map<String, dynamic> json) =>
      BlogAndNewsRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "page": page,
      };
}
