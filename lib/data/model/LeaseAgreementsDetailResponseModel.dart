// To parse this JSON data, do
//
//     final leaseAgreementsDetailResponseModel = leaseAgreementsDetailResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

LeaseAgreementsDetailResponseModel leaseAgreementsDetailResponseModelFromJson(
        String str) =>
    LeaseAgreementsDetailResponseModel.fromJson(json.decode(str));

String leaseAgreementsDetailResponseModelToJson(
        LeaseAgreementsDetailResponseModel data) =>
    json.encode(data.toJson());

class LeaseAgreementsDetailResponseModel {
  SozlesmeDetay sozlesmeDetay;
  List<SozlesmeAylikVeriler> sozlesmeAylikVeriler;

  LeaseAgreementsDetailResponseModel({
    required this.sozlesmeDetay,
    required this.sozlesmeAylikVeriler,
  });

  factory LeaseAgreementsDetailResponseModel.fromJson(
          Map<String, dynamic> json) =>
      LeaseAgreementsDetailResponseModel(
        sozlesmeDetay: SozlesmeDetay.fromJson(json["sozlesmeDetay"]),
        sozlesmeAylikVeriler: List<SozlesmeAylikVeriler>.from(
            json["sozlesmeAylikVeriler"]
                .map((x) => SozlesmeAylikVeriler.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sozlesmeDetay": sozlesmeDetay.toJson(),
        "sozlesmeAylikVeriler":
            List<dynamic>.from(sozlesmeAylikVeriler.map((x) => x.toJson())),
      };
}

class SozlesmeAylikVeriler {
  String sozlesmeDetayId;
  String mulkSahibiAdi;
  String mulkSahibiSoyadi;
  String kiraciAdi;
  String kiraciSoyadi;
  String fiyat;
  String kiraSuresi;
  String kiraBaslangic;
  String durum;

  SozlesmeAylikVeriler({
    required this.sozlesmeDetayId,
    required this.mulkSahibiAdi,
    required this.mulkSahibiSoyadi,
    required this.kiraciAdi,
    required this.kiraciSoyadi,
    required this.fiyat,
    required this.kiraSuresi,
    required this.kiraBaslangic,
    required this.durum,
  });

  factory SozlesmeAylikVeriler.fromJson(Map<String, dynamic> json) =>
      SozlesmeAylikVeriler(
        sozlesmeDetayId: json["sozlesmeDetayId"],
        mulkSahibiAdi: json["mulkSahibiAdi"],
        mulkSahibiSoyadi: json["mulkSahibiSoyadi"],
        kiraciAdi: json["kiraciAdi"],
        kiraciSoyadi: json["kiraciSoyadi"],
        fiyat: json["fiyat"],
        kiraSuresi: json["kiraSuresi"],
        kiraBaslangic: json["kiraBaslangic"],
        durum: json["durum"],
      );

  Map<String, dynamic> toJson() => {
        "sozlesmeDetayId": sozlesmeDetayId,
        "mulkSahibiAdi": mulkSahibiAdi,
        "mulkSahibiSoyadi": mulkSahibiSoyadi,
        "kiraciAdi": kiraciAdi,
        "kiraciSoyadi": kiraciSoyadi,
        "fiyat": fiyat,
        "kiraSuresi": kiraSuresi,
        "kiraBaslangic": kiraBaslangic,
        "durum": durum,
      };
}

class SozlesmeDetay {
  String sozlesmeId;
  String sahipAdi;
  String sahipSoyadi;
  String sahipCep;
  String sahipTc;
  String kiraciAdi;
  String kiraciSoyadi;
  String kiraciCep;
  String kiraciTc;
  String kiraSuresi;
  String kiraBaslangicTarihi;
  String kiraAdres;
  String kiraUcreti;

  SozlesmeDetay({
    required this.sozlesmeId,
    required this.sahipAdi,
    required this.sahipSoyadi,
    required this.sahipCep,
    required this.sahipTc,
    required this.kiraciAdi,
    required this.kiraciSoyadi,
    required this.kiraciCep,
    required this.kiraciTc,
    required this.kiraSuresi,
    required this.kiraBaslangicTarihi,
    required this.kiraAdres,
    required this.kiraUcreti,
  });

  factory SozlesmeDetay.fromJson(Map<String, dynamic> json) => SozlesmeDetay(
        sozlesmeId: json["sozlesmeId"],
        sahipAdi: json["sahipAdi"],
        sahipSoyadi: json["sahipSoyadi"],
        sahipCep: json["sahipCep"],
        sahipTc: json["sahipTc"],
        kiraciAdi: json["kiraciAdi"],
        kiraciSoyadi: json["kiraciSoyadi"],
        kiraciCep: json["kiraciCep"],
        kiraciTc: json["kiraciTc"],
        kiraSuresi: json["kiraSuresi"],
        kiraBaslangicTarihi: json["kiraBaslangicTarihi"],
        kiraAdres: json["kiraAdres"],
        kiraUcreti: json["kiraUcreti"],
      );

  Map<String, dynamic> toJson() => {
        "sozlesmeId": sozlesmeId,
        "sahipAdi": sahipAdi,
        "sahipSoyadi": sahipSoyadi,
        "sahipCep": sahipCep,
        "sahipTc": sahipTc,
        "kiraciAdi": kiraciAdi,
        "kiraciSoyadi": kiraciSoyadi,
        "kiraciCep": kiraciCep,
        "kiraciTc": kiraciTc,
        "kiraSuresi": kiraSuresi,
        "kiraBaslangicTarihi": kiraBaslangicTarihi,
        "kiraAdres": kiraAdres,
        "kiraUcreti": kiraUcreti,
      };
}
