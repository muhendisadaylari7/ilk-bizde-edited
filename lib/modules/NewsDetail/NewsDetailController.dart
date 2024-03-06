// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/NewsDetailRequestModel.dart';
import 'package:ilkbizde/data/model/NewsDetailResponseModel.dart';
import 'package:ilkbizde/data/network/api/NewsDetailApi.dart';

class NewsDetailController extends GetxController {
  final GetStorage storage = GetStorage();
  final Map<String, dynamic> parameters = Get.parameters;

  final RxList<NewsDetailResponseModel> newsDetails =
      <NewsDetailResponseModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNewsDetail();
  }

  Future<void> getNewsDetail() async {
    isLoading.toggle();
    final NewsDetailApi newsDetailApi = NewsDetailApi();
    final NewsDetailRequestModel newsDetailRequestModel =
        NewsDetailRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
      newsId: parameters["newsId"],
    );

    try {
      await newsDetailApi
          .getNewsDetail(data: newsDetailRequestModel.toJson())
          .then((resp) {
        newsDetails.add(NewsDetailResponseModel.fromJson(resp.data));
      });
    } catch (e) {
      isLoading.toggle();
      print("getBlogDetail error: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
