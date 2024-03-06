// To parse this JSON data, do
//
//     final UpdateMyStoreContentRequestModel = UpdateMyStoreContentRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:dio/dio.dart';

UpdateMyStoreContentRequestModel updateMyStoreContentRequestModelFromJson(
        String str) =>
    UpdateMyStoreContentRequestModel.fromJson(json.decode(str));

String updateMyStoreContentRequestModelToJson(
        UpdateMyStoreContentRequestModel data) =>
    json.encode(data.toJson());

class UpdateMyStoreContentRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String storeUserName;
  String storeAbout;
  String storeName;
  String storeLogoPath;

  UpdateMyStoreContentRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.storeUserName,
    required this.storeAbout,
    required this.storeName,
    required this.storeLogoPath,
  });

  factory UpdateMyStoreContentRequestModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateMyStoreContentRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        storeUserName: json["magazaKullaniciAdi"],
        storeAbout: json["aciklama"],
        storeName: json["magazaAdi"],
        storeLogoPath: json["logo"],
      );

  Future<Map<String, dynamic>> toJson() async => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "magazaKullaniciAdi": storeUserName,
        "aciklama": storeAbout,
        "magazaAdi": storeName,
        "logo": await MultipartFile.fromFile(storeLogoPath),
      };
}
