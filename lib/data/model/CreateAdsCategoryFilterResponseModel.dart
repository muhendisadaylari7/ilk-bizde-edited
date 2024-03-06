// To parse this JSON data, do
//
//     final createAdsCategoryFilterResponseModel = createAdsCategoryFilterResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CreateAdsCategoryFilterResponseModel
    createAdsCategoryFilterResponseModelFromJson(String str) =>
        CreateAdsCategoryFilterResponseModel.fromJson(json.decode(str));

String createAdsCategoryFilterResponseModelToJson(
        CreateAdsCategoryFilterResponseModel data) =>
    json.encode(data.toJson());

class CreateAdsCategoryFilterResponseModel {
  List<Filter> staticFilters;
  List<Filter> addressFilters;
  List<DinamicFilter> dinamicFilters;
  PriceShow priceShow;
  List<Doping> dopings;

  CreateAdsCategoryFilterResponseModel({
    required this.staticFilters,
    required this.addressFilters,
    required this.dinamicFilters,
    required this.priceShow,
    required this.dopings,
  });

  factory CreateAdsCategoryFilterResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CreateAdsCategoryFilterResponseModel(
        staticFilters: List<Filter>.from(
            json["staticFilters"].map((x) => Filter.fromJson(x))),
        addressFilters: List<Filter>.from(
            json["addressFilters"].map((x) => Filter.fromJson(x))),
        dinamicFilters: List<DinamicFilter>.from(
            json["dinamicFilters"].map((x) => DinamicFilter.fromJson(x))),
        priceShow: PriceShow.fromJson(json["priceShow"]),
        dopings:
            List<Doping>.from(json["dopings"].map((x) => Doping.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "staticFilters":
            List<dynamic>.from(staticFilters.map((x) => x.toJson())),
        "addressFilters":
            List<dynamic>.from(addressFilters.map((x) => x.toJson())),
        "dinamicFilters":
            List<dynamic>.from(dinamicFilters.map((x) => x.toJson())),
        "priceShow": priceShow.toJson(),
        "dopings": List<dynamic>.from(dopings.map((x) => x.toJson())),
      };
}

class Filter {
  String filterName;
  String filterParamName;
  String filterType;
  String filterChoises;
  String filterMultiple;
  String fieldsMultipleName;
  String fieldsMaxMin;
  String fieldsRequired;

  Filter({
    required this.filterName,
    required this.filterParamName,
    required this.filterType,
    required this.filterChoises,
    required this.filterMultiple,
    required this.fieldsMultipleName,
    required this.fieldsMaxMin,
    required this.fieldsRequired,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        filterName: json["filterName"],
        filterParamName: json["filterParamName"],
        filterType: json["filterType"],
        filterChoises: json["filterChoises"],
        filterMultiple: json["filterMultiple"],
        fieldsMultipleName: json["fieldsMultipleName"],
        fieldsMaxMin: json["fieldsMaxMin"],
        fieldsRequired: json["fieldsRequired"],
      );

  Map<String, dynamic> toJson() => {
        "filterName": filterName,
        "filterParamName": filterParamName,
        "filterType": filterType,
        "filterChoises": filterChoises,
        "filterMultiple": filterMultiple,
        "fieldsMultipleName": fieldsMultipleName,
        "fieldsMaxMin": fieldsMaxMin,
        "fieldsRequired": fieldsRequired,
      };
}

class DinamicFilter {
  String filterId;
  String filterName;
  String filterParamName;
  String filterType;
  String filterChoises;
  int filterMultiple;
  String fieldsMultipleName;
  String fieldsMaxMin;
  String fieldsRequired;

  DinamicFilter({
    required this.filterId,
    required this.filterName,
    required this.filterParamName,
    required this.filterType,
    required this.filterChoises,
    required this.filterMultiple,
    required this.fieldsMultipleName,
    required this.fieldsMaxMin,
    required this.fieldsRequired,
  });

  factory DinamicFilter.fromJson(Map<String, dynamic> json) => DinamicFilter(
        filterId: json["filterId"],
        filterName: json["filterName"],
        filterParamName: json["filterParamName"],
        filterType: json["filterType"],
        filterChoises: json["filterChoises"],
        filterMultiple: json["filterMultiple"],
        fieldsMultipleName: json["fieldsMultipleName"],
        fieldsMaxMin: json["fieldsMaxMin"],
        fieldsRequired: json["fieldsRequired"],
      );

  Map<String, dynamic> toJson() => {
        "filterId": filterId,
        "filterName": filterName,
        "filterParamName": filterParamName,
        "filterType": filterType,
        "filterChoises": filterChoises,
        "filterMultiple": filterMultiple,
        "fieldsMultipleName": fieldsMultipleName,
        "fieldsMaxMin": fieldsMaxMin,
        "fieldsRequired": fieldsRequired,
      };
}

class Doping {
  String filterId;
  String filterName;
  String filterParamName;
  String filterType;
  List<String> filterChoises;
  String filterMultiple;
  String fieldsMultipleName;
  String fieldsMaxMin;
  String fieldsRequired;
  List<String> fieldsValues;
  String filterPic;
  String filterDesc;
  String filterShowcasePic;

  Doping({
    required this.filterId,
    required this.filterName,
    required this.filterParamName,
    required this.filterType,
    required this.filterChoises,
    required this.filterMultiple,
    required this.fieldsMultipleName,
    required this.fieldsMaxMin,
    required this.fieldsRequired,
    required this.fieldsValues,
    required this.filterPic,
    required this.filterDesc,
    required this.filterShowcasePic,
  });

  factory Doping.fromJson(Map<String, dynamic> json) => Doping(
        filterId: json["filterId"],
        filterName: json["filterName"],
        filterParamName: json["filterParamName"],
        filterType: json["filterType"],
        filterChoises: List<String>.from(json["filterChoises"].map((x) => x)),
        filterMultiple: json["filterMultiple"],
        fieldsMultipleName: json["fieldsMultipleName"],
        fieldsMaxMin: json["fieldsMaxMin"],
        fieldsRequired: json["fieldsRequired"],
        fieldsValues: List<String>.from(json["fieldsValues"].map((x) => x)),
        filterPic: json["filterPic"],
        filterDesc: json["filterDesc"],
        filterShowcasePic: json["filterShowcasePic"],
      );

  Map<String, dynamic> toJson() => {
        "filterId": filterId,
        "filterName": filterName,
        "filterParamName": filterParamName,
        "filterType": filterType,
        "filterChoises": List<dynamic>.from(filterChoises.map((x) => x)),
        "filterMultiple": filterMultiple,
        "fieldsMultipleName": fieldsMultipleName,
        "fieldsMaxMin": fieldsMaxMin,
        "fieldsRequired": fieldsRequired,
        "fieldsValues": List<dynamic>.from(fieldsValues.map((x) => x)),
        "filterPic": filterPic,
        "filterDesc": filterDesc,
        "filterShowcasePic": filterShowcasePic,
      };
}

class PriceShow {
  bool hidePrice;
  bool hidePenny;

  PriceShow({
    required this.hidePrice,
    required this.hidePenny,
  });

  factory PriceShow.fromJson(Map<String, dynamic> json) => PriceShow(
        hidePrice: json["hidePrice"],
        hidePenny: json["hidePenny"],
      );

  Map<String, dynamic> toJson() => {
        "hidePrice": hidePrice,
        "hidePenny": hidePenny,
      };
}
