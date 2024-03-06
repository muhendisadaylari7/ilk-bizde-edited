import 'package:ilkbizde/shared/enum/GiftDopingType.dart';

GiftDopingType stringToGiftDopingType(String type) {
  switch (type) {
    case "Aktif":
      return GiftDopingType.active;
    case "Kullanıldı":
      return GiftDopingType.used;
    default:
      return GiftDopingType.active;
  }
}
