// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/BlogAndNewsRequestModel.dart';
import 'package:ilkbizde/data/model/BlogResponseModel.dart';
import 'package:ilkbizde/data/network/api/AllBlogApi.dart';

class BlogController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxString searchQuery = "".obs;
  final RxList<BlogResponseModel> allBlogs = <BlogResponseModel>[].obs;
  final RxList<BlogResponseModel> searchResultBlogs = <BlogResponseModel>[].obs;
  RxBool isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllBlogs();
  }

  Future<void> getAllBlogs() async {
    isLoading.toggle();
    final AllBlogApi allBlogApi = AllBlogApi();
    final BlogAndNewsRequestModel blogRequestModel = BlogAndNewsRequestModel(
      page: "1",
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
    );

    try {
      await allBlogApi
          .getAllBlogs(data: blogRequestModel.toJson())
          .then((resp) {
        for (var blog in resp.data) {
          allBlogs.add(BlogResponseModel.fromJson(blog));
        }
        search();
      });
    } catch (e) {
      isLoading.toggle();
      print("getAllBlogs error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // SEARCH BLOG
  void search() {
    searchResultBlogs.clear();

    if (searchQuery.isEmpty) {
      searchResultBlogs.addAll(allBlogs);
      return;
    }

    for (var blog in allBlogs) {
      if (blog.subject
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase())) {
        searchResultBlogs.add(blog);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
