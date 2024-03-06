// To parse this JSON data, do
//
//     final getBusinessInfoResponseModel = getBusinessInfoResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<GetBusinessInfoResponseModel> getBusinessInfoResponseModelFromJson(
        String str) =>
    List<GetBusinessInfoResponseModel>.from(
        json.decode(str).map((x) => GetBusinessInfoResponseModel.fromJson(x)));

String getBusinessInfoResponseModelToJson(
        List<GetBusinessInfoResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBusinessInfoResponseModel {
  String businessName;
  String businessType;
  String companyType;
  String tcIdentityNo;
  String taxOffice;
  String taxOfficeCode;
  String address;
  String storeType;

  GetBusinessInfoResponseModel({
    required this.businessName,
    required this.businessType,
    required this.companyType,
    required this.tcIdentityNo,
    required this.taxOffice,
    required this.taxOfficeCode,
    required this.address,
    required this.storeType,
  });

  factory GetBusinessInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBusinessInfoResponseModel(
        businessName: json["magazaAdi"],
        businessType: json["magazaTipi"],
        companyType: json["firmaTipi"],
        tcIdentityNo: json["tcKimlikNo"],
        taxOffice: json["vergiIli"],
        taxOfficeCode: json["vergiIlKodu"],
        address: json["adres"],
        storeType: json["isletmeTuru"],
      );

  Map<String, dynamic> toJson() => {
        "magazaAdi": businessName,
        "magazaTipi": businessType,
        "firmaTipi": companyType,
        "tcKimlikNo": tcIdentityNo,
        "vergiIli": taxOffice,
        "vergiIlKodu": taxOfficeCode,
        "adres": address,
        "isletmeTuru": storeType,
      };
}
