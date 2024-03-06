// To parse this JSON data, do
//
//     final showcaseAdvertisementModel = showcaseAdvertisementModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<ShowcaseAdvertisementModel> showcaseAdvertisementModelFromJson(
        String str) =>
    List<ShowcaseAdvertisementModel>.from(
        json.decode(str).map((x) => ShowcaseAdvertisementModel.fromJson(x)));

String showcaseAdvertisementModelToJson(
        List<ShowcaseAdvertisementModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowcaseAdvertisementModel {
  String adId;
  String adSubject;
  String adPrice;
  String adPrice2;
  String adCurrency;
  String adPics;
  int fav;
  bool hasStyle;
  bool acil;
  bool fiyatiDusen;

  ShowcaseAdvertisementModel({
    required this.adId,
    required this.adSubject,
    required this.adPrice,
    required this.adPrice2,
    required this.adCurrency,
    required this.adPics,
    required this.fav,
    required this.hasStyle,
    required this.acil,
    required this.fiyatiDusen,
  });

  factory ShowcaseAdvertisementModel.fromJson(Map<String, dynamic> json) =>
      ShowcaseAdvertisementModel(
        adId: json["adId"],
        adSubject: json["adSubject"],
        adPrice: json["adPrice"],
        adPrice2: json["adPrice2"],
        adCurrency: json["adCurrency"],
        adPics: json["adPics"],
        fav: json["fav"],
        hasStyle: json["hasStyle"],
        acil: json["acil"],
        fiyatiDusen: json["fiyatiDusen"],
      );

  Map<String, dynamic> toJson() => {
        "adId": adId,
        "adSubject": adSubject,
        "adPrice": adPrice,
        "adPrice2": adPrice2,
        "adCurrency": adCurrency,
        "adPics": adPics,
        "fav": fav,
        "hasStyle": hasStyle,
        "acil": acil,
        "fiyatiDusen": fiyatiDusen,
      };
}
