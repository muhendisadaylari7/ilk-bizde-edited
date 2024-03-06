import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/OpenMarketCategoriesRequestModel.dart';
import 'package:ilkbizde/data/model/OpenMarketCategoriesResponseModel.dart';
import 'package:ilkbizde/data/model/OpenMarketRequestModel.dart';
import 'package:ilkbizde/data/network/api/OpenMarketApi.dart';
import 'package:ilkbizde/modules/CategoryResultPage/CategoryResultPageController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/widgets/CustomPersonalInfoInput.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;

class MyStoreInfoController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;
  final RxBool createStoreLoading = false.obs;

  final RxString selectedMarketCategory = "".obs;

  final RxList<OpenMarketCategoriesResponseModel> categories =
      <OpenMarketCategoriesResponseModel>[].obs;

  final RxList<TextEditingController> marketInfos =
      <TextEditingController>[].obs;

  final Rx<File> image = File("").obs;

  @override
  void onInit() {
    super.onInit();
    getMarketCategories();
  }

  // FOTOĞRAF YÜKLE
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery).then((value) async {
      image.value = File(value!.path);
    });
  }

// Market Categories
  Future<void> getMarketCategories() async {
    isLoading.toggle();
    final OpenMarketCategoriesRequestModel openMarketCategoriesRequestModel =
        OpenMarketCategoriesRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      asama: "kategoriler",
    );
    final OpenMarketApi openMarketApi = OpenMarketApi();
    try {
      await openMarketApi
          .handleOpenMarketApi(data: openMarketCategoriesRequestModel.toJson())
          .then(
        (resp) {
          categories.clear();
          marketInfos.clear();
          if (resp.data == null) return;
          categories.add(OpenMarketCategoriesResponseModel.fromJson(resp.data));
          marketInfos.addAll(
            List.generate(
              categories.first.kategoriBilgileri.length,
              (index) => TextEditingController(),
            ),
          );
        },
      );
    } catch (e) {
      isLoading.toggle();
      print("handleOpenMarket error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // Handle Create Market
  Future<void> handleCreateMarket(
      {required String categoryId, required String duration}) async {
    createStoreLoading.toggle();
    final OpenMarketRequestModel openMarketRequestModel =
        OpenMarketRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      asama: "kategoriBilgileri",
      kullaniciAdi: marketInfos[0].text,
      aciklama: marketInfos[1].text,
      ad: marketInfos[2].text,
      category: categoryId,
      duration: duration,
    );
    dio.FormData formData =
        dio.FormData.fromMap(openMarketRequestModel.toJson());
    formData.files.add(
      MapEntry(
        "images",
        await dio.MultipartFile.fromFile(
          image.value.path,
          filename: image.value.path,
        ),
      ),
    );

    final OpenMarketApi openMarketApi = OpenMarketApi();
    try {
      await openMarketApi
          .handleOpenMarketApi(isMultipart: true, formData: formData)
          .then(
        (resp) async {
          if (resp.data == null) return;
          if (resp.data["status"] == "success") {
            SnackbarType.success.CustomSnackbar(
                title: AppStrings.success, message: resp.data["message"]);
            await Future.delayed(Duration(seconds: 2), () => Get.back());
            Get.close(1);
          } else {
            SnackbarType.error.CustomSnackbar(
                title: AppStrings.error, message: resp.data["message"]);
            await Future.delayed(Duration(seconds: 2), () => Get.back());
          }
        },
      );
    } catch (e) {
      createStoreLoading.toggle();
      print("handleOpenMarket error: $e");
    } finally {
      createStoreLoading.toggle();
    }
  }
}

extension getMarketInfoWidgetFromFilterType on FilterType {
  static FilterType getFilterType(String filterType) {
    switch (filterType) {
      case "text":
        return FilterType.text;
      default:
        return FilterType.text;
    }
  }

  Widget getWidget(
    String title,
    RxList<TextEditingController> textEditingControllerList,
    BuildContext context,
    int index,
  ) {
    switch (this) {
      case FilterType.text:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 13.sp),
            ),
            Direction.vertical.spacer(1),
            CustomPersonalInfoInput(
              hintText: "${title.toLowerCase().capitalizeFirst} giriniz lütfen",
              validator: (p0) {
                if (p0!.isEmpty) {
                  return "Zorunlu alan";
                }
                return null;
              },
              textEditingController: textEditingControllerList[index],
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }
}
