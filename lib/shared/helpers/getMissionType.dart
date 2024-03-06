import 'package:ilkbizde/shared/enum/MissionType.dart';

MissionType getMissionType(String type) {
  switch (type) {
    case "Yeni Üye":
      return MissionType.newMember;
    case "Doping Harcaması":
      return MissionType.dopingSpending;
    default:
      return MissionType.newMember;
  }
}
