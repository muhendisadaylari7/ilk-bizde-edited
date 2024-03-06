// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/AdvertisementDetailResponseModel.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/network/api/AllAdsCompareApi.dart';

class AdvertisementCompareController extends GetxController {
  final GetStorage storage = GetStorage();

  RxList<AdvertisementDetailResponseModel> allAds =
      <AdvertisementDetailResponseModel>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getAllAdsCompare();
  }

  Future<void> getAllAdsCompare() async {
    final AllAdsCompareApi allAdsCompareApi = AllAdsCompareApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );

    try {
      await allAdsCompareApi
          .getAllAdsCompare(data: generalRequestModel.toJson())
          .then((resp) {
        for (var ads in resp.data) {
          allAds.add(AdvertisementDetailResponseModel.fromJson(ads));
        }
      });
    } catch (e) {
      print("getAllAdsCompare error: $e");
    }
  }
}
