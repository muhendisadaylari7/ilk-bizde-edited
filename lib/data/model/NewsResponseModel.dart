// To parse this JSON data, do
//
//     final newsResponseModel = newsResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

NewsResponseModel newsResponseModelFromJson(String str) =>
    NewsResponseModel.fromJson(json.decode(str));

String newsResponseModelToJson(NewsResponseModel data) =>
    json.encode(data.toJson());

class NewsResponseModel {
  String id;
  String subject;
  String desc;
  String pics;
  String addedDate;

  NewsResponseModel({
    required this.id,
    required this.subject,
    required this.desc,
    required this.pics,
    required this.addedDate,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsResponseModel(
        id: json["id"],
        subject: json["subject"],
        desc: json["desc"],
        pics: json["pics"],
        addedDate: json["addedDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "desc": desc,
        "pics": pics,
        "addedDate": addedDate,
      };
}
