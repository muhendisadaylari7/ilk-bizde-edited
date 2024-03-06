// To parse this JSON data, do
//
//     final cityRequestModel = cityRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CityRequestModel cityRequestModelFromJson(String str) =>
    CityRequestModel.fromJson(json.decode(str));

String cityRequestModelToJson(CityRequestModel data) =>
    json.encode(data.toJson());

class CityRequestModel {
  String countryCode;
  String secretKey;

  CityRequestModel({
    required this.countryCode,
    required this.secretKey,
  });

  factory CityRequestModel.fromJson(Map<String, dynamic> json) =>
      CityRequestModel(
        countryCode: json["countryCode"],
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "secretKey": secretKey,
      };
}
