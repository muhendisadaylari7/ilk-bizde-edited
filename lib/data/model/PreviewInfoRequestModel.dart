// To parse this JSON data, do
//
//     final previewInfoRequestModel = previewInfoRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PreviewInfoRequestModel previewInfoRequestModelFromJson(String str) =>
    PreviewInfoRequestModel.fromJson(json.decode(str));

String previewInfoRequestModelToJson(PreviewInfoRequestModel data) =>
    json.encode(data.toJson());

class PreviewInfoRequestModel {
  String secretKey;
  String? adId;
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
  String ulke;
  String il;
  String ilce;
  String semt;
  String mahalle;
  String maps;
  String resimKod;

  PreviewInfoRequestModel({
    required this.secretKey,
    this.adId,
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
    required this.ulke,
    required this.il,
    required this.ilce,
    required this.semt,
    required this.mahalle,
    required this.maps,
    required this.resimKod,
  });

  factory PreviewInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      PreviewInfoRequestModel(
        secretKey: json["secretKey"],
        adId: json["adId"] ?? "",
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        category1: json["category_1"],
        category2: json["category_2"],
        category3: json["category_3"],
        category4: json["category_4"],
        category5: json["category_5"],
        category6: json["category_6"],
        category7: json["category_7"],
        category8: json["category_8"],
        asama: json["asama"],
        baslik: json["baslik"],
        aciklama: json["aciklama"],
        hidePrice: json["hidePrice"],
        hidePenny: json["hidePenny"],
        fiyat1: json["fiyat_1"],
        sure: json["sure"],
        kurallar: json["kurallar"],
        ulke: json["ulke"],
        il: json["il"],
        ilce: json["ilce"],
        semt: json["semt"],
        mahalle: json["mahalle"],
        maps: json["maps"],
        resimKod: json["resim_kod"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "adId": adId,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "category_1": category1,
        "category_2": category2,
        "category_3": category3,
        "category_4": category4,
        "category_5": category5,
        "category_6": category6,
        "category_7": category7,
        "category_8": category8,
        "asama": asama,
        "baslik": baslik,
        "aciklama": aciklama,
        "hidePrice": hidePrice,
        "hidePenny": hidePenny,
        "fiyat_1": fiyat1,
        "sure": sure,
        "kurallar": kurallar,
        "ulke": ulke,
        "il": il,
        "ilce": ilce,
        "semt": semt,
        "mahalle": mahalle,
        "maps": maps,
        "resim_kod": resimKod,
      };
}
