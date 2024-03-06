// To parse this JSON data, do
//
//     final marketInfosResponseModel = marketInfosResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

MarketInfosResponseModel marketInfosResponseModelFromJson(String str) =>
    MarketInfosResponseModel.fromJson(json.decode(str));

String marketInfosResponseModelToJson(MarketInfosResponseModel data) =>
    json.encode(data.toJson());

class MarketInfosResponseModel {
  String id;
  String logo;
  String magazaKullaniciAdi;
  String magazaAdi;
  String magazaAciklamasi;
  String bitis;
  bool magazaYetki;

  MarketInfosResponseModel({
    required this.id,
    required this.logo,
    required this.magazaKullaniciAdi,
    required this.magazaAdi,
    required this.magazaAciklamasi,
    required this.bitis,
    required this.magazaYetki,
  });

  factory MarketInfosResponseModel.fromJson(Map<String, dynamic> json) =>
      MarketInfosResponseModel(
        id: json["id"],
        logo: json["logo"],
        magazaKullaniciAdi: json["magazaKullaniciAdi"],
        magazaAdi: json["magazaAdi"],
        magazaAciklamasi: json["magazaAciklamasi"],
        bitis: json["bitis"],
        magazaYetki: json["magazaYetki"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "magazaKullaniciAdi": magazaKullaniciAdi,
        "magazaAdi": magazaAdi,
        "magazaAciklamasi": magazaAciklamasi,
        "bitis": bitis,
        "magazaYetki": magazaYetki,
      };
}
