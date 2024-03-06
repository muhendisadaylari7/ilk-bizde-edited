// To parse this JSON data, do
//
//     final addressInfosRequestModel = addressInfosRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AddressInfosRequestModel addressInfosRequestModelFromJson(String str) =>
    AddressInfosRequestModel.fromJson(json.decode(str));

String addressInfosRequestModelToJson(AddressInfosRequestModel data) =>
    json.encode(data.toJson());

class AddressInfosRequestModel {
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
  String ulke;
  String il;
  String ilce;
  String semt;
  String mahalle;
  String? maps;

  AddressInfosRequestModel({
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
    required this.ulke,
    required this.il,
    required this.ilce,
    required this.semt,
    required this.mahalle,
    this.maps,
  });

  factory AddressInfosRequestModel.fromJson(Map<String, dynamic> json) =>
      AddressInfosRequestModel(
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
        ulke: json["ulke"],
        il: json["il"],
        ilce: json["ilce"],
        semt: json["semt"],
        mahalle: json["mahalle"],
        maps: json["maps"] ?? "",
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
        "ulke": ulke,
        "il": il,
        "ilce": ilce,
        "semt": semt,
        "mahalle": mahalle,
        "maps": maps,
      };
}
