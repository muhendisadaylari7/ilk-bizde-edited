// To parse this JSON data, do
//
//     final openMarketCategoriesResponseModel = openMarketCategoriesResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

OpenMarketCategoriesResponseModel openMarketCategoriesResponseModelFromJson(
        String str) =>
    OpenMarketCategoriesResponseModel.fromJson(json.decode(str));

String openMarketCategoriesResponseModelToJson(
        OpenMarketCategoriesResponseModel data) =>
    json.encode(data.toJson());

class OpenMarketCategoriesResponseModel {
  List<MagazaKategorileri> magazaKategorileri;
  List<KategoriBilgileri> kategoriBilgileri;

  OpenMarketCategoriesResponseModel({
    required this.magazaKategorileri,
    required this.kategoriBilgileri,
  });

  factory OpenMarketCategoriesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      OpenMarketCategoriesResponseModel(
        magazaKategorileri: List<MagazaKategorileri>.from(
            json["magazaKategorileri"]
                .map((x) => MagazaKategorileri.fromJson(x))),
        kategoriBilgileri: List<KategoriBilgileri>.from(
            json["kategoriBilgileri"]
                .map((x) => KategoriBilgileri.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "magazaKategorileri":
            List<dynamic>.from(magazaKategorileri.map((x) => x.toJson())),
        "kategoriBilgileri":
            List<dynamic>.from(kategoriBilgileri.map((x) => x.toJson())),
      };
}

class KategoriBilgileri {
  String filterName;
  String filterParamName;
  String filterType;
  String filterChoises;
  String filterMultiple;
  String fieldsMultipleName;
  String fieldsMaxMin;
  String fieldsRequired;

  KategoriBilgileri({
    required this.filterName,
    required this.filterParamName,
    required this.filterType,
    required this.filterChoises,
    required this.filterMultiple,
    required this.fieldsMultipleName,
    required this.fieldsMaxMin,
    required this.fieldsRequired,
  });

  factory KategoriBilgileri.fromJson(Map<String, dynamic> json) =>
      KategoriBilgileri(
        filterName: json["filterName"],
        filterParamName: json["filterParamName"],
        filterType: json["filterType"],
        filterChoises: json["filterChoises"],
        filterMultiple: json["filterMultiple"],
        fieldsMultipleName: json["fieldsMultipleName"],
        fieldsMaxMin: json["fieldsMaxMin"],
        fieldsRequired: json["fieldsRequired"],
      );

  Map<String, dynamic> toJson() => {
        "filterName": filterName,
        "filterParamName": filterParamName,
        "filterType": filterType,
        "filterChoises": filterChoises,
        "filterMultiple": filterMultiple,
        "fieldsMultipleName": fieldsMultipleName,
        "fieldsMaxMin": fieldsMaxMin,
        "fieldsRequired": fieldsRequired,
      };
}

class MagazaKategorileri {
  String filterName;
  String filterParamName;
  String filterType;
  String filterChoises;
  String filterMultiple;
  String fieldsMultipleName;
  String fieldsMaxMin;
  String fieldsRequired;
  String fieldAltCat;
  dynamic fieldCat;
  String fieldDuration;

  MagazaKategorileri({
    required this.filterName,
    required this.filterParamName,
    required this.filterType,
    required this.filterChoises,
    required this.filterMultiple,
    required this.fieldsMultipleName,
    required this.fieldsMaxMin,
    required this.fieldsRequired,
    required this.fieldAltCat,
    required this.fieldCat,
    required this.fieldDuration,
  });

  factory MagazaKategorileri.fromJson(Map<String, dynamic> json) =>
      MagazaKategorileri(
        filterName: json["filterName"],
        filterParamName: json["filterParamName"],
        filterType: json["filterType"],
        filterChoises: json["filterChoises"],
        filterMultiple: json["filterMultiple"],
        fieldsMultipleName: json["fieldsMultipleName"],
        fieldsMaxMin: json["fieldsMaxMin"],
        fieldsRequired: json["fieldsRequired"],
        fieldAltCat: json["fieldAltCat"],
        fieldCat: json["fieldCat"],
        fieldDuration: json["fieldDuration"],
      );

  Map<String, dynamic> toJson() => {
        "filterName": filterName,
        "filterParamName": filterParamName,
        "filterType": filterType,
        "filterChoises": filterChoises,
        "filterMultiple": filterMultiple,
        "fieldsMultipleName": fieldsMultipleName,
        "fieldsMaxMin": fieldsMaxMin,
        "fieldsRequired": fieldsRequired,
        "fieldAltCat": fieldAltCat,
        "fieldCat": fieldCat,
        "fieldDuration": fieldDuration,
      };
}
