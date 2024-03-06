// To parse this JSON data, do
//
//     final blogDetailRequestModel = blogDetailRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

BlogDetailRequestModel blogDetailRequestModelFromJson(String str) =>
    BlogDetailRequestModel.fromJson(json.decode(str));

String blogDetailRequestModelToJson(BlogDetailRequestModel data) =>
    json.encode(data.toJson());

class BlogDetailRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String blogId;

  BlogDetailRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.blogId,
  });

  factory BlogDetailRequestModel.fromJson(Map<String, dynamic> json) =>
      BlogDetailRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        blogId: json["blogId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "blogId": blogId,
      };
}
