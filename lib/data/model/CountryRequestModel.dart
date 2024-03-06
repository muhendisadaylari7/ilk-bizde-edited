// To parse this JSON data, do
//
//     final countryRequestModel = countryRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CountryRequestModel countryRequestModelFromJson(String str) =>
    CountryRequestModel.fromJson(json.decode(str));

String countryRequestModelToJson(CountryRequestModel data) =>
    json.encode(data.toJson());

class CountryRequestModel {
  String secretKey;

  CountryRequestModel({
    required this.secretKey,
  });

  factory CountryRequestModel.fromJson(Map<String, dynamic> json) =>
      CountryRequestModel(
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
      };
}
