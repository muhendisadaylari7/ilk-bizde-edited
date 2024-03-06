// To parse this JSON data, do
//
//     final advertisementDetailResponseModel = advertisementDetailResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AdvertisementDetailResponseModel advertisementDetailResponseModelFromJson(
        String str) =>
    AdvertisementDetailResponseModel.fromJson(json.decode(str));

String advertisementDetailResponseModelToJson(
        AdvertisementDetailResponseModel data) =>
    json.encode(data.toJson());

class AdvertisementDetailResponseModel {
  String adSubject;
  String adPic;
  int adPicCount;
  List<CategoryList> categoryList;
  bool? existsStore;
  StoreDt? storeDt;
  UserDt? userDt;
  AdLocation adLocation;
  dynamic adType;
  String adTypeRes;
  List<DinamikOzellikler> dinamikOzellikler;
  List<AdInfo> adInfo;
  int adCompare;
  dynamic get;
  dynamic getStock;
  FetchComments fetchComments;
  String adDesc;
  String adTags;
  String adMap;
  int? adFav;
  bool? video;
  List<String>? degisenler;
  List<String>? boyalilar;
  List<String>? blokalBoyalar;
  String? ekspertiz;

  AdvertisementDetailResponseModel({
    required this.adSubject,
    required this.adPic,
    required this.adPicCount,
    required this.categoryList,
    required this.existsStore,
    required this.storeDt,
    required this.userDt,
    required this.adLocation,
    required this.adType,
    required this.adTypeRes,
    required this.dinamikOzellikler,
    required this.adInfo,
    required this.adCompare,
    required this.get,
    required this.getStock,
    required this.fetchComments,
    required this.adDesc,
    required this.adTags,
    required this.adMap,
    required this.adFav,
    this.video,
    this.degisenler,
    this.boyalilar,
    this.blokalBoyalar,
    this.ekspertiz,
  });

  factory AdvertisementDetailResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AdvertisementDetailResponseModel(
        adSubject: json["adSubject"],
        adPic: json["adPic"],
        adPicCount: json["adPicCount"],
        categoryList: List<CategoryList>.from(
            json["categoryList"].map((x) => CategoryList.fromJson(x))),
        existsStore: json["existsStore"],
        storeDt: StoreDt.fromJson(json["storeDt"] ?? {}),
        userDt: UserDt.fromJson(json["userDt"] ?? {}),
        adLocation: AdLocation.fromJson(json["adLocation"]),
        adType: json["adType"],
        adTypeRes: json["adTypeRes"],
        dinamikOzellikler: List<DinamikOzellikler>.from(
            json["dinamikOzellikler"]
                .map((x) => DinamikOzellikler.fromJson(x))),
        adInfo:
            List<AdInfo>.from(json["adInfo"].map((x) => AdInfo.fromJson(x))),
        adCompare: json["adCompare"],
        get: json["get"],
        getStock: json["getStock"],
        fetchComments: FetchComments.fromJson(json["fetchComments"]),
        adDesc: json["adDesc"],
        adTags: json["adTags"],
        adMap: json["adMap"],
        adFav: json["adFav"],
        video: json["video"] ?? false,
        degisenler: json["degisenler"] == null
            ? []
            : List<String>.from(json["degisenler"].map((x) => x)),
        boyalilar: json["boyalilar"] == null
            ? []
            : List<String>.from(json["boyalilar"].map((x) => x)),
        blokalBoyalar: json["blokalBoyalar"] == null
            ? []
            : List<String>.from(json["blokalBoyalar"].map((x) => x)),
        ekspertiz: json["ekspertiz"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "adSubject": adSubject,
        "adPic": adPic,
        "adPicCount": adPicCount,
        "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "existsStore": existsStore,
        "storeDt": storeDt?.toJson(),
        "userDt": userDt?.toJson(),
        "adLocation": adLocation.toJson(),
        "adType": adType,
        "adTypeRes": adTypeRes,
        "dinamikOzellikler":
            List<dynamic>.from(dinamikOzellikler.map((x) => x.toJson())),
        "adInfo": List<dynamic>.from(adInfo.map((x) => x.toJson())),
        "adCompare": adCompare,
        "get": get,
        "getStock": getStock,
        "fetchComments": fetchComments.toJson(),
        "adDesc": adDesc,
        "adTags": adTags,
        "adMap": adMap,
        "adFav": adFav,
        "video": video ?? false,
        "degisenler": degisenler == null
            ? []
            : List<dynamic>.from(degisenler!.map((x) => x)),
        "boyalilar": boyalilar == null
            ? []
            : List<dynamic>.from(boyalilar!.map((x) => x)),
        "blokalBoyalar": blokalBoyalar == null
            ? []
            : List<dynamic>.from(blokalBoyalar!.map((x) => x)),
        "ekspertiz": ekspertiz ?? "",
      };
}

class AdInfo {
  String? key;
  String? value;

  AdInfo({
    this.key,
    this.value,
  });

  factory AdInfo.fromJson(Map<String, dynamic> json) => AdInfo(
        key: json["key"] ?? "",
        value: json["value"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "key": key ?? "",
        "value": value ?? "",
      };
}

class AdLocation {
  String? adCountry;
  String? adCity;
  String? adDistinct;
  String? adMahalle;

  AdLocation({
    this.adCountry,
    this.adCity,
    this.adDistinct,
    this.adMahalle,
  });

  factory AdLocation.fromJson(Map<String, dynamic> json) => AdLocation(
        adCountry: json["adCountry"] ?? "",
        adCity: json["adCity"] ?? "",
        adDistinct: json["adDistinct"] ?? "",
        adMahalle: json["adMahalle"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "adCountry": adCountry ?? "",
        "adCity": adCity ?? "",
        "adDistinct": adDistinct ?? "",
        "adMahalle": adMahalle ?? "",
      };
}

class CategoryList {
  String categoryName;
  int categoryId;
  String categoryAdCount;
  String categoryUrgentAdCount;
  String categoryLast48AdCount;

  CategoryList({
    required this.categoryName,
    required this.categoryId,
    required this.categoryAdCount,
    required this.categoryUrgentAdCount,
    required this.categoryLast48AdCount,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        categoryName: json["categoryName"],
        categoryId: json["categoryId"],
        categoryAdCount: json["categoryAdCount"],
        categoryUrgentAdCount: json["categoryUrgentAdCount"] ?? "",
        categoryLast48AdCount: json["categoryLast48AdCount"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categoryId": categoryId,
        "categoryAdCount": categoryAdCount,
        "categoryUrgentAdCount": categoryUrgentAdCount,
        "categoryLast48AdCount": categoryLast48AdCount,
      };
}

class FetchComments {
  dynamic totalItems;
  int totalPages;
  int current;

  FetchComments({
    required this.totalItems,
    required this.totalPages,
    required this.current,
  });

  factory FetchComments.fromJson(Map<String, dynamic> json) => FetchComments(
        totalItems: json["total_items"],
        totalPages: json["total_pages"],
        current: json["current"],
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "total_pages": totalPages,
        "current": current,
      };
}

class StoreDt {
  String? id;
  String? uyeId;
  String? logo;
  String? magazaadi;
  String? username;
  String? aciklama;
  String? stil;
  String? onay;
  String? kategori1;
  String? supermagaza;
  String? bitis;

  StoreDt({
    this.id,
    this.uyeId,
    this.logo,
    this.magazaadi,
    this.username,
    this.aciklama,
    this.stil,
    this.onay,
    this.kategori1,
    this.supermagaza,
    this.bitis,
  });

  factory StoreDt.fromJson(Map<String, dynamic> json) => StoreDt(
        id: json["id"] ?? "",
        uyeId: json["uyeId"] ?? "",
        logo: json["logo"] ?? "",
        magazaadi: json["magazaadi"] ?? "",
        username: json["username"] ?? "",
        aciklama: json["aciklama"] ?? "",
        stil: json["stil"] ?? "",
        onay: json["onay"] ?? "",
        kategori1: json["kategori1"] ?? "",
        supermagaza: json["supermagaza"] ?? "",
        bitis: json["bitis"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "uyeId": uyeId ?? "",
        "logo": logo ?? "",
        "magazaadi": magazaadi ?? "",
        "username": username ?? "",
        "aciklama": aciklama ?? "",
        "stil": stil ?? "",
        "onay": onay ?? "",
        "kategori1": kategori1 ?? "",
        "supermagaza": supermagaza ?? "",
        "bitis": bitis ?? "",
      };
}

class UserDt {
  String id;
  String username;
  String ad;
  String soyad;
  String email;
  String parola;
  String kayitTarihi;
  String onay;
  String gsm;
  String ulke;
  String il;
  String ilce;
  String adres;
  String ip;
  dynamic ban;
  String point;
  dynamic facebook;
  dynamic twitter;
  dynamic referans;
  String accountType;
  String company;
  String photo;
  String adLimit;
  String seenDetails;
  String aktivasyonKodu;
  String telOnay;

  UserDt({
    required this.id,
    required this.username,
    required this.ad,
    required this.soyad,
    required this.email,
    required this.parola,
    required this.kayitTarihi,
    required this.onay,
    required this.gsm,
    required this.ulke,
    required this.il,
    required this.ilce,
    required this.adres,
    required this.ip,
    this.ban,
    required this.point,
    this.facebook,
    this.twitter,
    this.referans,
    required this.accountType,
    required this.company,
    required this.photo,
    required this.adLimit,
    required this.seenDetails,
    required this.aktivasyonKodu,
    required this.telOnay,
  });

  factory UserDt.fromJson(Map<String, dynamic> json) => UserDt(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        ad: json["ad"] ?? "",
        soyad: json["soyad"] ?? "",
        email: json["email"] ?? "",
        parola: json["parola"] ?? "",
        kayitTarihi: json["kayit_tarihi"] ?? "",
        onay: json["onay"] ?? "",
        gsm: json["gsm"] ?? "",
        ulke: json["ulke"] ?? "",
        il: json["il"] ?? "",
        ilce: json["ilce"] ?? "",
        adres: json["adres"] ?? "",
        ip: json["ip"] ?? "",
        ban: json["ban"] ?? "",
        point: json["point"] ?? "",
        facebook: json["facebook"] ?? "",
        twitter: json["twitter"] ?? "",
        referans: json["referans"] ?? "",
        accountType: json["account_type"] ?? "",
        company: json["company"] ?? "",
        photo: json["photo"] ?? "",
        adLimit: json["ad_limit"] ?? "",
        seenDetails: json["seen_details"] ?? "",
        aktivasyonKodu: json["aktivasyon_kodu"] ?? "",
        telOnay: json["telOnay"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "ad": ad,
        "soyad": soyad,
        "email": email,
        "parola": parola,
        "kayit_tarihi": kayitTarihi,
        "onay": onay,
        "gsm": gsm,
        "ulke": ulke,
        "il": il,
        "ilce": ilce,
        "adres": adres,
        "ip": ip,
        "ban": ban,
        "point": point,
        "facebook": facebook,
        "twitter": twitter,
        "referans": referans,
        "account_type": accountType,
        "company": company,
        "photo": photo,
        "ad_limit": adLimit,
        "seen_details": seenDetails,
        "aktivasyon_kodu": aktivasyonKodu,
        "telOnay": telOnay,
      };
}

class DinamikOzellikler {
  String groupId;
  String groupName;
  List<String>? features;

  DinamikOzellikler({
    required this.groupId,
    required this.groupName,
    this.features,
  });

  factory DinamikOzellikler.fromJson(Map<String, dynamic> json) =>
      DinamikOzellikler(
        groupId: json["groupId"],
        groupName: json["groupName"],
        features: json["features"] == null
            ? null
            : List<String>.from(json["features"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "features": features == null
            ? null
            : List<dynamic>.from(features!.map((x) => x)),
      };
}
