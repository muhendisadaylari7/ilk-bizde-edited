// To parse this JSON data, do
//
//     final categoryFilterResponseModel = categoryFilterResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CategoryFilterResponseModel categoryFilterResponseModelFromJson(String str) =>
    CategoryFilterResponseModel.fromJson(json.decode(str));

String categoryFilterResponseModelToJson(CategoryFilterResponseModel data) =>
    json.encode(data.toJson());

class CategoryFilterResponseModel {
  String filterId;
  String filterName;
  String filterParamName;
  String filterType;
  String filterChoises;
  String filterMultiple;
  String fieldsMultipleName;
  String fieldsMaxMin;
  String? fields8;
  String? fieldsRequired;

  CategoryFilterResponseModel({
    required this.filterId,
    required this.filterName,
    required this.filterParamName,
    required this.filterType,
    required this.filterChoises,
    required this.filterMultiple,
    required this.fieldsMultipleName,
    required this.fieldsMaxMin,
    this.fields8,
    this.fieldsRequired,
  });

  factory CategoryFilterResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryFilterResponseModel(
        filterId: json["filterId"],
        filterName: json["filterName"],
        filterParamName: json["filterParamName"],
        filterType: json["filterType"],
        filterChoises: json["filterChoises"],
        filterMultiple: json["filterMultiple"],
        fieldsMultipleName: json["fieldsMultipleName"],
        fieldsMaxMin: json["fieldsMaxMin"],
        fields8: json["fields8"] ?? "",
        fieldsRequired: json["fieldsRequired"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "filterId": filterId,
        "filterName": filterName,
        "filterParamName": filterParamName,
        "filterType": filterType,
        "filterChoises": filterChoises,
        "filterMultiple": filterMultiple,
        "fieldsMultipleName": fieldsMultipleName,
        "fieldsMaxMin": fieldsMaxMin,
        "fields8": fields8 ?? "",
        "fieldsRequired": fieldsRequired ?? "",
      };
}
