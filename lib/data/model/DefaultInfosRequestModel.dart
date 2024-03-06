// To parse this JSON data, do
//
//     final defaultInfosRequestModel = defaultInfosRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DefaultInfosRequestModel defaultInfosRequestModelFromJson(String str) =>
    DefaultInfosRequestModel.fromJson(json.decode(str));

String defaultInfosRequestModelToJson(DefaultInfosRequestModel data) =>
    json.encode(data.toJson());

class DefaultInfosRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String category1;
  String category2;
  String category3;
  String category4;
  String category5;
  String category6;
  String category7;
  String category8;
  String asama;
  String baslik;
  String aciklama;
  String hidePrice;
  String hidePenny;
  String fiyat1;
  String sure;
  String kurallar;

  DefaultInfosRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
    required this.category6,
    required this.category7,
    required this.category8,
    required this.asama,
    required this.baslik,
    required this.aciklama,
    required this.hidePrice,
    required this.hidePenny,
    required this.fiyat1,
    required this.sure,
    required this.kurallar,
  });

  factory DefaultInfosRequestModel.fromJson(Map<String, dynamic> json) =>
      DefaultInfosRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        category1: json["category1"],
        category2: json["category2"],
        category3: json["category3"],
        category4: json["category4"],
        category5: json["category5"],
        category6: json["category6"],
        category7: json["category7"],
        category8: json["category8"],
        asama: json["asama"],
        baslik: json["baslik"],
        aciklama: json["aciklama"],
        hidePrice: json["hidePrice"],
        hidePenny: json["hidePenny"],
        fiyat1: json["fiyat_1"],
        sure: json["sure"],
        kurallar: json["kurallar"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "category1": category1,
        "category2": category2,
        "category3": category3,
        "category4": category4,
        "category5": category5,
        "category6": category6,
        "category7": category7,
        "category8": category8,
        "asama": asama,
        "baslik": baslik,
        "aciklama": aciklama,
        "hidePrice": hidePrice,
        "hidePenny": hidePenny,
        "fiyat_1": fiyat1,
        "sure": sure,
        "kurallar": kurallar,
      };
}
