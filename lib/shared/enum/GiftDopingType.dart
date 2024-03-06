// ignore_for_file: file_names

enum GiftDopingType {
  active("Aktif"),
  used("Kullanıldı");

  final String value;
  const GiftDopingType(this.value);

  String get getGiftDopingType => value;
}
