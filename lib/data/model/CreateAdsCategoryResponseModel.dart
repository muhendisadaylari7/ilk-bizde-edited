// To parse this JSON data, do
//
//     final createAdsCategoryResponseModel = createAdsCategoryResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CreateAdsCategoryResponseModel createAdsCategoryResponseModelFromJson(
        String str) =>
    CreateAdsCategoryResponseModel.fromJson(json.decode(str));

String createAdsCategoryResponseModelToJson(
        CreateAdsCategoryResponseModel data) =>
    json.encode(data.toJson());

class CreateAdsCategoryResponseModel {
  String categoryId;
  String categoryName;

  CreateAdsCategoryResponseModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory CreateAdsCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateAdsCategoryResponseModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
      };
}
