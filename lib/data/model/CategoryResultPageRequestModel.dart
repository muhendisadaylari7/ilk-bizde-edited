// To parse this JSON data, do
//
//     final categoryResultPageRequestModel = categoryResultPageRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CategoryResultPageRequestModel categoryResultPageRequestModelFromJson(
        String str) =>
    CategoryResultPageRequestModel.fromJson(json.decode(str));

String categoryResultPageRequestModelToJson(
        CategoryResultPageRequestModel data) =>
    json.encode(data.toJson());

class CategoryResultPageRequestModel {
  String secretKey;
  String userId;
  String userEmail;
  String userPassword;
  String categoryId;
  String limit;
  String sort;
  String page;
  String search;
  String searchDescInc;
  String country;
  String city;
  String distinct;
  String mahalle;
  String price1;
  String price2;
  String currency;
  String date;
  String video;
  String photo;
  String map;
  String? pro;

  CategoryResultPageRequestModel({
    required this.secretKey,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.categoryId,
    required this.limit,
    required this.sort,
    required this.page,
    required this.search,
    required this.searchDescInc,
    required this.country,
    required this.city,
    required this.distinct,
    required this.mahalle,
    required this.price1,
    required this.price2,
    required this.currency,
    required this.date,
    required this.video,
    required this.photo,
    required this.map,
    this.pro,
  });

  factory CategoryResultPageRequestModel.fromJson(Map<String, dynamic> json) =>
      CategoryResultPageRequestModel(
        secretKey: json["secretKey"],
        userId: json["userId"],
        userEmail: json["userEmail"],
        userPassword: json["userPassword"],
        categoryId: json["categoryId"],
        limit: json["limit"],
        sort: json["sort"],
        page: json["page"],
        search: json["search"],
        searchDescInc: json["searchDescInc"],
        country: json["country"],
        city: json["city"],
        distinct: json["distinct"],
        mahalle: json["mahalle"],
        price1: json["price1"],
        price2: json["price2"],
        currency: json["currency"],
        date: json["date"],
        video: json["video"],
        photo: json["photo"],
        map: json["map"],
        pro: json["pro"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "userId": userId,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "categoryId": categoryId,
        "limit": limit,
        "sort": sort,
        "page": page,
        "search": search,
        "searchDescInc": searchDescInc,
        "country": country,
        "city": city,
        "distinct": distinct,
        "mahalle": mahalle,
        "price1": price1,
        "price2": price2,
        "currency": currency,
        "date": date,
        "video": video,
        "photo": photo,
        "map": map,
        "pro": pro,
      };
}
