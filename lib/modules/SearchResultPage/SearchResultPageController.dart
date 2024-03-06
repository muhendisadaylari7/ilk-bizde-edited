// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/PopularAdvertisementModel.dart';
import 'package:ilkbizde/data/model/SearchResultPageRequestModel.dart';
import 'package:ilkbizde/data/network/api/SearchApi.dart';

class SearchResultPageController extends GetxController {
  final GetStorage storage = GetStorage();

  final Map<String, String?> parameters = Get.parameters;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchTextEditingController =
      TextEditingController();

  final RxBool isLoading = false.obs;
  final RxInt totalAds = 0.obs;
  final RxInt nextPage = 1.obs;
  final RxInt selectedSortItem = 0.obs;
  final RxInt selectedIndex = 0.obs;
  final RxString searchQuery = "".obs;
  bool isPerformingScroll = false;
  RxList<PopularAdvertisementModel> adsResult =
      <PopularAdvertisementModel>[].obs;
  RxList<PopularAdvertisementModel> searchedAdsResult =
      <PopularAdvertisementModel>[].obs;
  List<String> sortItems = [
    "Önerilen",
    "Tarihe Göre (Yeni)",
    "Tarihe Göre (Eski)",
    "Fiyata Göre (Azalan)",
    "Fiyata Göre (Artan)",
  ];

  @override
  void onInit() {
    super.onInit();
    handleSearchResult();
    scrollController.addListener(onScroll);
  }

  Future<void> handleSearchResult(
      {String page = "1", String sort = "1", bool isSort = false}) async {
    isLoading.toggle();
    final SearchResultApi searchResultApi = SearchResultApi();
    final SearchResultPageRequestModel searchResultPageRequestModel =
        SearchResultPageRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      search: parameters["search"].toString(),
      page: page,
      sort: sort,
      limit: "10",
      pro: Get.isDarkMode ? "1" : "",
    );
    try {
      await searchResultApi
          .handleSearchResult(data: searchResultPageRequestModel.toJson())
          .then((resp) {
        isLoading.toggle();
        isSort ? adsResult.clear() : null;
        for (var ads in resp.data["searchAds"]) {
          adsResult.add(PopularAdvertisementModel.fromJson(ads));
        }
        totalAds.value = resp.data["totalAds"];
        nextPage.value = resp.data["nextPage"];
        searchResults();
        print("TOPLAM İLAN SAYISI: ${resp.data["totalAds"]}");
      });
    } catch (e) {
      isLoading.toggle();
      print("handleSearchResult error: $e");
    }
  }

  Future<void> onScroll() async {
    if (isPerformingScroll) return;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        totalAds.value > adsResult.length) {
      isPerformingScroll = true;

      await handleSearchResult(
        page: nextPage.value.toString(),
        sort: selectedSortItem.value.toString(),
      );

      isPerformingScroll = false;
    }
  }

  void handleSort() {
    selectedSortItem.value = selectedIndex.value + 1;
    handleSearchResult(
      sort: selectedSortItem.value.toString(),
      isSort: true,
    );

    Get.back();
  }

  // SEARCH ADS RESULT
  void searchResults() {
    searchedAdsResult.clear();

    if (searchQuery.isEmpty) {
      searchedAdsResult.addAll(adsResult);
      return;
    }

    for (var result in adsResult) {
      if (result.adSubject
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase())) {
        searchedAdsResult.add(result);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
