// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/CategoriesResponseModel.dart';
import 'package:ilkbizde/data/model/SubCategoriesRequestModel.dart';
import 'package:ilkbizde/data/network/api/Last24HourApi.dart';
import 'package:ilkbizde/data/network/api/SubCategoriesApi.dart';
import 'package:ilkbizde/data/network/api/UrgentCategoryApi.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class SelectCategoryPageController extends GetxController {
  final GetStorage storage = GetStorage();
  final Map<String, String?> parameters = Get.parameters;

  RxBool isLoading = false.obs;
  RxInt currenPageIndex = 0.obs;

  final RxList<RxList<CategoriesResponseModel>> totalSubCategoriesList =
      <RxList<CategoriesResponseModel>>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (parameters["isUrgent"].toString() == "1") {
      getUrgentOrLast24HourSubCategories(
        subCategoriesApi: UrgentCategoryApi(),
        parameter: "isUrgent",
        categoryId: parameters["categoryId"].toString(),
        categoryName: parameters["categoryName"].toString(),
        categoryCount: parameters["categoryAdCount"].toString(),
      );
      return;
    } else if (parameters["isLast24"].toString() == "1") {
      getUrgentOrLast24HourSubCategories(
        subCategoriesApi: Last24HourApi(),
        parameter: "isLast24",
        categoryId: parameters["categoryId"].toString(),
        categoryName: parameters["categoryName"].toString(),
        categoryCount: parameters["categoryAdCount"].toString(),
      );
      return;
    }
    getSubCategories(
      categoryId: parameters["categoryId"].toString(),
      categoryName: parameters["categoryName"].toString(),
      categoryCount: parameters["categoryAdCount"].toString(),
    );
  }

  // ACİL VE SON DAKİKA KATEGORİLER
  Future<void> getUrgentOrLast24HourSubCategories({
    required dynamic subCategoriesApi,
    required String parameter,
    required String categoryId,
    required String categoryName,
    required String categoryCount,
    int pageIndex = 0,
    int index = 0,
  }) async {
    isLoading.toggle();
    final SubCategoriesRequestModel subCategoriesRequestModel =
        SubCategoriesRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      categoryId: categoryId,
    );
    final CategoriesResponseModel categoriesResponseModel =
        CategoriesResponseModel(
      categoryId: categoryId,
      categoryName: """Tüm "$categoryName" İlanları""",
      categoryAdCount: categoryCount,
    );
    try {
      await subCategoriesApi
          .getSubCategories(data: subCategoriesRequestModel.toJson())
          .then((resp) async {
        if (resp.data.isEmpty &&
            totalSubCategoriesList[pageIndex - 1][index].categoryAdCount ==
                "(0)") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: AppStrings.noAdsInThisCategory);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          return;
        } else if (resp.data.isEmpty &&
            totalSubCategoriesList[pageIndex - 1][index].categoryAdCount !=
                "(0)") {
          Get.toNamed(Routes.CATEGORYRESULTPAGE, parameters: {
            "categoryId":
                totalSubCategoriesList[pageIndex - 1][index].categoryId,
            "totalAds":
                totalSubCategoriesList[pageIndex - 1][index].categoryAdCount ??
                    "",
            parameter: parameters[parameter] ?? "",
          });
          totalSubCategoriesList.removeRange(
              pageIndex, totalSubCategoriesList.length);
          return;
        }

        // EĞER GERİYE DÖNÜP BAŞKA KATEGORİ SEÇİLİRSE, O KATEGORİDEN SONRAKİ TÜM KATEGORİLERİ SİL
        if (totalSubCategoriesList.length > pageIndex) {
          totalSubCategoriesList.removeRange(
              pageIndex, totalSubCategoriesList.length);
        }

        int totalAdsCount = 0;
        RxList<CategoriesResponseModel> list =
            RxList<CategoriesResponseModel>();
        list.value = resp.data
            .map<CategoriesResponseModel>(
                (subCategory) => CategoriesResponseModel.fromJson(subCategory))
            .toList();
        for (var ad in list) {
          totalAdsCount += int.parse(ad.categoryAdCount ?? "");
          categoriesResponseModel.categoryAdCount =
              "(${totalAdsCount.toString()})";
          ad.categoryAdCount = "(${ad.categoryAdCount})";
        }
        list.insert(0, categoriesResponseModel);
        totalSubCategoriesList.add(list);
      });
    } catch (e) {
      isLoading.toggle();
      print("getSubCategories() error: $e");
    } finally {
      isLoading.toggle();
    }
  }

// ALT KATEGORİLER
  Future<void> getSubCategories({
    required String categoryId,
    required String categoryName,
    required String categoryCount,
    int pageIndex = 0,
    int index = 0,
  }) async {
    isLoading.toggle();
    final SubCategoriesApi subCategoriesApi = SubCategoriesApi();
    final SubCategoriesRequestModel subCategoriesRequestModel =
        SubCategoriesRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      categoryId: categoryId,
      pro: Get.isDarkMode ? "1" : "",
    );
    final CategoriesResponseModel categoriesResponseModel =
        CategoriesResponseModel(
      categoryId: categoryId,
      categoryName: """Tüm "$categoryName" İlanları""",
      categoryAdCount: categoryCount,
    );
    try {
      await subCategoriesApi
          .getSubCategories(data: subCategoriesRequestModel.toJson())
          .then((resp) async {
        if (resp.data.isEmpty &&
            totalSubCategoriesList[pageIndex - 1][index].categoryAdCount ==
                "(0)") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: AppStrings.noAdsInThisCategory);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          return;
        } else if (resp.data.isEmpty &&
            totalSubCategoriesList[pageIndex - 1][index].categoryAdCount !=
                "(0)") {
          Get.toNamed(Routes.CATEGORYRESULTPAGE, parameters: {
            "categoryId":
                totalSubCategoriesList[pageIndex - 1][index].categoryId,
            "totalAds":
                totalSubCategoriesList[pageIndex - 1][index].categoryAdCount ??
                    "",
          });
          totalSubCategoriesList.removeRange(
              pageIndex, totalSubCategoriesList.length);
          return;
        }

        // EĞER GERİYE DÖNÜP BAŞKA KATEGORİ SEÇİLİRSE, O KATEGORİDEN SONRAKİ TÜM KATEGORİLERİ SİL
        if (totalSubCategoriesList.length > pageIndex) {
          totalSubCategoriesList.removeRange(
              pageIndex, totalSubCategoriesList.length);
        }

        RxList<CategoriesResponseModel> list =
            RxList<CategoriesResponseModel>();
        list.value = resp.data
            .map<CategoriesResponseModel>(
                (subCategory) => CategoriesResponseModel.fromJson(subCategory))
            .toList();
        list.insert(0, categoriesResponseModel);
        totalSubCategoriesList.add(list);
      });
    } catch (e) {
      isLoading.toggle();
      SnackbarType.error.CustomSnackbar(
          title: AppStrings.error, message: AppStrings.noAdsInThisCategory);
      await Future.delayed(const Duration(seconds: 2), () => Get.back());
      Get.close(1);
      print("getSubCategories() error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  Future<bool> redirectToCategoryResult(int index, int pageIndex) async {
    if (index == 0 &&
        totalSubCategoriesList[pageIndex][index].categoryAdCount != "(0)") {
      Get.toNamed(Routes.CATEGORYRESULTPAGE, parameters: {
        "categoryId": totalSubCategoriesList[pageIndex][index].categoryId,
        "totalAds":
            totalSubCategoriesList[pageIndex][index].categoryAdCount ?? "",
        "isUrgent": parameters["isUrgent"] ?? "",
        "isLast24": parameters["isLast24"] ?? "",
      });
      totalSubCategoriesList.removeRange(
          pageIndex + 1, totalSubCategoriesList.length);
      return true;
    } else if (totalSubCategoriesList[pageIndex][index].categoryAdCount ==
                "(0)" &&
            index == 0 ||
        totalSubCategoriesList.isEmpty) {
      SnackbarType.error.CustomSnackbar(
          title: AppStrings.error, message: AppStrings.noAdsInThisCategory);
      await Future.delayed(const Duration(seconds: 2), () => Get.back());
      return true;
    }
    return false;
  }
}
