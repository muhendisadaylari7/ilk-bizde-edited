// To parse this JSON data, do
//
//     final counselorResponseModel = counselorResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<CounselorResponseModel> counselorResponseModelFromJson(String str) =>
    List<CounselorResponseModel>.from(
        json.decode(str).map((x) => CounselorResponseModel.fromJson(x)));

String counselorResponseModelToJson(List<CounselorResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CounselorResponseModel {
  String id;
  String email;

  CounselorResponseModel({
    required this.id,
    required this.email,
  });

  factory CounselorResponseModel.fromJson(Map<String, dynamic> json) =>
      CounselorResponseModel(
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}
