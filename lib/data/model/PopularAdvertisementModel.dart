// To parse this JSON data, do
//
//     final popularAdvertisementModel = popularAdvertisementModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<PopularAdvertisementModel> popularAdvertisementModelFromJson(String str) =>
    List<PopularAdvertisementModel>.from(
        json.decode(str).map((x) => PopularAdvertisementModel.fromJson(x)));

String popularAdvertisementModelToJson(List<PopularAdvertisementModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularAdvertisementModel {
  String adId;
  String adSubject;
  String adPrice;
  String adPrice2;
  String adCurrency;
  String adPics;
  String adCity;
  String adDistrict;
  String? adMahalle;
  int fav;
  bool hasStyle;
  bool acil;
  bool fiyatiDusen;

  PopularAdvertisementModel({
    required this.adId,
    required this.adSubject,
    required this.adPrice,
    required this.adPrice2,
    required this.adCurrency,
    required this.adPics,
    required this.adCity,
    required this.adDistrict,
    required this.adMahalle,
    required this.fav,
    required this.hasStyle,
    required this.acil,
    required this.fiyatiDusen,
  });

  factory PopularAdvertisementModel.fromJson(Map<String, dynamic> json) =>
      PopularAdvertisementModel(
        adId: json["adId"],
        adSubject: json["adSubject"],
        adPrice: json["adPrice"],
        adPrice2: json["adPrice2"],
        adCurrency: json["adCurrency"],
        adPics: json["adPics"],
        adCity: json["adCity"],
        adDistrict: json["adDistrict"],
        adMahalle: json["adMahalle"] ?? "",
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
        "adCity": adCity,
        "adDistrict": adDistrict,
        "adMahalle": adMahalle,
        "fav": fav,
        "hasStyle": hasStyle,
        "acil": acil,
        "fiyatiDusen": fiyatiDusen,
      };
}
