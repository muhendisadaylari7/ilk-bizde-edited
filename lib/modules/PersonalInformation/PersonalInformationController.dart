// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/CityModel.dart';
import 'package:ilkbizde/data/model/CityRequestModel.dart';
import 'package:ilkbizde/data/model/CountryModel.dart';
import 'package:ilkbizde/data/model/CountryRequestModel.dart';
import 'package:ilkbizde/data/model/DistrictModel.dart';
import 'package:ilkbizde/data/model/DistrictRequestModel.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/PhoneNumberSaveModel.dart';
import 'package:ilkbizde/data/model/PhoneNumberVerificationCodeModel.dart';
import 'package:ilkbizde/data/model/UpdateUserModel.dart';
import 'package:ilkbizde/data/model/UploadImageModel.dart';
import 'package:ilkbizde/data/model/UserInfoModel.dart';
import 'package:ilkbizde/data/network/api/CityApi.dart';
import 'package:ilkbizde/data/network/api/CountryApi.dart';
import 'package:ilkbizde/data/network/api/DeleteProfileImageApi.dart';
import 'package:ilkbizde/data/network/api/DistrictApi.dart';
import 'package:ilkbizde/data/network/api/PhoneNumberSaveApi.dart';
import 'package:ilkbizde/data/network/api/SendVerificationCodeApi.dart';
import 'package:ilkbizde/data/network/api/UpdateUserApi.dart';
import 'package:ilkbizde/data/network/api/UploadImageApi.dart';
import 'package:ilkbizde/data/network/api/UserInfoApi.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PersonalInformationController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;
  final RxBool isUpdateLoading = false.obs;
  final RxBool isPhoneNumberVerifiedLoading = false.obs;
  final RxBool isSavePhoneNumberLoading = false.obs;
  final RxBool isProfileImageLoading = false.obs;
  final RxString selectedCountry = "Türkiye".obs;
  final RxString selectedCity = "".obs;
  final RxString selectedDistrict = "".obs;
  final RxString accountType = "".obs;
  final RxString companyType = "".obs;
  final RxString nameSurname = "".obs;
  final RxString userProfilPic = "".obs;
  final RxList<CountryModel> countries = <CountryModel>[].obs;
  final RxList<CityModel> cities = <CityModel>[].obs;
  final RxList<DistrictModel> districts = <DistrictModel>[].obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController taxOfficeController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController identityNumberController =
      TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*$');

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    taxOfficeController.dispose();
    taxNumberController.dispose();
    identityNumberController.dispose();
    titleController.dispose();
    verificationCodeController.dispose();
    pinCodeController.dispose();
    SmsAutoFill().unregisterListener();
  }

// GET COUNTRY ID
  String getCountryId() {
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
  Future<void> getCountries(
      {required String countryCode, String? cityId}) async {
    final CountryApi countryApi = CountryApi();
    final CountryRequestModel countryRequestModel =
        CountryRequestModel(secretKey: dotenv.env["SECRET_KEY"].toString());
    try {
      await countryApi
          .getCountries(data: countryRequestModel.toJson())
          .then((resp) async {
        selectedCountry.value = resp.data
            .where((p0) => p0["code"] == countryCode)
            .toList()[0]["name"]
            .toString();
        for (var country in resp.data) {
          countries.add(CountryModel.fromJson(country));
        }
        await getCities(countryCode: countryCode, cityId: cityId ?? "1");
      });
    } catch (e) {
      print("getCountries error : $e");
    }
  }

// GET CITIES
  Future<void> getCities({required String countryCode, String? cityId}) async {
    final CityApi cityApi = CityApi();
    final CityRequestModel cityRequestModel = CityRequestModel(
      countryCode: countryCode,
      secretKey: dotenv.env["SECRET_KEY"].toString(),
    );
    try {
      await cityApi
          .getCities(data: cityRequestModel.toJson())
          .then((resp) async {
        cities.clear();
        selectedCity.value = resp.data[0]["name"];
        for (var city in resp.data) {
          cities.add(CityModel.fromJson(city));
        }
        await getDistricts(cityId: cityId ?? cities[0].id);
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

  Future<void> getUserInfo() async {
    isLoading.toggle();
    final UserInfoApi userInfoApi = UserInfoApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userEmail: storage.read("uEmail") ?? "",
      userId: storage.read("uid") ?? "",
      userPassword: storage.read("uPassword") ?? "",
    );
    try {
      await userInfoApi
          .getUserInfo(data: generalRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          final UserInfoModel userModel = UserInfoModel.fromJson(resp.data);
          await getCountries(
            countryCode: userModel.userCountry ?? "TR",
            cityId: userModel.userCity ?? "1",
          );
          nameSurname.value =
              "${userModel.userName} ${userModel.userSurname}".toUpperCase();
          nameController.text = userModel.userName;
          surnameController.text = userModel.userSurname;
          emailController.text = userModel.userEmail;
          phoneController.text = userModel.userTel?.substring(1) ?? "";
          accountType.value = userModel.userAccType;
          companyType.value = userModel.userIsletmeTuru ?? "";
          addressController.text = userModel.userAddress ?? "";
          taxOfficeController.text = userModel.userVergiDairesi ?? "";
          identityNumberController.text = userModel.userTc ?? "";
          taxNumberController.text = userModel.userVergiNo ?? "";
          titleController.text = userModel.userUnvan ?? "";
          userProfilPic.value = userModel.userProfilPic ?? "";
          selectedCountry.value = countries
              .where((p0) => p0.code == (userModel.userCountry ?? "TR"))
              .toList()[0]
              .name
              .toString();
          cities.insert(0, CityModel(id: "0", name: "Seçiniz"));
          selectedCity.value = cities
              .where((p0) => p0.id == (userModel.userCity ?? "1"))
              .toList()[0]
              .name
              .toString();
          districts.insert(0, DistrictModel(id: "0", name: "Seçiniz"));
          selectedDistrict.value = districts
              .where((p0) => p0.id == (userModel.userDistrict ?? "1"))
              .toList()[0]
              .name
              .toString();
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("getUserInfo error : $e");
    } finally {
      isLoading.toggle();
    }
  }

  // UPDATE USER INFO
  Future<void> updateUser() async {
    isUpdateLoading.toggle();
    final UpdateUserApi updateUserApi = UpdateUserApi();
    final UpdateUserModel updateUserModel = UpdateUserModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      ad: nameController.text,
      soyad: surnameController.text,
      accountType: accountType.value,
      ulke: getCountryId(),
      il: getCityId(),
      ilce: getDistrictId(),
      adres: addressController.text,
      unvan: titleController.text,
      vergiDairesi: taxOfficeController.text,
      vergiNo: taxNumberController.text,
      tcKimlikNo: identityNumberController.text,
      isletmeTuru: companyType.value,
    );
    try {
      await updateUserApi
          .updateUserInfo(data: updateUserModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          isUpdateLoading.toggle();
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        } else if (resp.data["status"] == "warning") {
          isUpdateLoading.toggle();
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isUpdateLoading.toggle();
      print("updateUser error : $e");
    }
  }

  Future<void> uploadProfileImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageBytes = File(image.path).readAsBytesSync();
    final imageBase64 = base64Encode(imageBytes);
    final UploadImageApi uploadImageApi = UploadImageApi();
    final UploadImageModel uploadImageModel = UploadImageModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      newPhoto: "image/jpeg;base64,$imageBase64",
    );

    try {
      isProfileImageLoading.toggle();
      await uploadImageApi
          .uploadImage(data: uploadImageModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          isProfileImageLoading.toggle();
          userProfilPic.value = resp.data["newProfilPic"];
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        } else if (resp.data["status"] == "warning") {
          isProfileImageLoading.toggle();
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isProfileImageLoading.toggle();
      print("uploadImage error : $e");
    }
  }

  Future<void> deleteProfileImage() async {
    final DeleteProfileImageApi deleteProfileImageApi = DeleteProfileImageApi();

    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );

    try {
      isProfileImageLoading.toggle();
      await deleteProfileImageApi
          .deleteProfileImage(data: generalRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          isProfileImageLoading.toggle();
          userProfilPic.value = "https://ilkbizde.com.tr/images/users/";
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        } else if (resp.data["status"] == "warning") {
          isProfileImageLoading.toggle();
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isProfileImageLoading.toggle();
      print("deleteProfileImage error : $e");
    }
  }

  // TELEFON NUMARASINI DOĞRULAMAK İÇİN KOD GÖNDER
  Future<void> sendVerificationCode() async {
    isPhoneNumberVerifiedLoading.toggle();
    final SendVerificationCodeApi sendVerificationCodeApi =
        SendVerificationCodeApi();
    final PhoneNumberVerificationCodeModel phoneNumberVerificationCodeModel =
        PhoneNumberVerificationCodeModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      telNo: "0" + phoneController.text,
    );
    try {
      await sendVerificationCodeApi
          .sendVerificationCode(data: phoneNumberVerificationCodeModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          verificationCodeController.clear();
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          await SmsAutoFill().listenForCode();
          Get.dialog(
            CustomVerificationCodeDialog(personalInformationController: this),
            barrierDismissible: false,
          );
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isPhoneNumberVerifiedLoading.toggle();
      print("sendVerificationCode error : $e");
    } finally {
      isPhoneNumberVerifiedLoading.toggle();
    }
  }

  // TELEFON NUMARASINI KAYDET
  Future<void> savePhoneNumber() async {
    isSavePhoneNumberLoading.toggle();
    final PhoneNumberSaveApi phoneNumberSaveApi = PhoneNumberSaveApi();
    final PhoneNumberSaveModel phoneNumberSaveModel = PhoneNumberSaveModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      telNo: phoneController.text,
      telOnay: pinCodeController.text,
    );

    try {
      await phoneNumberSaveApi
          .savePhoneNumber(data: phoneNumberSaveModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          pinCodeController.clear();
          Get.close(1);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isSavePhoneNumberLoading.toggle();
      print("savePhoneNumber error : $e");
    } finally {
      isSavePhoneNumberLoading.toggle();
    }
  }
}
