// ignore_for_file: file_names

enum CompanyType {
  soleProprietorship("Şahıs Şirketi"),
  limitedCompany("Limited veya Anonim Şirketi");

  final String value;
  const CompanyType(this.value);

  String get companyType => value;
}
