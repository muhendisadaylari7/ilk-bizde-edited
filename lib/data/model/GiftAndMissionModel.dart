// To parse this JSON data, do
//
//     final giftDopingAndMissionModel = giftDopingAndMissionModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

GiftDopingAndMissionModel giftDopingAndMissionModelFromJson(String str) =>
    GiftDopingAndMissionModel.fromJson(json.decode(str));

String giftDopingAndMissionModelToJson(GiftDopingAndMissionModel data) =>
    json.encode(data.toJson());

class GiftDopingAndMissionModel {
  List<Hediyeler>? hediyeler;
  String toplamHarcama;
  List<Gorevler> gorevler;

  GiftDopingAndMissionModel({
    required this.hediyeler,
    required this.toplamHarcama,
    required this.gorevler,
  });

  factory GiftDopingAndMissionModel.fromJson(Map<String, dynamic> json) =>
      GiftDopingAndMissionModel(
        hediyeler: json["hediyeler"].isEmpty
            ? []
            : List<Hediyeler>.from(
                json["hediyeler"].map((x) => Hediyeler.fromJson(x))),
        toplamHarcama: json["toplamHarcama"],
        gorevler: List<Gorevler>.from(
            json["gorevler"].map((x) => Gorevler.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hediyeler": List<dynamic>.from(hediyeler!.map((x) => x.toJson())),
        "toplamHarcama": toplamHarcama,
        "gorevler": List<dynamic>.from(gorevler.map((x) => x.toJson())),
      };
}

class Gorevler {
  String gorevlerTuru;
  String gorevDopingTuru;
  String gorevDopingSure;
  String gorevDopingAralk;

  Gorevler({
    required this.gorevlerTuru,
    required this.gorevDopingTuru,
    required this.gorevDopingSure,
    required this.gorevDopingAralk,
  });

  factory Gorevler.fromJson(Map<String, dynamic> json) => Gorevler(
        gorevlerTuru: json["gorevlerTuru"],
        gorevDopingTuru: json["gorevDopingTuru"],
        gorevDopingSure: json["gorevDopingSure"],
        gorevDopingAralk: json["gorevDopingAralık"],
      );

  Map<String, dynamic> toJson() => {
        "gorevlerTuru": gorevlerTuru,
        "gorevDopingTuru": gorevDopingTuru,
        "gorevDopingSure": gorevDopingSure,
        "gorevDopingAralık": gorevDopingAralk,
      };
}

class Hediyeler {
  String dopingTuru;
  String dopingSure;
  String dopingDurumu;

  Hediyeler({
    required this.dopingTuru,
    required this.dopingSure,
    required this.dopingDurumu,
  });

  factory Hediyeler.fromJson(Map<String, dynamic> json) => Hediyeler(
        dopingTuru: json["dopingTuru"],
        dopingSure: json["dopingSure"],
        dopingDurumu: json["dopingDurumu"],
      );

  Map<String, dynamic> toJson() => {
        "dopingTuru": dopingTuru,
        "dopingSure": dopingSure,
        "dopingDurumu": dopingDurumu,
      };
}
