// To parse this JSON data, do
//
//     final searchSuggestResponseModel = searchSuggestResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SearchSuggestResponseModel searchSuggestResponseModelFromJson(String str) =>
    SearchSuggestResponseModel.fromJson(json.decode(str));

String searchSuggestResponseModelToJson(SearchSuggestResponseModel data) =>
    json.encode(data.toJson());

class SearchSuggestResponseModel {
  List<Ad>? ads;
  List<Cat>? cats;

  SearchSuggestResponseModel({
    this.ads,
    this.cats,
  });

  factory SearchSuggestResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchSuggestResponseModel(
        ads: json["ads"] == null
            ? null
            : List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
        cats: json["cats"] == null
            ? null
            : List<Cat>.from(json["cats"].map((x) => Cat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ads": ads == null
            ? <Ad>[]
            : List<dynamic>.from(ads!.map((x) => x.toJson())),
        "cats": cats == null
            ? <Cat>[]
            : List<dynamic>.from(cats!.map((x) => x.toJson())),
      };
}

class Ad {
  String link;
  String text;
  String id;

  Ad({
    required this.link,
    required this.text,
    required this.id,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        link: json["link"],
        text: json["text"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "text": text,
        "id": id,
      };
}

class Cat {
  String link;
  String text;
  String sub;
  String categoryId;
  String categoryAdCount;

  Cat({
    required this.link,
    required this.text,
    required this.sub,
    required this.categoryId,
    required this.categoryAdCount,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        link: json["link"],
        text: json["text"],
        sub: json["sub"],
        categoryId: json["categoryId"],
        categoryAdCount: json["categoryAdCount"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "text": text,
        "sub": sub,
        "categoryId": categoryId,
        "categoryAdCount": categoryAdCount,
      };
}
