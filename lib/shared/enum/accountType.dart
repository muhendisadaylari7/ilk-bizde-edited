// ignore_for_file: file_names

enum AccountType {
  individualMembership("Bireysel Üyelik"),
  corporateMembership("Kurumsal Üyelik");

  final String value;
  const AccountType(this.value);

  String get accountType => value;
}
