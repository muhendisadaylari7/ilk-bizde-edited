// To parse this JSON data, do
//
//     final categoriesRequestModel = categoriesRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CategoriesRequestModel categoriesRequestModelFromJson(String str) =>
    CategoriesRequestModel.fromJson(json.decode(str));

String categoriesRequestModelToJson(CategoriesRequestModel data) =>
    json.encode(data.toJson());

class CategoriesRequestModel {
  String secretKey;
  String? pro;

  CategoriesRequestModel({
    required this.secretKey,
    this.pro,
  });

  factory CategoriesRequestModel.fromJson(Map<String, dynamic> json) =>
      CategoriesRequestModel(
        secretKey: json["secretKey"],
        pro: json["pro"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "pro": pro,
      };
}
