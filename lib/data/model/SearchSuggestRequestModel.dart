// To parse this JSON data, do
//
//     final searchSuggestRequestModel = searchSuggestRequestModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SearchSuggestRequestModel searchSuggestRequestModelFromJson(String str) =>
    SearchSuggestRequestModel.fromJson(json.decode(str));

String searchSuggestRequestModelToJson(SearchSuggestRequestModel data) =>
    json.encode(data.toJson());

class SearchSuggestRequestModel {
  String secretKey;
  String searchSuggest;
  String? pro;

  SearchSuggestRequestModel({
    required this.secretKey,
    required this.searchSuggest,
    this.pro,
  });

  factory SearchSuggestRequestModel.fromJson(Map<String, dynamic> json) =>
      SearchSuggestRequestModel(
        secretKey: json["secretKey"],
        searchSuggest: json["searchSuggest"],
        pro: json["pro"],
      );

  Map<String, dynamic> toJson() => {
        "secretKey": secretKey,
        "searchSuggest": searchSuggest,
        "pro": pro,
      };
}
