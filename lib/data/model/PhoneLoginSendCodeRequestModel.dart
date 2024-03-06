// To parse this JSON data, do
//
//     final phoneLoginSendCodeRequestModel = phoneLoginSendCodeRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PhoneLoginSendCodeRequestModel phoneLoginSendCodeRequestModelFromJson(
        String str) =>
    PhoneLoginSendCodeRequestModel.fromJson(json.decode(str));

String phoneLoginSendCodeRequestModelToJson(
        PhoneLoginSendCodeRequestModel data) =>
    json.encode(data.toJson());

class PhoneLoginSendCodeRequestModel {
  String secretKey;
  String telNo;

  PhoneLoginSendCodeRequestModel({
    required this.secretKey,
    required this.telNo,
  });

  factory PhoneLoginSendCodeRequestModel.fromJson(Map<String, dynamic> json) =>
      PhoneLoginSendCodeRequestModel(
        secretKey: json["secretKey"],
        telNo: json["telNo"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "telNo": telNo,
      };
}
