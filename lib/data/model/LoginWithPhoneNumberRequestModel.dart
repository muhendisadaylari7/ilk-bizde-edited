// To parse this JSON data, do
//
//     final loginWithPhoneNumberRequestModel = loginWithPhoneNumberRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

LoginWithPhoneNumberRequestModel loginWithPhoneNumberRequestModelFromJson(
        String str) =>
    LoginWithPhoneNumberRequestModel.fromJson(json.decode(str));

String loginWithPhoneNumberRequestModelToJson(
        LoginWithPhoneNumberRequestModel data) =>
    json.encode(data.toJson());

class LoginWithPhoneNumberRequestModel {
  String secretKey;
  String telNo;
  String telOnay;

  LoginWithPhoneNumberRequestModel({
    required this.secretKey,
    required this.telNo,
    required this.telOnay,
  });

  factory LoginWithPhoneNumberRequestModel.fromJson(
          Map<String, dynamic> json) =>
      LoginWithPhoneNumberRequestModel(
        secretKey: json["secretKey"],
        telNo: json["telNo"],
        telOnay: json["telOnay"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "telNo": telNo,
        "telOnay": telOnay,
      };
}
