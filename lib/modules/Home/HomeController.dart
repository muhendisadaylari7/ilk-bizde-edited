// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/src/storage_impl.dart';
import 'package:ilkbizde/data/model/AddAdToListRequestModel.dart';
import 'package:ilkbizde/data/model/CategoriesRequestModel.dart';
import 'package:ilkbizde/data/model/CategoriesResponseModel.dart';
import 'package:ilkbizde/data/model/DailyOpportunityAdvertisementModel.dart';
import 'package:ilkbizde/data/model/DeleteAdFromListRequestModel.dart';
import 'package:ilkbizde/data/model/DistrictModel.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/GetListAdsRequestModel.dart';
import 'package:ilkbizde/data/model/GetListsRequestModel.dart';
import 'package:ilkbizde/data/model/PopularAdvertisementModel.dart';
import 'package:ilkbizde/data/model/ShowcaseAdvertisementModel.dart';
import 'package:ilkbizde/data/network/api/AddAdToListRequestApi.dart';
import 'package:ilkbizde/data/network/api/AllCategoriesApi.dart';
import 'package:ilkbizde/data/network/api/DailyOpportunityAdsApi.dart';
import 'package:ilkbizde/data/network/api/DeleteAdFromListRequestApi.dart';
import 'package:ilkbizde/data/network/api/GeListsApi.dart';
import 'package:ilkbizde/data/network/api/GetListAdsRequestApi.dart';
import 'package:ilkbizde/data/network/api/PopularAdvertisementApi.dart';
import 'package:ilkbizde/data/network/api/ShowcaseAdvertisementApi.dart';
import 'package:ilkbizde/modules/Navbar/NavbarController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class HomeController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;
  final RxBool isProPopup = false.obs;
  final RxBool isFavoriteLoading = false.obs;

  RxList<ShowcaseAdvertisementModel> showcaseAdvertisements =
      <ShowcaseAdvertisementModel>[].obs;
  RxList<PopularAdvertisementModel> popularAdvertisements =
      <PopularAdvertisementModel>[].obs;
  RxList<DailyOpportunityAdvertisementModel> dailyOpportunityAdvertisements =
      <DailyOpportunityAdvertisementModel>[].obs;
  RxList<DistrictModel> allDistricts = <DistrictModel>[].obs;
  RxList<CategoriesResponseModel> allCategories =
      <CategoriesResponseModel>[].obs;

  final PageController pageController = PageController(viewportFraction: .7);
  final PageController opportunityPageController = PageController();

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

// BANA GÖRE İLANLARI GETİR
  Future<void> getPopularAdvertisements() async {
    isLoading.toggle();
    final PopularAdvertisementApi popularAdvertisementApi =
        PopularAdvertisementApi();
    GeneralRequestModel advertisementRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
      pro: Get.isDarkMode ? "1" : "",
    );

    try {
      await popularAdvertisementApi
          .getPopularAdvertisement(data: advertisementRequestModel.toJson())
          .then((resp) {
        popularAdvertisements.value = resp.data
            .map<PopularAdvertisementModel>((advertisement) =>
                PopularAdvertisementModel.fromJson(advertisement))
            .toList();
      });
    } catch (e) {
      isLoading.toggle();
      print("getPopularAdvertisements() error: $e");
    } finally {
      isLoading.toggle();
    }
  }

// GÜNÜN FIRSATI İLANLARINI GETİR
  Future<void> getDailyOpportunityAdvertisements() async {
    isLoading.toggle();
    final DailyOpportunityAdsApi dailyOpportunityAdsApi =
        DailyOpportunityAdsApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
    );
    try {
      await dailyOpportunityAdsApi
          .getDailyOpportunityAdvertisement(data: generalRequestModel.toJson())
          .then((resp) {
        dailyOpportunityAdvertisements.value = resp.data
            .map<DailyOpportunityAdvertisementModel>((advertisement) =>
                DailyOpportunityAdvertisementModel.fromJson(advertisement))
            .toList();
      });
    } catch (e) {
      isLoading.toggle();
      print("getDailyOpportunityAdvertisements() error: $e");
    } finally {
      isLoading.toggle();
    }
  }

// FAVORİYE EKLE
  Future<void> addFavorite(
      {required String adId, required String listId}) async {
    isFavoriteLoading.toggle();
    final AddAdToListRequestApi addAdToListRequestApi = AddAdToListRequestApi();
    final AddAdToListRequestModel addOrDeleteFavoriteRequestModel =
        AddAdToListRequestModel(
            secretKey: dotenv.env["SECRET_KEY"].toString(),
            userId: storage.read("uid") ?? "",
            userEmail: storage.read("uEmail") ?? "",
            userPassword: storage.read("uPassword") ?? "",
            adId: adId,
            listId: listId);
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    try {
      await addAdToListRequestApi
          .addAdToList(data: addOrDeleteFavoriteRequestModel)
          .then((resp) async {
        if (resp.data["status"] == "Success") {
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          var foundAd = showcaseAdvertisements.firstWhere(
            (ads) => ads.adId == adId,
          );
          foundAd.fav = foundAd.fav == 0 ? 1 : 0;
          showcaseAdvertisements.refresh();

          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          Get.snackbar("Başarılı", resp.data["message"]);
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () {});
        } else if (resp.data["status"] == "error") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          Get.snackbar("Başarısız", resp.data["message"]);
        }
      });
    } catch (e) {
      isFavoriteLoading.toggle();
      print("addFavorite() error: $e");
    } finally {
      isFavoriteLoading.toggle();
    }
  }

  Future<void> removeFavorite({required String adId}) async {
    isFavoriteLoading.toggle();
    String listAdsId;
    final DeleteAdFromListRequestApi deleteAdFromListRequestApi =
        DeleteAdFromListRequestApi();

    final GetListAdsRequestApi getListAdsRequestApi = GetListAdsRequestApi();
    final GetListsApi getListsApi = GetListsApi();
    final GetListsRequestModel getListsRequestModel = GetListsRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
    );
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }

    try {
      getListsApi.getLists(data: getListsRequestModel).then((resp) {
        if (resp.data == null) return;
        for (var list in resp.data) {
          var tempListId = list["id"];
          getListAdsRequestApi
              .getListAds(
                  data: GetListAdsRequestModel(
                      secretKey: dotenv.env["SECRET_KEY"].toString(),
                      userId: storage.read("uid") ?? "",
                      userEmail: storage.read("uEmail") ?? "",
                      userPassword: storage.read("uPassword") ?? "",
                      listId: tempListId))
              .then((value) {
            for (var ad in value.data) {
              if (ad["adId"] == adId) {
                listAdsId = ad["listAdsId"];
                deleteAdFromListRequestApi
                    .deleteAdFromList(
                        data: DeleteAdFromListRequestModel(
                            secretKey: dotenv.env["SECRET_KEY"].toString(),
                            userId: storage.read("uid") ?? "",
                            userEmail: storage.read("uEmail") ?? "",
                            userPassword: storage.read("uPassword") ?? "",
                            listAdsId: listAdsId))
                    .then((value) async {
                  if (value.data == null) return;
                  if (value.data["status"] == "Success") {
                    SnackbarType.success.CustomSnackbar(
                        title: AppStrings.success,
                        message: resp.data["message"]);
                    await Future.delayed(const Duration(seconds: 2), () {});
                  } else {
                    SnackbarType.error.CustomSnackbar(
                        title: AppStrings.error, message: resp.data["message"]);
                    await Future.delayed(const Duration(seconds: 2), () {});
                  }
                });
              }
            }
          });
        }
      });
    } catch (e) {
      isFavoriteLoading.toggle();
      print("addFavorite() error: $e");
    } finally {
      isFavoriteLoading.toggle();
    }
  }

// KATEGORİLERİ GETİR
  Future<void> getCategories() async {
    final AllCategoriesApi allCategoriesApi = AllCategoriesApi();
    final CategoriesRequestModel categoriesRequestModel =
        CategoriesRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      pro: Get.isDarkMode ? "1" : "",
    );
    try {
      await allCategoriesApi
          .getCategories(data: categoriesRequestModel.toJson())
          .then((resp) {
        allCategories.value = resp.data
            .map<CategoriesResponseModel>(
                (category) => CategoriesResponseModel.fromJson(category))
            .toList();
        allCategories.refresh();
      });
    } catch (e) {
      print("getCategories() error: $e");
    }
  }

  void redirectToSelectCategoryPage(int index) {
    final CategoriesResponseModel categoriesResponseModel =
        CategoriesResponseModel(
      categoryId: allCategories[index].categoryId,
      categoryName: allCategories[index].categoryName,
      categoryAdCount: allCategories[index].categoryAdCount,
    );
    Get.toNamed(
      Routes.SELECTCATEGORYPAGE,
      parameters: categoriesResponseModel.toJson(),
    );
  }

  int calculateSmoothPageIndicatorDot() {
    final int result = (showcaseAdvertisements.length / 2).ceil();
    return result == 0 ? 1 : result;
  }

  int calculateSmoothPageIndicatorDotForDailyOpportunity() {
    return dailyOpportunityAdvertisements.isEmpty
        ? 1
        : dailyOpportunityAdvertisements.length;
  }
}
