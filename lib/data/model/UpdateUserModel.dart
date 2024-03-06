// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) =>
    json.encode(data.toJson());

class UpdateUserModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String ad;
  String soyad;
  String accountType;
  String? isletmeTuru;
  String ulke;
  String il;
  String ilce;
  String? adres;
  String? unvan;
  String? vergiDairesi;
  String? vergiNo;
  String? tcKimlikNo;

  UpdateUserModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.ad,
    required this.soyad,
    required this.accountType,
    this.isletmeTuru,
    required this.ulke,
    required this.il,
    required this.ilce,
    this.adres,
    this.unvan,
    this.vergiDairesi,
    this.vergiNo,
    this.tcKimlikNo,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        ad: json["ad"],
        soyad: json["soyad"],
        accountType: json["account_type"],
        isletmeTuru: json["isletme_turu"],
        ulke: json["ulke"],
        il: json["il"],
        ilce: json["ilce"],
        adres: json["adres"],
        unvan: json["unvan"],
        vergiDairesi: json["vergi_dairesi"],
        vergiNo: json["vergi_no"],
        tcKimlikNo: json["tc_kimlik_no"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "ad": ad,
        "soyad": soyad,
        "account_type": accountType,
        "isletme_turu": isletmeTuru,
        "ulke": ulke,
        "il": il,
        "ilce": ilce,
        "adres": adres,
        "unvan": unvan,
        "vergi_dairesi": vergiDairesi,
        "vergi_no": vergiNo,
        "tc_kimlik_no": tcKimlikNo,
      };
}
