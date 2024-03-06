// ignore_for_file: file_names

class AdsEditInfoResponseModel {
  String? adSubject;
  String? adPro;
  String? adPic;
  int? adPicCount;
  AdLocation? adLocation;
  String? adType;
  String? adTypeRes;
  List<DinamikOzellikler>? dinamikOzellikler;
  List<AdInfo>? adInfo;
  dynamic get;
  dynamic getStock;
  FetchComments? fetchComments;
  String? adDesc;
  String? adTags;
  String? adMap;
  dynamic adFav;
  bool? video;

  AdsEditInfoResponseModel({
    this.adSubject,
    this.adPro,
    this.adPic,
    this.adPicCount,
    this.adLocation,
    this.adType,
    this.adTypeRes,
    this.dinamikOzellikler,
    this.adInfo,
    this.get,
    this.getStock,
    this.fetchComments,
    this.adDesc,
    this.adTags,
    this.adMap,
    this.adFav,
    this.video,
  });

  AdsEditInfoResponseModel.fromJson(Map<String, dynamic> json) {
    adSubject = json['adSubject'];
    adPro = json['adPro'];
    adPic = json['adPic'];
    adPicCount = json['adPicCount'];
    adLocation = json['adLocation'] != null
        ? AdLocation.fromJson(json['adLocation'])
        : null;
    adType = json['adType'];
    adTypeRes = json['adTypeRes'];
    if (json['dinamikOzellikler'] != null) {
      dinamikOzellikler = <DinamikOzellikler>[];
      json['dinamikOzellikler'].forEach((v) {
        dinamikOzellikler!.add(DinamikOzellikler.fromJson(v));
      });
    }
    if (json['adInfo'] != null) {
      adInfo = <AdInfo>[];
      json['adInfo'].forEach((v) {
        adInfo!.add(AdInfo.fromJson(v));
      });
    }
    get = json['get'];
    getStock = json['getStock'];
    fetchComments = json['fetchComments'] != null
        ? FetchComments.fromJson(json['fetchComments'])
        : null;
    adDesc = json['adDesc'];
    adTags = json['adTags'];
    adMap = json['adMap'];
    adFav = json['adFav'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adSubject'] = adSubject;
    data['adPro'] = adPro;
    data['adPic'] = adPic;
    data['adPicCount'] = adPicCount;
    if (adLocation != null) {
      data['adLocation'] = adLocation!.toJson();
    }
    data['adType'] = adType;
    data['adTypeRes'] = adTypeRes;
    if (dinamikOzellikler != null) {
      data['dinamikOzellikler'] =
          dinamikOzellikler!.map((v) => v.toJson()).toList();
    }
    if (adInfo != null) {
      data['adInfo'] = adInfo!.map((v) => v.toJson()).toList();
    }
    data['get'] = get;
    data['getStock'] = getStock;
    if (fetchComments != null) {
      data['fetchComments'] = fetchComments!.toJson();
    }
    data['adDesc'] = adDesc;
    data['adTags'] = adTags;
    data['adMap'] = adMap;
    data['adFav'] = adFav;
    data['video'] = video;
    return data;
  }
}

class AdLocation {
  String? adCountry;
  String? adCity;
  String? adDistinct;
  String? adMahalle;

  AdLocation({this.adCountry, this.adCity, this.adDistinct, this.adMahalle});

  AdLocation.fromJson(Map<String, dynamic> json) {
    adCountry = json['adCountry'];
    adCity = json['adCity'];
    adDistinct = json['adDistinct'];
    adMahalle = json['adMahalle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adCountry'] = adCountry;
    data['adCity'] = adCity;
    data['adDistinct'] = adDistinct;
    data['adMahalle'] = adMahalle;
    return data;
  }
}

class DinamikOzellikler {
  String? groupId;
  String? groupName;
  List<String>? features;

  DinamikOzellikler({this.groupId, this.groupName, this.features});

  DinamikOzellikler.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    groupName = json['groupName'];
    features = json["features"] == null
        ? null
        : List<String>.from(json["features"]!.map((x) => x));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['features'] =
        features == null ? null : List<dynamic>.from(features!.map((x) => x));
    return data;
  }
}

class AdInfo {
  String? key;
  String? value;
  String? filterType;

  AdInfo({this.key, this.value, required this.filterType});

  AdInfo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    filterType = json["filterType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    data["filterType"] = filterType;
    return data;
  }
}

class FetchComments {
  Null totalItems;
  int? totalPages;
  int? current;

  FetchComments({this.totalItems, this.totalPages, this.current});

  FetchComments.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalPages = json['total_pages'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['total_pages'] = totalPages;
    data['current'] = current;
    return data;
  }
}
