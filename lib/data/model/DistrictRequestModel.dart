// To parse this JSON data, do
//
//     final districtRequestModel = districtRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DistrictRequestModel districtRequestModelFromJson(String str) =>
    DistrictRequestModel.fromJson(json.decode(str));

String districtRequestModelToJson(DistrictRequestModel data) =>
    json.encode(data.toJson());

class DistrictRequestModel {
  String cityId;
  String secretKey;

  DistrictRequestModel({
    required this.cityId,
    required this.secretKey,
  });

  factory DistrictRequestModel.fromJson(Map<String, dynamic> json) =>
      DistrictRequestModel(
        cityId: json["cityId"],
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "cityId": cityId,
        "secretKey": secretKey,
      };
}
