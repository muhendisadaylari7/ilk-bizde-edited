// To parse this JSON data, do
//
//     final dailyOpportunityAdvertisementModel = dailyOpportunityAdvertisementModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DailyOpportunityAdvertisementModel dailyOpportunityAdvertisementModelFromJson(
        String str) =>
    DailyOpportunityAdvertisementModel.fromJson(json.decode(str));

String dailyOpportunityAdvertisementModelToJson(
        DailyOpportunityAdvertisementModel data) =>
    json.encode(data.toJson());

class DailyOpportunityAdvertisementModel {
  String adId;
  String adSubject;
  String adPrice;
  String adPrice2;
  String adCurrency;
  String adPics;
  String adCity;
  String adDistrict;
  int fav;
  int adRemHour;
  int adRemMin;
  int adRemSec;

  DailyOpportunityAdvertisementModel({
    required this.adId,
    required this.adSubject,
    required this.adPrice,
    required this.adPrice2,
    required this.adCurrency,
    required this.adPics,
    required this.adCity,
    required this.adDistrict,
    required this.fav,
    required this.adRemHour,
    required this.adRemMin,
    required this.adRemSec,
  });

  factory DailyOpportunityAdvertisementModel.fromJson(
          Map<String, dynamic> json) =>
      DailyOpportunityAdvertisementModel(
        adId: json["adId"],
        adSubject: json["adSubject"],
        adPrice: json["adPrice"],
        adPrice2: json["adPrice2"],
        adCurrency: json["adCurrency"],
        adPics: json["adPics"],
        adCity: json["adCity"],
        adDistrict: json["adDistrict"],
        fav: json["fav"],
        adRemHour: json["adRemHour"],
        adRemMin: json["adRemMin"],
        adRemSec: json["adRemSec"],
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
        "fav": fav,
        "adRemHour": adRemHour,
        "adRemMin": adRemMin,
        "adRemSec": adRemSec,
      };
}
