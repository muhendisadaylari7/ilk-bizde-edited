// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/BlogAndNewsRequestModel.dart';
import 'package:ilkbizde/data/model/NewsResponseModel.dart';
import 'package:ilkbizde/data/network/api/AllNewsApi.dart';

class NewsController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxString searchQuery = "".obs;
  final RxList<NewsResponseModel> allNews = <NewsResponseModel>[].obs;
  final RxList<NewsResponseModel> searchResultNews = <NewsResponseModel>[].obs;
  RxBool isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllNews();
  }

  Future<void> getAllNews() async {
    isLoading.toggle();
    final AllNewsApi allNewsApi = AllNewsApi();
    final BlogAndNewsRequestModel newsRequestModel = BlogAndNewsRequestModel(
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
      page: "1",
    );

    try {
      await allNewsApi.getAllNews(data: newsRequestModel.toJson()).then((resp) {
        for (var news in resp.data) {
          allNews.add(NewsResponseModel.fromJson(news));
        }
        search();
      });
    } catch (e) {
      isLoading.toggle();
      print("getAllNews error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // SEARCH NEWS
  void search() {
    searchResultNews.clear();

    if (searchQuery.isEmpty) {
      searchResultNews.addAll(allNews);
      return;
    }

    for (var news in allNews) {
      if (news.subject
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase())) {
        searchResultNews.add(news);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
