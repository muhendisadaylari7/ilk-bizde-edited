// To parse this JSON data, do
//
//     final neighborhoodRequestModel = neighborhoodRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

NeighborhoodRequestModel neighborhoodRequestModelFromJson(String str) =>
    NeighborhoodRequestModel.fromJson(json.decode(str));

String neighborhoodRequestModelToJson(NeighborhoodRequestModel data) =>
    json.encode(data.toJson());

class NeighborhoodRequestModel {
  String secretKey;
  String distinctId;

  NeighborhoodRequestModel({
    required this.secretKey,
    required this.distinctId,
  });

  factory NeighborhoodRequestModel.fromJson(Map<String, dynamic> json) =>
      NeighborhoodRequestModel(
        secretKey: json["secretKey"],
        distinctId: json["distinctId"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "distinctId": distinctId,
      };
}
