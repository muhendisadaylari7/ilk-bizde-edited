// To parse this JSON data, do
//
//     final subCategoriesRequestModel = subCategoriesRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SubCategoriesRequestModel subCategoriesRequestModelFromJson(String str) =>
    SubCategoriesRequestModel.fromJson(json.decode(str));

String subCategoriesRequestModelToJson(SubCategoriesRequestModel data) =>
    json.encode(data.toJson());

class SubCategoriesRequestModel {
  String secretKey;
  String categoryId;
  String? pro;

  SubCategoriesRequestModel({
    required this.secretKey,
    required this.categoryId,
    this.pro,
  });

  factory SubCategoriesRequestModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesRequestModel(
        secretKey: json["secretKey"],
        categoryId: json["categoryId"],
        pro: json["pro"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "categoryId": categoryId,
        "pro": pro,
      };
}
