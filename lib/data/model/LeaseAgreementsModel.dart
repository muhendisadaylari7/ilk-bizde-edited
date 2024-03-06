// To parse this JSON data, do
//
//     final leaseAgreementsModel = leaseAgreementsModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

LeaseAgreementsModel leaseAgreementsModelFromJson(String str) =>
    LeaseAgreementsModel.fromJson(json.decode(str));

String leaseAgreementsModelToJson(LeaseAgreementsModel data) =>
    json.encode(data.toJson());

class LeaseAgreementsModel {
  String sozlesmeId;
  String baslik;
  String mulkSahibiAdi;
  String mulkSahibiSoyadi;
  String kiraciAdi;
  String kiraciSoyadi;
  String fiyat;
  String kiraSuresi;
  String kiraBaslangic;

  LeaseAgreementsModel({
    required this.sozlesmeId,
    required this.baslik,
    required this.mulkSahibiAdi,
    required this.mulkSahibiSoyadi,
    required this.kiraciAdi,
    required this.kiraciSoyadi,
    required this.fiyat,
    required this.kiraSuresi,
    required this.kiraBaslangic,
  });

  factory LeaseAgreementsModel.fromJson(Map<String, dynamic> json) =>
      LeaseAgreementsModel(
        sozlesmeId: json["sozlesmeId"],
        baslik: json["baslik"],
        mulkSahibiAdi: json["mulkSahibiAdi"],
        mulkSahibiSoyadi: json["mulkSahibiSoyadi"],
        kiraciAdi: json["kiraciAdi"],
        kiraciSoyadi: json["kiraciSoyadi"],
        fiyat: json["fiyat"],
        kiraSuresi: json["kiraSuresi"],
        kiraBaslangic: json["kiraBaslangic"],
      );

  Map<String, dynamic> toJson() => {
        "sozlesmeId": sozlesmeId,
        "baslik": baslik,
        "mulkSahibiAdi": mulkSahibiAdi,
        "mulkSahibiSoyadi": mulkSahibiSoyadi,
        "kiraciAdi": kiraciAdi,
        "kiraciSoyadi": kiraciSoyadi,
        "fiyat": fiyat,
        "kiraSuresi": kiraSuresi,
        "kiraBaslangic": kiraBaslangic,
      };
}
