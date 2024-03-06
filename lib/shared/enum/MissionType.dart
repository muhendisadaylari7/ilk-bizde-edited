// ignore_for_file: file_names

enum MissionType {
  newMember("Yeni Üye"),
  dopingSpending("Doping Harcaması");

  final String value;
  const MissionType(this.value);

  String get getMissionType => value;
}
