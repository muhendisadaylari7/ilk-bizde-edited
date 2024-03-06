// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/MyAdvertisementResponseModel.dart';
import 'package:ilkbizde/data/network/api/MyActiveAdsApi.dart';
import 'package:ilkbizde/data/network/api/MyPassiveAdsApi.dart';
import 'package:ilkbizde/data/network/api/MyWaitingAdsApi.dart';
import 'package:ilkbizde/shared/enum/myAdsType.dart';

class MyAdsController extends GetxController {
  final GetStorage storage = GetStorage();

  final Map<String, String?> parameters = Get.parameters;
  final args = Get.arguments;

  final RxBool isLoading = false.obs;

  final RxList<MyAdvertisementResponseModel> myAdsList =
      <MyAdvertisementResponseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyAds(args[0]);
  }

  void getMyAds(MyAdsType myAdsType) {
    switch (myAdsType) {
      case MyAdsType.ACTIVE:
        getMyActiveAds();
        break;
      case MyAdsType.PASSIVE:
        getMyPassiveAds();
        break;
      case MyAdsType.WAITING:
        getMyWaitingAds();
        break;
      default:
    }
  }

  // AKTİF İLANLARIMI GETİR
  Future<void> getMyActiveAds() async {
    isLoading.toggle();
    final MyActiveAdsApi myActiveAdsApi = MyActiveAdsApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
    );

    try {
      await myActiveAdsApi
          .getMyActiveAds(data: generalRequestModel.toJson())
          .then((resp) {
        if (resp.data.runtimeType != List && resp.data["status"] == "success") {
          return;
        }
        for (var ads in resp.data) {
          myAdsList.add(MyAdvertisementResponseModel.fromJson(ads));
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("getMyActiveAds error: $e");
    } finally {
      isLoading.toggle();
    }
  }

// PASİF İLANLARIMI GETİR
  Future<void> getMyPassiveAds() async {
    isLoading.toggle();
    final MyPassiveAdsApi myPassiveAdsApi = MyPassiveAdsApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
    );

    try {
      await myPassiveAdsApi
          .getMyPassiveAds(data: generalRequestModel.toJson())
          .then((resp) {
        if (resp.data.runtimeType != List && resp.data["status"] == "success") {
          return;
        }
        for (var ads in resp.data) {
          myAdsList.add(MyAdvertisementResponseModel.fromJson(ads));
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("getMyPassiveAds error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // ONAY BEKLEYEN İLANLARIMI GETİR
  Future<void> getMyWaitingAds() async {
    isLoading.toggle();
    final MyWaitingAdsApi myWaitingAdsApi = MyWaitingAdsApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
    );

    try {
      await myWaitingAdsApi
          .getMyWaitingAds(data: generalRequestModel.toJson())
          .then((resp) {
        if (resp.data.runtimeType != List && resp.data["status"] == "success") {
          return;
        }
        for (var ads in resp.data) {
          myAdsList.add(MyAdvertisementResponseModel.fromJson(ads));
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("getMyWaitingAds error: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
