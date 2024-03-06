// To parse this JSON data, do
//
//     final dopingInfosRequestModel = dopingInfosRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DopingInfosRequestModel dopingInfosRequestModelFromJson(String str) =>
    DopingInfosRequestModel.fromJson(json.decode(str));

String dopingInfosRequestModelToJson(DopingInfosRequestModel data) =>
    json.encode(data.toJson());

class DopingInfosRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String category1;
  String category2;
  String category3;
  String category4;
  String category5;
  String category6;
  String category7;
  String category8;
  String asama;
  String doping1;
  String doping2;
  String doping3;
  String doping4;
  String doping5;
  String doping6;
  String doping7;
  String doping14;
  String fiyat;

  DopingInfosRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
    required this.category6,
    required this.category7,
    required this.category8,
    required this.asama,
    required this.doping1,
    required this.doping2,
    required this.doping3,
    required this.doping4,
    required this.doping5,
    required this.doping6,
    required this.doping7,
    required this.doping14,
    required this.fiyat,
  });

  factory DopingInfosRequestModel.fromJson(Map<String, dynamic> json) =>
      DopingInfosRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        category1: json["category_1"],
        category2: json["category_2"],
        category3: json["category_3"],
        category4: json["category_4"],
        category5: json["category_5"],
        category6: json["category_6"],
        category7: json["category_7"],
        category8: json["category_8"],
        asama: json["asama"],
        doping1: json["doping_1"],
        doping2: json["doping_2"],
        doping3: json["doping_3"],
        doping4: json["doping_4"],
        doping5: json["doping_5"],
        doping6: json["doping_6"],
        doping7: json["doping_7"],
        doping14: json["doping_14"],
        fiyat: json["fiyat"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "category_1": category1,
        "category_2": category2,
        "category_3": category3,
        "category_4": category4,
        "category_5": category5,
        "category_6": category6,
        "category_7": category7,
        "category_8": category8,
        "asama": asama,
        "doping_1": doping1,
        "doping_2": doping2,
        "doping_3": doping3,
        "doping_4": doping4,
        "doping_5": doping5,
        "doping_6": doping6,
        "doping_7": doping7,
        "doping_14": doping14,
        "fiyat": fiyat,
      };
}
