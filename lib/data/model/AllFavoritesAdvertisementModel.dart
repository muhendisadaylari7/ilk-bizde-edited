// To parse this JSON data, do
//
//     final allFavoritesAdvertisementModel = allFavoritesAdvertisementModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AllFavoritesAdvertisementModel allFavoritesAdvertisementModelFromJson(
        String str) =>
    AllFavoritesAdvertisementModel.fromJson(json.decode(str));

String allFavoritesAdvertisementModelToJson(
        AllFavoritesAdvertisementModel data) =>
    json.encode(data.toJson());

class AllFavoritesAdvertisementModel {
  String adId;
  String adSubject;
  String adPrice;
  String adPrice2;
  String adCurrency;
  String adPics;
  String favoriteId;
  String adCity;
  String adDistrict;
  bool hasStyle;
  bool acil;
  bool fiyatiDusen;

  AllFavoritesAdvertisementModel({
    required this.adId,
    required this.adSubject,
    required this.adPrice,
    required this.adPrice2,
    required this.adCurrency,
    required this.adPics,
    required this.favoriteId,
    required this.adCity,
    required this.adDistrict,
    required this.hasStyle,
    required this.acil,
    required this.fiyatiDusen,
  });

  factory AllFavoritesAdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AllFavoritesAdvertisementModel(
        adId: json["adId"],
        adSubject: json["adSubject"],
        adPrice: json["adPrice"],
        adPrice2: json["adPrice2"],
        adCurrency: json["adCurrency"],
        adPics: json["adPics"],
        favoriteId: json["listAdsId"],
        adCity: json["adCity"],
        adDistrict: json["adDistrict"],
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
        "listAdsId": favoriteId,
        "adCity": adCity,
        "adDistrict": adDistrict,
        "hasStyle": hasStyle,
        "acil": acil,
        "fiyatiDusen": fiyatiDusen,
      };
}
