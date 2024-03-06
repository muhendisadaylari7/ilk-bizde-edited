// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/CreateAdsCategoryResponseModel.dart';
import 'package:ilkbizde/data/model/CreateAdsRequestModel.dart';
import 'package:ilkbizde/data/network/api/CreateAdsApi.dart';
import 'package:ilkbizde/modules/Navbar/NavbarController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class AdvertisementPublishSelectCategoryController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;
  final RxInt currenPageIndex = 0.obs;
  final RxString selectedCategories = "".obs;
  final RxList<RxList<CreateAdsCategoryResponseModel>> subCategories =
      <RxList<CreateAdsCategoryResponseModel>>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    // await createAds(categoryId: "");
  }

  Future<void> createAds({
    required String categoryId,
    int pageIndex = 0,
    int index = 0,
  }) async {
    isLoading.toggle();
    final CreateAdsApi createAdsApi = CreateAdsApi();
    final CreateAdsRequestModel createAdsRequestModel = CreateAdsRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
      categoryId: categoryId,
    );

    try {
      await createAdsApi
          .createAds(data: createAdsRequestModel.toJson())
          .then((resp) async {
        if (resp.data.runtimeType == List) {
          if (subCategories.length > pageIndex) {
            subCategories.removeRange(pageIndex, subCategories.length);
          }
          RxList<CreateAdsCategoryResponseModel> list =
              RxList<CreateAdsCategoryResponseModel>();
          list.value = resp.data
              .map<CreateAdsCategoryResponseModel>((subCategory) =>
                  CreateAdsCategoryResponseModel.fromJson(subCategory))
              .toList();
          subCategories.add(list);
        } else {
          if (resp.data["status"] == "success") {
            Get.toNamed(
              Routes.ADSPUBLISH,
              parameters: {
                "categoriesIds": selectedCategories.value,
              },
            );
            SnackbarType.success.CustomSnackbar(
              title: AppStrings.success,
              message: resp.data["message"].toString(),
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
          } else if (resp.data["status"] == "direct") {
            SnackbarType.error.CustomSnackbar(
              title: AppStrings.error,
              message: resp.data["message"].toString(),
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
            Get.toNamed(Routes.PERSONALINFORMATION);
            final NavbarController navbarController =
                Get.find<NavbarController>();
            navbarController.currentIndex.value = 1;
            navbarController.persistentTabController.index = 1;
          }
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("createAds() error: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
