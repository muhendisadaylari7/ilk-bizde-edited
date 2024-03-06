// To parse this JSON data, do
//
//     final newsDetailResponseModel = newsDetailResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

NewsDetailResponseModel newsDetailResponseModelFromJson(String str) =>
    NewsDetailResponseModel.fromJson(json.decode(str));

String newsDetailResponseModelToJson(NewsDetailResponseModel data) =>
    json.encode(data.toJson());

class NewsDetailResponseModel {
  String subject;
  String desc;
  String pics;
  String addedDate;

  NewsDetailResponseModel({
    required this.subject,
    required this.desc,
    required this.pics,
    required this.addedDate,
  });

  factory NewsDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailResponseModel(
        subject: json["subject"],
        desc: json["desc"],
        pics: json["pics"],
        addedDate: json["addedDate"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "desc": desc,
        "pics": pics,
        "addedDate": addedDate,
      };
}
