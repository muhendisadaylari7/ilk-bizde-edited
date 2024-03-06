// To parse this JSON data, do
//
//     final blogResponseModel = blogResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

BlogResponseModel blogResponseModelFromJson(String str) =>
    BlogResponseModel.fromJson(json.decode(str));

String blogResponseModelToJson(BlogResponseModel data) =>
    json.encode(data.toJson());

class BlogResponseModel {
  String id;
  String owner;
  String subject;
  String desc;
  String pics;
  String addedDate;

  BlogResponseModel({
    required this.id,
    required this.owner,
    required this.subject,
    required this.desc,
    required this.pics,
    required this.addedDate,
  });

  factory BlogResponseModel.fromJson(Map<String, dynamic> json) =>
      BlogResponseModel(
        id: json["id"],
        owner: json["owner"],
        subject: json["subject"],
        desc: json["desc"],
        pics: json["pics"],
        addedDate: json["addedDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner": owner,
        "subject": subject,
        "desc": desc,
        "pics": pics,
        "addedDate": addedDate,
      };
}
