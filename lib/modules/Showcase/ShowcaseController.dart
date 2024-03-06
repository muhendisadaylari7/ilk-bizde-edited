// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/ShowcaseAdvertisementModel.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/network/api/ShowcaseAdvertisementApi.dart';
import 'package:ilkbizde/modules/Navbar/index.dart';

class ShowcaseController extends GetxController {
  final GetStorage storage = GetStorage();

  RxBool isLoading = false.obs;
  RxBool isDarkMode = false.obs;

  RxList<ShowcaseAdvertisementModel> showcaseAdvertisements =
      <ShowcaseAdvertisementModel>[].obs;

  final PageController pageController = PageController(viewportFraction: .7);

  final NavbarController navbarController =
      Get.put<NavbarController>(NavbarController());

// VİTRİN İLANLARINI GETİR
  Future<void> getShowcaseAdvertisements() async {
    isLoading.toggle();
    final ShowcaseAdvertisementApi showcaseAdvertisementApi =
        ShowcaseAdvertisementApi();
    final GeneralRequestModel advertisementRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
    );
    try {
      await showcaseAdvertisementApi
          .getShowcaseAdvertisement(data: advertisementRequestModel.toJson())
          .then((resp) {
        showcaseAdvertisements.value = resp.data
            .map<ShowcaseAdvertisementModel>((advertisement) =>
                ShowcaseAdvertisementModel.fromJson(advertisement))
            .toList();
      });
    } catch (e) {
      isLoading.toggle();
      print("getShowcaseAdvertisements() error: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
