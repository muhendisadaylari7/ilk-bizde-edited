enum MyAdsType { ACTIVE, PASSIVE, WAITING }

extension MyAdsTypeExtension on MyAdsType {
  String get name {
    switch (this) {
      case MyAdsType.ACTIVE:
        return "Yayında Olan İlanlar";
      case MyAdsType.PASSIVE:
        return "Yayında Olmayan İlanlar";
      case MyAdsType.WAITING:
        return "Onay Bekleyen İlanlar";
      default:
        return "";
    }
  }
}
