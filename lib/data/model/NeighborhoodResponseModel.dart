// To parse this JSON data, do
//
//     final neighborhoodResponseModel = neighborhoodResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

NeighborhoodResponseModel neighborhoodResponseModelFromJson(String str) =>
    NeighborhoodResponseModel.fromJson(json.decode(str));

String neighborhoodResponseModelToJson(NeighborhoodResponseModel data) =>
    json.encode(data.toJson());

class NeighborhoodResponseModel {
  String id;
  String name;
  String semtId;
  String semtName;

  NeighborhoodResponseModel({
    required this.id,
    required this.name,
    required this.semtId,
    required this.semtName,
  });

  factory NeighborhoodResponseModel.fromJson(Map<String, dynamic> json) =>
      NeighborhoodResponseModel(
        id: json["id"],
        name: json["name"],
        semtId: json["semtId"],
        semtName: json["semtName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "semtId": semtId,
        "semtName": semtName,
      };
}
