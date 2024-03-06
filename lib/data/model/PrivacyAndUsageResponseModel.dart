// To parse this JSON data, do
//
//     final privacyAndUsageResponseModel = privacyAndUsageResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<PrivacyAndUsageResponseModel> privacyAndUsageResponseModelFromJson(
        String str) =>
    List<PrivacyAndUsageResponseModel>.from(
        json.decode(str).map((x) => PrivacyAndUsageResponseModel.fromJson(x)));

String privacyAndUsageResponseModelToJson(
        List<PrivacyAndUsageResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrivacyAndUsageResponseModel {
  String title;
  String content;

  PrivacyAndUsageResponseModel({
    required this.title,
    required this.content,
  });

  factory PrivacyAndUsageResponseModel.fromJson(Map<String, dynamic> json) =>
      PrivacyAndUsageResponseModel(
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
