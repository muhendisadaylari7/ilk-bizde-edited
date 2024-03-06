// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String status;
  String userId;
  String userName;
  String userSurname;
  String userEmail;
  String? userTel;
  String? userCountry;
  String? userCity;
  String? userDistrict;
  String? userAddress;
  String userAccType;
  String? userIsletmeTuru;
  String? userUnvan;
  String? userVergiNo;
  String? userVergiDairesi;
  String? userTc;
  String? userProfilPic;

  UserInfoModel({
    required this.status,
    required this.userId,
    required this.userName,
    required this.userSurname,
    required this.userEmail,
    this.userTel,
    this.userCountry,
    this.userCity,
    this.userDistrict,
    this.userAddress,
    required this.userAccType,
    this.userIsletmeTuru,
    this.userUnvan,
    this.userVergiNo,
    this.userVergiDairesi,
    this.userTc,
    this.userProfilPic,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        status: json["status"],
        userId: json["userId"],
        userName: json["userName"],
        userSurname: json["userSurname"],
        userEmail: json["userEmail"],
        userTel: json["userTel"],
        userCountry: json["userCountry"],
        userCity: json["userCity"],
        userDistrict: json["userDistrict"],
        userAddress: json["userAddress"],
        userAccType: json["userAccType"],
        userIsletmeTuru: json["userIsletmeTuru"],
        userUnvan: json["userUnvan"],
        userVergiNo: json["userVergiNo"],
        userVergiDairesi: json["userVergiDairesi"],
        userTc: json["userTc"],
        userProfilPic: json["userProfilPic"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "userName": userName,
        "userSurname": userSurname,
        "userEmail": userEmail,
        "userTel": userTel,
        "userCountry": userCountry,
        "userCity": userCity,
        "userDistrict": userDistrict,
        "userAddress": userAddress,
        "userAccType": userAccType,
        "userIsletmeTuru": userIsletmeTuru,
        "userUnvan": userUnvan,
        "userVergiNo": userVergiNo,
        "userVergiDairesi": userVergiDairesi,
        "userTc": userTc,
        "userProfilPic": userProfilPic,
      };
}
