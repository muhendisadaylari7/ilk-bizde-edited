// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/SearchSuggestRequestModel.dart';
import 'package:ilkbizde/data/model/SearchSuggestResponseModel.dart';
import 'package:ilkbizde/data/network/api/SearchSuggestApi.dart';
import 'package:ilkbizde/routes/app_pages.dart';

class SearchPageController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  RxBool isLoading = false.obs;
  RxList<SearchSuggestResponseModel> resultList =
      <SearchSuggestResponseModel>[].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> searchSuggest() async {
    isLoading.value = true;
    final SearchSuggestApi searchSuggestApi = SearchSuggestApi();
    final SearchSuggestRequestModel searchSuggestRequestModel =
        SearchSuggestRequestModel(
      searchSuggest: searchQuery.value,
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      pro: Get.isDarkMode ? "1" : "",
    );
    if (searchQuery.value.isEmpty) {
      isLoading.value = false;
      resultList.clear();
      return;
    }
    try {
      await searchSuggestApi
          .searchSuggest(
        data: searchSuggestRequestModel.toJson(),
      )
          .then((resp) {
        if (resp.data == null) {
          isLoading.value = false;
          return;
        }
        ;
        if (resp.data != null) {
          isLoading.value = false;
          resultList.clear();
          final SearchSuggestResponseModel result =
              SearchSuggestResponseModel.fromJson(resp.data);
          resultList.add(result);
        }
      });
    } catch (e) {
      isLoading.value = false;
      print("searchSuggest error: $e");
    }
  }

  void redirectToResult() {
    if (resultList.isNotEmpty && resultList[0].ads != null) {
      Get.toNamed(Routes.SEARCHRESULTPAGE, parameters: {
        "search": searchQuery.value,
      });
      searchController.clear();
    }
  }
}
