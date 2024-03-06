// To parse this JSON data, do
//
//     final searchResultPageRequestModel = searchResultPageRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SearchResultPageRequestModel searchResultPageRequestModelFromJson(String str) =>
    SearchResultPageRequestModel.fromJson(json.decode(str));

String searchResultPageRequestModelToJson(SearchResultPageRequestModel data) =>
    json.encode(data.toJson());

class SearchResultPageRequestModel {
  String secretKey;
  String search;
  String page;
  String sort;
  String limit;
  String? pro;

  SearchResultPageRequestModel({
    required this.secretKey,
    required this.search,
    required this.page,
    required this.sort,
    required this.limit,
    this.pro,
  });

  factory SearchResultPageRequestModel.fromJson(Map<String, dynamic> json) =>
      SearchResultPageRequestModel(
        secretKey: json["secretKey"],
        search: json["search"],
        page: json["page"],
        sort: json["sort"],
        limit: json["limit"],
        pro: json["pro"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "search": search,
        "page": page,
        "sort": sort,
        "limit": limit,
        "pro": pro,
      };
}
