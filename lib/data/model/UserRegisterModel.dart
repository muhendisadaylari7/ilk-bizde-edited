// To parse this JSON data, do
//
//     final userRegisterModel = userRegisterModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserRegisterModel userRegisterModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));

String userRegisterModelToJson(UserRegisterModel data) =>
    json.encode(data.toJson());

class UserRegisterModel {
  String ad;
  String soyad;
  String email;
  String kurallar;
  String sifre;
  String accountType;
  String isletmeTuru;
  String adres;
  String unvan;
  String vergiDairesi;
  String vergiNo;
  String tcKimlikNo;
  String ulke;
  String il;
  String ilce;
  String secretKey;

  UserRegisterModel({
    required this.ad,
    required this.soyad,
    required this.email,
    required this.kurallar,
    required this.sifre,
    required this.accountType,
    required this.isletmeTuru,
    required this.adres,
    required this.unvan,
    required this.vergiDairesi,
    required this.vergiNo,
    required this.tcKimlikNo,
    required this.ulke,
    required this.il,
    required this.ilce,
    required this.secretKey,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterModel(
        ad: json["ad"],
        soyad: json["soyad"],
        email: json["email"],
        kurallar: json["kurallar"],
        sifre: json["sifre"],
        accountType: json["account_type"],
        isletmeTuru: json["isletme_turu"],
        adres: json["adres"],
        unvan: json["unvan"],
        vergiDairesi: json["vergi_dairesi"],
        vergiNo: json["vergi_no"],
        tcKimlikNo: json["tc_kimlik_no"],
        ulke: json["ulke"],
        il: json["il"],
        ilce: json["ilce"],
        secretKey: json["secretKey"],
      );

  Map<String, dynamic> toJson() => {
        "ad": ad,
        "soyad": soyad,
        "email": email,
        "kurallar": kurallar,
        "sifre": sifre,
        "account_type": accountType,
        "isletme_turu": isletmeTuru,
        "adres": adres,
        "unvan": unvan,
        "vergi_dairesi": vergiDairesi,
        "vergi_no": vergiNo,
        "tc_kimlik_no": tcKimlikNo,
        "ulke": ulke,
        "il": il,
        "ilce": ilce,
        "secretKey": secretKey,
      };
}
