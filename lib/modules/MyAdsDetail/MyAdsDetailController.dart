// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/AdsEditInfoResponseModel.dart';
import 'package:ilkbizde/data/model/AdvertisementDetailRequestModel.dart';
import 'package:ilkbizde/data/network/api/AdsActivationApi.dart';
import 'package:ilkbizde/data/network/api/AdsPacifyApi.dart';
import 'package:ilkbizde/data/network/api/AdvertisementEditInfoApi.dart';
import 'package:ilkbizde/data/network/api/DeleteAdsApi.dart';
import 'package:ilkbizde/modules/AdsPublish/AdsPublishController.dart';
import 'package:ilkbizde/modules/MyAds/MyAdsController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/myAdsType.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

class MyAdsDetailController extends GetxController {
  final GetStorage storage = GetStorage();

  final Map<String, String?> parameters = Get.parameters;
  final args = Get.arguments;
  final MyAdsController myAdsController = Get.find<MyAdsController>();
  // final AdsPublishController adsPublishController =
  //     Get.put<AdsPublishController>(AdsPublishController());
  final RxList<AdsEditInfoResponseModel> defaultInfos =
      <AdsEditInfoResponseModel>[].obs;

  final RxList willEditInfos = [].obs;

  final RxBool isLoading = false.obs;
  final RxBool isDeleteLoading = false.obs;

  void handleAds(MyAdsType type) {
    switch (type) {
      case MyAdsType.ACTIVE:
        handlePacifyAd();
        break;
      case MyAdsType.PASSIVE:
        handleActivation();
        break;
      default:
    }
  }

  String getButtonTitle(MyAdsType type) {
    switch (type) {
      case MyAdsType.ACTIVE:
        return "Yayından Kaldır";
      case MyAdsType.PASSIVE:
        return "Yayına Al";
      default:
        return "";
    }
  }

  // İLAN PASİFLEŞTİRME
  Future<void> handlePacifyAd() async {
    isLoading.toggle();
    final AdsPacifyApi adsPacifyApi = AdsPacifyApi();
    final AdvertisementDetailRequestModel advertisementDetailRequestModel =
        AdvertisementDetailRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      adId: parameters["adId"].toString(),
    );
    try {
      await adsPacifyApi
          .handlePacify(
        data: advertisementDetailRequestModel.toJson(),
      )
          .then((resp) async {
        if (resp.data["status"] == "success") {
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          myAdsController.myAdsList.removeAt(
            int.parse(
              parameters["index"].toString(),
            ),
          );
          Get.close(1);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
    } finally {
      isLoading.toggle();
    }
  }

  // İLAN AKTİFLEŞTİRME
  Future<void> handleActivation() async {
    isLoading.toggle();
    final AdsActivationApi adsActivationApi = AdsActivationApi();
    final AdvertisementDetailRequestModel advertisementDetailRequestModel =
        AdvertisementDetailRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      adId: parameters["adId"].toString(),
    );

    try {
      await adsActivationApi
          .handleActivation(data: advertisementDetailRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          myAdsController.myAdsList.removeAt(
            int.parse(
              parameters["index"].toString(),
            ),
          );
          Get.close(1);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isLoading.toggle();
    } finally {
      isLoading.toggle();
    }
  }

// İLAN SİLME
  Future<void> handleDelete() async {
    isDeleteLoading.toggle();
    final DeleteAdsApi deleteAdsApi = DeleteAdsApi();
    final AdvertisementDetailRequestModel advertisementDetailRequestModel =
        AdvertisementDetailRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      adId: parameters["adId"].toString(),
    );
    try {
      await deleteAdsApi
          .handleDelete(data: advertisementDetailRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          myAdsController.myAdsList.removeAt(
            int.parse(
              parameters["index"].toString(),
            ),
          );
          Get.close(2);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isDeleteLoading.toggle();
    } finally {
      isDeleteLoading.toggle();
    }
  }

  Future<void> getDefaultInfos(String adId, {String buyDoping = "0"}) async {
    isLoading.toggle();
    final AdvertisementEditInfoApi advertisementEditInfoApi =
        AdvertisementEditInfoApi();
    final AdvertisementDetailRequestModel adsDetailRequestModel =
        AdvertisementDetailRequestModel(
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userId: storage.read('uid') ?? "",
      userEmail: storage.read('uEmail') ?? "",
      userPassword: storage.read("uPassword") ?? "",
      adId: adId,
    );
    try {
      await advertisementEditInfoApi
          .getAdvertisementEditInfo(data: adsDetailRequestModel.toJson())
          .then((resp) async {
        defaultInfos.add(AdsEditInfoResponseModel.fromJson(resp.data));

        Get.toNamed(
          Routes.ADSPUBLISH,
          parameters: {
            "categoriesIds": myAdsController
                .myAdsList[int.parse(parameters["index"].toString())].categories
                .replaceAll("-", ","),
            "isEdit": "1",
            "buyDoping": buyDoping,
            "adId": adId,
          },
        );
        final AdsPublishController adsPublishController =
            Get.put<AdsPublishController>(AdsPublishController());
        adsPublishController.isLoading.toggle();
        // FOTOĞRAF VE VİDEOLAR DÜZENLEMELERİ
        await adsPublishController.getAdsPhotosAndVideos();
        // ADRES DÜZENLEMELERİ
        if (defaultInfos.first.adMap != null) {
          adsPublishController.currentLocation = LatLng(
            double.parse(defaultInfos.first.adMap!.split(",").first),
            double.parse(defaultInfos.first.adMap!.split(",").last),
          );
        }
        adsPublishController.markers.value = [
          Marker(
            point: LatLng(
              double.parse(defaultInfos.first.adMap!.split(",").first),
              double.parse(defaultInfos.first.adMap!.split(",").last),
            ),
            child: Icon(
              Icons.location_on,
              size: 10.w,
              color: AppColors.ASHENVALE_NIGHTS,
            ),
          ),
        ];
        await adsPublishController.getCountries(countryCode: "TR");
        adsPublishController.selectedCity.value =
            defaultInfos.first.adLocation!.adCity!;
        await adsPublishController.getDistricts(
          cityId: adsPublishController.cities
              .where((p0) => p0.name == adsPublishController.selectedCity.value)
              .toList()[0]
              .id,
        );
        adsPublishController.selectedDistrict.value =
            defaultInfos.first.adLocation!.adDistinct!;
        await adsPublishController.getNeighborhood(
          districtId: adsPublishController.districts
              .where((p0) =>
                  p0.name == adsPublishController.selectedDistrict.value)
              .toList()[0]
              .id,
        );
        adsPublishController.selectedNeighborhood.value =
            defaultInfos.first.adLocation!.adMahalle!;

        // TEMEL BİLGİLER DÜZENLEMELERİ
        adsPublishController.isLoading.toggle();
        await adsPublishController.getAdsFilter();
        willEditInfos.addAll([
          TextEditingController(text: defaultInfos.first.adSubject),
          TextEditingController(text: defaultInfos.first.adDesc),
          TextEditingController(text: defaultInfos.first.adInfo?.first.value),
          "30 Gün",
        ]);
        if (defaultInfos.first.adType == "Emlak") {
          willEditInfos.add(defaultInfos.first.adPro);
        }
        for (var i = 1; i < defaultInfos.first.adInfo!.length; i++) {
          if (defaultInfos.first.adInfo?[i].filterType == "text") {
            willEditInfos.add(TextEditingController(
              text: defaultInfos.first.adInfo![i].value,
            ));
          } else if (defaultInfos.first.adInfo?[i].filterType == "select") {
            willEditInfos.add(defaultInfos.first.adInfo![i].value);
          }
        }
        adsPublishController.allValues.replaceRange(
          0,
          willEditInfos.length,
          willEditInfos,
        );
        for (var i = 0; i < adsPublishController.allFilters.length; i++) {
          if (adsPublishController.allFilters[i]["filterType"] == "checkbox") {
            for (var j = 0;
                j < defaultInfos.first.dinamikOzellikler!.length;
                j++) {
              if (defaultInfos.first.dinamikOzellikler![j].features != null) {
                for (var feature
                    in defaultInfos.first.dinamikOzellikler![j].features!) {
                  if (adsPublishController.allFilters[willEditInfos.length + j]
                              ["filterChoises"]
                          .split("||")
                          .indexOf(feature) !=
                      -1) {
                    List<String> items = adsPublishController
                        .allValues[j + willEditInfos.length]
                        .split("-");
                    items[adsPublishController
                        .allFilters[willEditInfos.length + j]["filterChoises"]
                        .split("||")
                        .indexOf(feature)] = "true";
                    adsPublishController.allValues[j + willEditInfos.length] =
                        items.join("-");
                  }
                }
              }
            }
          }
        }
      });
    } catch (e) {
      e.printError();
      isLoading.toggle();
    } finally {
      isLoading.toggle();
      willEditInfos.clear();
      defaultInfos.clear();
    }
  }

  Future<void> getAddressInfos() async {}
}
