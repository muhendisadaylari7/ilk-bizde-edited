// To parse this JSON data, do
//
//     final addLeaseRequestModel = addLeaseRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AddLeaseRequestModel addLeaseRequestModelFromJson(String str) =>
    AddLeaseRequestModel.fromJson(json.decode(str));

String addLeaseRequestModelToJson(AddLeaseRequestModel data) =>
    json.encode(data.toJson());

class AddLeaseRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String saticiAdi;
  String saticiSoyad;
  String saticiTel;
  String saticiTc;
  String kiraciAdi;
  String kiraciSoyad;
  String kiraciTel;
  String kiraciTc;
  String baslik;
  String adres;
  String kiraSuresi;
  String kiraBaslangicTarihi;
  String kiraUcreti;

  AddLeaseRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.saticiAdi,
    required this.saticiSoyad,
    required this.saticiTel,
    required this.saticiTc,
    required this.kiraciAdi,
    required this.kiraciSoyad,
    required this.kiraciTel,
    required this.kiraciTc,
    required this.baslik,
    required this.adres,
    required this.kiraSuresi,
    required this.kiraBaslangicTarihi,
    required this.kiraUcreti,
  });

  factory AddLeaseRequestModel.fromJson(Map<String, dynamic> json) =>
      AddLeaseRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        saticiAdi: json["satici_adi"],
        saticiSoyad: json["satici_soyad"],
        saticiTel: json["satici_tel"],
        saticiTc: json["satici_tc"],
        kiraciAdi: json["kiraci_adi"],
        kiraciSoyad: json["kiraci_soyad"],
        kiraciTel: json["kiraci_tel"],
        kiraciTc: json["kiraci_tc"],
        baslik: json["baslik"],
        adres: json["adres"],
        kiraSuresi: json["kira_suresi"],
        kiraBaslangicTarihi: json["kira_baslangic_tarihi"],
        kiraUcreti: json["kira_ucreti"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "satici_adi": saticiAdi,
        "satici_soyad": saticiSoyad,
        "satici_tel": saticiTel,
        "satici_tc": saticiTc,
        "kiraci_adi": kiraciAdi,
        "kiraci_soyad": kiraciSoyad,
        "kiraci_tel": kiraciTel,
        "kiraci_tc": kiraciTc,
        "baslik": baslik,
        "adres": adres,
        "kira_suresi": kiraSuresi,
        "kira_baslangic_tarihi": kiraBaslangicTarihi,
        "kira_ucreti": kiraUcreti,
      };
}
