// To parse this JSON data, do
//
//     final adsPublishRequestModel = adsPublishRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AdsPublishRequestModel adsPublishRequestModelFromJson(String str) =>
    AdsPublishRequestModel.fromJson(json.decode(str));

String adsPublishRequestModelToJson(AdsPublishRequestModel data) =>
    json.encode(data.toJson());

class AdsPublishRequestModel {
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
  String ulke;
  String il;
  String ilce;
  String semt;
  String mahalle;
  String maps;
  String doping1;
  String doping2;
  String doping3;
  String doping4;
  String doping5;
  String doping6;
  String doping7;
  String doping14;
  // ignore: non_constant_identifier_names
  String Transactions;
  String payment;
  String? adId;
  String total;
  // ignore: non_constant_identifier_names
  String resim_kod;

  AdsPublishRequestModel({
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
    required this.ulke,
    required this.il,
    required this.ilce,
    required this.semt,
    required this.mahalle,
    required this.maps,
    required this.doping1,
    required this.doping2,
    required this.doping3,
    required this.doping4,
    required this.doping5,
    required this.doping6,
    required this.doping7,
    required this.doping14,
    // ignore: non_constant_identifier_names
    required this.Transactions,
    required this.payment,
    this.adId,
    required this.total,
    // ignore: non_constant_identifier_names
    required this.resim_kod,
  });

  factory AdsPublishRequestModel.fromJson(Map<String, dynamic> json) =>
      AdsPublishRequestModel(
        secretKey: json["secretKey"],
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
        doping1: json["doping_1"],
        doping2: json["doping_2"],
        doping3: json["doping_3"],
        doping4: json["doping_4"],
        doping5: json["doping_5"],
        doping6: json["doping_6"],
        doping7: json["doping_7"],
        doping14: json["doping_14"],
        Transactions: json["Transactions"],
        payment: json["payment"],
        adId: json["adId"],
        total: json["total"],
        resim_kod: json["resim_kod"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
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
        "doping_1": doping1,
        "doping_2": doping2,
        "doping_3": doping3,
        "doping_4": doping4,
        "doping_5": doping5,
        "doping_6": doping6,
        "doping_7": doping7,
        "doping_14": doping14,
        "Transactions": Transactions,
        "payment": payment,
        "adId": adId,
        "total": total,
        "resim_kod": resim_kod,
      };
}
