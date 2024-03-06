// To parse this JSON data, do
//
//     final myAdvertisementResponseModel = myAdvertisementResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

MyAdvertisementResponseModel myAdvertisementResponseModelFromJson(String str) =>
    MyAdvertisementResponseModel.fromJson(json.decode(str));

String myAdvertisementResponseModelToJson(MyAdvertisementResponseModel data) =>
    json.encode(data.toJson());

class MyAdvertisementResponseModel {
  String adId;
  String adSubject;
  String adPrice;
  String adCurrency;
  String adPics;
  String adTotalVisitors;
  String adEndDate;
  String adCity;
  String adDistrict;
  String adUpdate;
  String adTotalFav;
  bool hasStyle;
  String categories;
  bool acil;
  bool fiyatiDusen;

  MyAdvertisementResponseModel({
    required this.adId,
    required this.adSubject,
    required this.adPrice,
    required this.adCurrency,
    required this.adPics,
    required this.adTotalVisitors,
    required this.adEndDate,
    required this.adCity,
    required this.adDistrict,
    required this.adUpdate,
    required this.adTotalFav,
    required this.hasStyle,
    required this.categories,
    required this.acil,
    required this.fiyatiDusen,
  });

  factory MyAdvertisementResponseModel.fromJson(Map<String, dynamic> json) =>
      MyAdvertisementResponseModel(
        adId: json["adId"],
        adSubject: json["adSubject"],
        adPrice: json["adPrice"],
        adCurrency: json["adCurrency"],
        adPics: json["adPics"],
        adTotalVisitors: json["adTotalVisitors"],
        adEndDate: json["adEndDate"],
        adCity: json["adCity"],
        adDistrict: json["adDistrict"],
        adUpdate: json["adUpdate"],
        adTotalFav: json["adTotalFav"],
        hasStyle: json["hasStyle"],
        categories: json["categories"],
        acil: json["acil"],
        fiyatiDusen: json["fiyatiDusen"],
      );

  Map<String, dynamic> toJson() => {
        "adId": adId,
        "adSubject": adSubject,
        "adPrice": adPrice,
        "adCurrency": adCurrency,
        "adPics": adPics,
        "adTotalVisitors": adTotalVisitors,
        "adEndDate": adEndDate,
        "adCity": adCity,
        "adDistrict": adDistrict,
        "adUpdate": adUpdate,
        "adTotalFav": adTotalFav,
        "hasStyle": hasStyle,
        "categories": categories,
        "acil": acil,
        "fiyatiDusen": fiyatiDusen,
      };
}
