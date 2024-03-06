// To parse this JSON data, do
//
//     final categoriesResponseModel = categoriesResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CategoriesResponseModel categoriesResponseModelFromJson(String str) =>
    CategoriesResponseModel.fromJson(json.decode(str));

String categoriesResponseModelToJson(CategoriesResponseModel data) =>
    json.encode(data.toJson());

class CategoriesResponseModel {
  String categoryId;
  String categoryName;
  String? categoryAltName;
  String? categoryAdCount;

  CategoriesResponseModel({
    required this.categoryId,
    required this.categoryName,
    this.categoryAltName,
    this.categoryAdCount,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoriesResponseModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        categoryAltName: json["categoryAltName"],
        categoryAdCount: json["categoryAdCount"],
      );

  Map<String, String> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "categoryAltName": categoryAltName ?? "",
        "categoryAdCount": categoryAdCount ?? "",
      };
}
