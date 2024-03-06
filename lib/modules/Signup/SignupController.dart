// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/CityModel.dart';
import 'package:ilkbizde/data/model/CityRequestModel.dart';
import 'package:ilkbizde/data/model/CountryModel.dart';
import 'package:ilkbizde/data/model/CountryRequestModel.dart';
import 'package:ilkbizde/data/model/DistrictModel.dart';
import 'package:ilkbizde/data/model/DistrictRequestModel.dart';
import 'package:ilkbizde/data/model/UserRegisterModel.dart';
import 'package:ilkbizde/data/network/api/CityApi.dart';
import 'package:ilkbizde/data/network/api/CountryApi.dart';
import 'package:ilkbizde/data/network/api/DistrictApi.dart';
import 'package:ilkbizde/data/network/api/RegisterApi.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/accountType.dart';
import 'package:ilkbizde/shared/enum/companyType.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController taxOfficeController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController identityNumberController =
      TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final RxString accountType = "Kurumsal Üyelik".obs;
  final RxString companyType = "Şahıs Şirketi".obs;
  RxString selectedCountry = "Türkiye".obs;
  RxString selectedCity = "".obs;
  RxString selectedDistrict = "".obs;
  RxBool isRuleAccepted = false.obs;
  RxBool isLoading = false.obs;
  RxBool dropdownIsLoading = false.obs;

  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*$');

  RxList<CountryModel> countries = <CountryModel>[].obs;
  RxList<CityModel> cities = <CityModel>[].obs;
  RxList<DistrictModel> districts = <DistrictModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCountries();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    surnameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    addressController.dispose();
    taxOfficeController.dispose();
    taxNumberController.dispose();
    identityNumberController.dispose();
    titleController.dispose();
  }

  Future<void> handleRegister() async {
    isLoading.toggle();
    final RegisterApi registerApi = RegisterApi();
    final UserRegisterModel userRegisterModel = UserRegisterModel(
      ad: nameController.text,
      soyad: surnameController.text,
      email: emailController.text,
      kurallar: isRuleAccepted.value ? "on" : "off",
      sifre: passwordController.text,
      accountType: accountType.value == AccountType.individualMembership.value
          ? "0"
          : "1",
      isletmeTuru:
          companyType.value == CompanyType.soleProprietorship.value ? "0" : "1",
      adres: addressController.text,
      unvan: titleController.text,
      vergiDairesi: taxOfficeController.text,
      vergiNo: taxNumberController.text,
      tcKimlikNo: identityNumberController.text,
      ulke: getCountryCode(),
      il: getCityId(),
      ilce: getDistrictId(),
      secretKey: dotenv.env["SECRET_KEY"].toString(),
    );
    try {
      await registerApi
          .handleRegister(data: userRegisterModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          isLoading.toggle();
          SnackbarType.success.CustomSnackbar(
            title: AppStrings.success,
            message: resp.data["message"],
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          Get.toNamed(Routes.LOGIN);
        } else if (resp.data["status"] == "warning") {
          isLoading.toggle();
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: resp.data["message"],
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("error:$e");
    }
  }

// GET COUNTRY CODE
  String getCountryCode() {
    for (var country in countries) {
      if (country.name == selectedCountry.value) {
        return country.code;
      }
    }
    return "";
  }

// GET CITY ID
  String getCityId() {
    for (var city in cities) {
      if (city.name == selectedCity.value) {
        return city.id;
      }
    }
    return "";
  }

// GET DISTRICT ID
  String getDistrictId() {
    for (var district in districts) {
      if (district.name == selectedDistrict.value) {
        return district.id;
      }
    }
    return "";
  }

// GET COUNTRIES
  void getCountries() async {
    dropdownIsLoading.toggle();
    final CountryApi countryApi = CountryApi();
    final CountryRequestModel countryRequestModel =
        CountryRequestModel(secretKey: dotenv.env["SECRET_KEY"].toString());
    try {
      await countryApi
          .getCountries(data: countryRequestModel.toJson())
          .then((resp) {
        for (var country in resp.data) {
          countries.add(CountryModel.fromJson(country));
        }
        getCities();
      });
    } catch (e) {
      dropdownIsLoading.toggle();
      print("getCountries error : $e");
    } finally {
      dropdownIsLoading.toggle();
    }
  }

// GET CITIES
  void getCities({String? countryCode}) async {
    final CityApi cityApi = CityApi();
    final CityRequestModel cityRequestModel = CityRequestModel(
      countryCode: countryCode ?? "TR",
      secretKey: dotenv.env["SECRET_KEY"].toString(),
    );
    try {
      await cityApi.getCities(data: cityRequestModel.toJson()).then((resp) {
        cities.clear();
        selectedCity.value = resp.data[0]["name"];
        for (var city in resp.data) {
          cities.add(CityModel.fromJson(city));
        }
        getDistricts(cityId: cities[0].id);
      });
    } catch (e) {
      print("getCities error : $e");
    }
  }

// GET DISTRICTS
  Future<void> getDistricts({String? cityId}) async {
    final DistrictApi districtApi = DistrictApi();
    final DistrictRequestModel districtRequestModel = DistrictRequestModel(
        cityId: cityId ?? "1", secretKey: dotenv.env["SECRET_KEY"].toString());
    try {
      await districtApi
          .getDistricts(data: districtRequestModel.toJson())
          .then((resp) {
        districts.clear();
        if (resp.data.isEmpty) {
          selectedDistrict.value = "";
          return;
        }
        selectedDistrict.value = resp.data[0]["name"];
        for (var district in resp.data) {
          districts.add(DistrictModel.fromJson(district));
        }
      });
    } catch (e) {
      print("getDistricts error : $e");
    }
  }
}
