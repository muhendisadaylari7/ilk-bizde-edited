// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/BlogDetailRequestModel.dart';
import 'package:ilkbizde/data/model/BlogResponseModel.dart';
import 'package:ilkbizde/data/network/api/BlogDetailApi.dart';

class BlogDetailController extends GetxController {
  final GetStorage storage = GetStorage();
  final Map<String, dynamic> parameters = Get.parameters;

  final RxList<BlogResponseModel> blogDetails = <BlogResponseModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getBlogDetail();
  }

  Future<void> getBlogDetail() async {
    isLoading.toggle();
    final BlogDetailApi blogDetailApi = BlogDetailApi();
    final BlogDetailRequestModel blogDetailRequestModel =
        BlogDetailRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
      blogId: parameters["blogId"],
    );

    try {
      await blogDetailApi
          .getBlogDetail(data: blogDetailRequestModel.toJson())
          .then((resp) {
        blogDetails.add(BlogResponseModel.fromJson(resp.data));
      });
    } catch (e) {
      isLoading.toggle();
      print("getBlogDetail error: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
