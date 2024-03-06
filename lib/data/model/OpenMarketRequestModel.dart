// To parse this JSON data, do
//
//     final openMarketRequestModel = openMarketRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

OpenMarketRequestModel openMarketRequestModelFromJson(String str) =>
    OpenMarketRequestModel.fromJson(json.decode(str));

String openMarketRequestModelToJson(OpenMarketRequestModel data) =>
    json.encode(data.toJson());

class OpenMarketRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String asama;
  String category;
  String duration;
  String kullaniciAdi;
  String aciklama;
  String ad;

  OpenMarketRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.asama,
    required this.category,
    required this.duration,
    required this.kullaniciAdi,
    required this.aciklama,
    required this.ad,
  });

  factory OpenMarketRequestModel.fromJson(Map<String, dynamic> json) =>
      OpenMarketRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        asama: json["asama"],
        category: json["category"],
        duration: json["duration"],
        kullaniciAdi: json["kullanici_adi"],
        aciklama: json["aciklama"],
        ad: json["ad"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "asama": asama,
        "category": category,
        "duration": duration,
        "kullanici_adi": kullaniciAdi,
        "aciklama": aciklama,
        "ad": ad,
      };
}
