// To parse this JSON data, do
//
//     final selectedDopingsModel = selectedDopingsModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SelectedDopingsModel selectedDopingsModelFromJson(String str) =>
    SelectedDopingsModel.fromJson(json.decode(str));

String selectedDopingsModelToJson(SelectedDopingsModel data) =>
    json.encode(data.toJson());

class SelectedDopingsModel {
  int totalPrice;
  Map<String, SelectedDoping> selectedDopings;

  SelectedDopingsModel({
    required this.totalPrice,
    required this.selectedDopings,
  });

  factory SelectedDopingsModel.fromJson(Map<String, dynamic> json) =>
      SelectedDopingsModel(
        totalPrice: json["totalPrice"],
        selectedDopings: Map.from(json["selectedDopings"]).map((k, v) =>
            MapEntry<String, SelectedDoping>(k, SelectedDoping.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "totalPrice": totalPrice,
        "selectedDopings": Map.from(selectedDopings)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class SelectedDoping {
  String doping;
  String dopingIsim;
  String ucret;
  String sure;

  SelectedDoping({
    required this.doping,
    required this.dopingIsim,
    required this.ucret,
    required this.sure,
  });

  factory SelectedDoping.fromJson(Map<String, dynamic> json) => SelectedDoping(
        doping: json["doping"],
        dopingIsim: json["dopingIsim"],
        ucret: json["ucret"],
        sure: json["sure"],
      );

  Map<String, dynamic> toJson() => {
        "doping": doping,
        "dopingIsim": dopingIsim,
        "ucret": ucret,
        "sure": sure,
      };
}
