// To parse this JSON data, do
//
//     final allAdsInMarketResponseModel = allAdsInMarketResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<AllAdsInMarketResponseModel> allAdsInMarketResponseModelFromJson(
        String str) =>
    List<AllAdsInMarketResponseModel>.from(
        json.decode(str).map((x) => AllAdsInMarketResponseModel.fromJson(x)));

String allAdsInMarketResponseModelToJson(
        List<AllAdsInMarketResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllAdsInMarketResponseModel {
  IlanSahibi ilanSahibi;
  List<Ilanlar>? ilanlar;

  AllAdsInMarketResponseModel({
    required this.ilanSahibi,
    required this.ilanlar,
  });

  factory AllAdsInMarketResponseModel.fromJson(Map<String, dynamic> json) =>
      AllAdsInMarketResponseModel(
        ilanSahibi: IlanSahibi.fromJson(json["ilanSahibi"]),
        ilanlar: json["ilanlar"] == null
            ? []
            : List<Ilanlar>.from(
                json["ilanlar"]!.map((x) => Ilanlar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ilanSahibi": ilanSahibi.toJson(),
        "ilanlar": ilanlar == null
            ? []
            : List<dynamic>.from(ilanlar!.map((x) => x.toJson())),
      };
}

class IlanSahibi {
  String id;
  String ad;
  String soyad;
  String gsm;

  IlanSahibi({
    required this.id,
    required this.ad,
    required this.soyad,
    required this.gsm,
  });

  factory IlanSahibi.fromJson(Map<String, dynamic> json) => IlanSahibi(
        id: json["id"],
        ad: json["ad"],
        soyad: json["soyad"],
        gsm: json["gsm"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ad": ad,
        "soyad": soyad,
        "gsm": gsm,
      };
}

class Ilanlar {
  String id;
  String baslik;
  String fiyat;
  String resim;
  String kayitTarihi;

  Ilanlar({
    required this.id,
    required this.baslik,
    required this.fiyat,
    required this.resim,
    required this.kayitTarihi,
  });

  factory Ilanlar.fromJson(Map<String, dynamic> json) => Ilanlar(
        id: json["Id"],
        baslik: json["baslik"],
        fiyat: json["fiyat"],
        resim: json["resim"],
        kayitTarihi: json["kayitTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "baslik": baslik,
        "fiyat": fiyat,
        "resim": resim,
        "kayitTarihi": kayitTarihi,
      };
}
