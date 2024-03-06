// To parse this JSON data, do
//
//     final editMarketRequestModel = editMarketRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

EditMarketRequestModel editMarketRequestModelFromJson(String str) =>
    EditMarketRequestModel.fromJson(json.decode(str));

String editMarketRequestModelToJson(EditMarketRequestModel data) =>
    json.encode(data.toJson());

class EditMarketRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String kullaniciAdi;
  String aciklama;
  String ad;

  EditMarketRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.kullaniciAdi,
    required this.aciklama,
    required this.ad,
  });

  factory EditMarketRequestModel.fromJson(Map<String, dynamic> json) =>
      EditMarketRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        kullaniciAdi: json["kullanici_adi"],
        aciklama: json["aciklama"],
        ad: json["ad"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "kullanici_adi": kullaniciAdi,
        "aciklama": aciklama,
        "ad": ad,
      };
}
