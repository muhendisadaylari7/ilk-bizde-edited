// To parse this JSON data, do
//
//     final previewInfoResponseModel = previewInfoResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PreviewInfoResponseModel previewInfoResponseModelFromJson(String str) =>
    PreviewInfoResponseModel.fromJson(json.decode(str));

String previewInfoResponseModelToJson(PreviewInfoResponseModel data) =>
    json.encode(data.toJson());

class PreviewInfoResponseModel {
  String adSubject;
  dynamic adPic;
  int adPicCount;
  AdLocation adLocation;
  String adType;
  List<String>? degisenler;
  List<String>? boyalilar;
  List<String>? blokalBoyalar;
  List<DinamikOzellikler> dinamikOzellikler;
  List<AdInfo> adInfo;
  String adDesc;
  String adMap;
  String? ekspertiz;
  dynamic video;

  PreviewInfoResponseModel({
    required this.adSubject,
    required this.adPic,
    required this.adPicCount,
    required this.adLocation,
    required this.adType,
    this.degisenler,
    this.boyalilar,
    this.blokalBoyalar,
    required this.dinamikOzellikler,
    required this.adInfo,
    required this.adDesc,
    required this.adMap,
    this.ekspertiz,
    required this.video,
  });

  factory PreviewInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      PreviewInfoResponseModel(
        adSubject: json["adSubject"],
        adPic: json["adPic"],
        adPicCount: json["adPicCount"],
        adLocation: AdLocation.fromJson(json["adLocation"]),
        adType: json["adType"],
        degisenler: json["degisenler"] == null
            ? []
            : List<String>.from(json["degisenler"].map((x) => x)),
        boyalilar: json["boyalilar"] == null
            ? []
            : List<String>.from(json["boyalilar"].map((x) => x)),
        blokalBoyalar: json["blokalBoyalar"] == null
            ? []
            : List<String>.from(json["blokalBoyalar"].map((x) => x)),
        dinamikOzellikler: List<DinamikOzellikler>.from(
            json["dinamikOzellikler"]
                .map((x) => DinamikOzellikler.fromJson(x))),
        adInfo:
            List<AdInfo>.from(json["adInfo"].map((x) => AdInfo.fromJson(x))),
        adDesc: json["adDesc"],
        adMap: json["adMap"],
        ekspertiz: json["ekspertiz"] ?? "",
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "adSubject": adSubject,
        "adPic": adPic,
        "adPicCount": adPicCount,
        "adLocation": adLocation.toJson(),
        "adType": adType,
        "degisenler": degisenler == null
            ? []
            : List<dynamic>.from(degisenler?.map((x) => x) ?? []),
        "boyalilar": boyalilar == null
            ? []
            : List<dynamic>.from(boyalilar?.map((x) => x) ?? []),
        "blokalBoyalar": blokalBoyalar == null
            ? []
            : List<dynamic>.from(blokalBoyalar?.map((x) => x) ?? []),
        "dinamikOzellikler":
            List<dynamic>.from(dinamikOzellikler.map((x) => x.toJson())),
        "adInfo": List<dynamic>.from(adInfo.map((x) => x.toJson())),
        "adDesc": adDesc,
        "adMap": adMap,
        "ekspertiz": ekspertiz ?? "",
        "video": video,
      };
}

class AdInfo {
  String key;
  String? value;

  AdInfo({
    required this.key,
    required this.value,
  });

  factory AdInfo.fromJson(Map<String, dynamic> json) => AdInfo(
        key: json["key"],
        value: json["value"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class AdLocation {
  String adCountry;
  String adCity;
  String adDistinct;
  dynamic adMahalle;

  AdLocation({
    required this.adCountry,
    required this.adCity,
    required this.adDistinct,
    required this.adMahalle,
  });

  factory AdLocation.fromJson(Map<String, dynamic> json) => AdLocation(
        adCountry: json["adCountry"],
        adCity: json["adCity"],
        adDistinct: json["adDistinct"],
        adMahalle: json["adMahalle"],
      );

  Map<String, dynamic> toJson() => {
        "adCountry": adCountry,
        "adCity": adCity,
        "adDistinct": adDistinct,
        "adMahalle": adMahalle,
      };
}

class DinamikOzellikler {
  String groupId;
  String? groupName;
  List<String>? features;

  DinamikOzellikler({
    required this.groupId,
    required this.groupName,
    this.features,
  });

  factory DinamikOzellikler.fromJson(Map<String, dynamic> json) =>
      DinamikOzellikler(
        groupId: json["groupId"],
        groupName: json["groupName"],
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
      };
}
