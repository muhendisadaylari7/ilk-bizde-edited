// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:ilkbizde/data/model/AdsCompareRequestModel.dart';
import 'package:ilkbizde/data/model/AdsComplaintRequestModel.dart';
import 'package:ilkbizde/data/model/AdvertisementDetailRequestModel.dart';
import 'package:ilkbizde/data/model/AdvertisementDetailResponseModel.dart';
import 'package:ilkbizde/data/network/api/AdsCompareApi.dart';
import 'package:ilkbizde/data/network/api/AdsComplaintApi.dart';
import 'package:ilkbizde/data/network/api/AdsDetailApi.dart';
import 'package:ilkbizde/modules/Home/HomeController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class AdvertisementDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DefaultCacheManager cacheManager = DefaultCacheManager();

  final HtmlUnescape unescape = HtmlUnescape();

  final GetStorage storage = GetStorage();

  VideoPlayerController videoPlayerController =
      VideoPlayerController.networkUrl(
    Uri.parse(
      "",
    ),
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final HomeController homeController =
      Get.put<HomeController>(HomeController());

  final RxList<AdvertisementDetailResponseModel> adDetailsInfo =
      <AdvertisementDetailResponseModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isPlay = false.obs;
  final RxBool failedToLoadVideo = false.obs;

  LatLng location = const LatLng(0, 0);
  final RxInt currenPageIndex = 0.obs;
  final RxBool isCompareLoading = false.obs;
  final RxBool isComplaintLoading = false.obs;
  final RxBool isFavorite = false.obs;
  final RxString selectedComplaint = "Seçiniz".obs;
  final RxBool isFullScreenPhoto = false.obs;
  List<String> complaintList = <String>[
    "Seçiniz",
    "İlanda Belirtilen Ürün/Hizmet Satılmış Veya Kiralanmış",
    "İlan Bilgileri Hatalı Veya Yanlış",
    "İlan Kategorisi Hatalı",
    "İlanın Birden Fazla Kopyası Mevcut",
    "Uygunsuz İlan",
    "Diğer",
  ];
  final List<String> proComplaintList = <String>[
    "Seçiniz",
    "İlanda Belirtilen Ürün/Hizmet Satılmış Veya Kiralanmış",
    "İlan Bilgileri Hatalı Veya Yanlış",
    "İlan Kategorisi Hatalı",
    "İlanın Birden Fazla Kopyası Mevcut",
    "Uygunsuz İlan",
    "Diğer",
    "Eksik Evrak ve Belge İtirazı"
  ];

  final TextEditingController complaintDescController = TextEditingController();
  final Map<String, String?> parameters = Get.parameters;
  late TabController tabController;
  final PageController pageController = PageController();
  final RxList<File> cachedImages = <File>[].obs;

  RxInt selectedTab = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        "${dotenv.env["VIDEO_URL"]}${parameters["adId"]}.mp4",
      ),
    )..initialize().catchError((e) {
        if (e.toString().contains("Failed to load video")) {
          failedToLoadVideo.toggle();
        }
      });
    await getAdvertisementDetail();
  }

  @override
  void onClose() {
    tabController.dispose();
    videoPlayerController.dispose();
    super.onClose();
  }

  Future<void> backFunction() async {
    Get.back();
    if (parameters["isDeeplink"] == "true") {
      final HomeController homeController = Get.find<HomeController>();
      await homeController.getCategories();
      await homeController.getDailyOpportunityAdvertisements();
      await homeController.getShowcaseAdvertisements();
      await homeController.getPopularAdvertisements();
    }
  }

  // VİDEO OYNATMA
  void playPauseVideo() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController
        ..removeListener(() {})
        ..setLooping(true).then((value) {
          isPlay.toggle();
          videoPlayerController.pause();
        });
    } else {
      videoPlayerController
        ..removeListener(() {})
        ..setLooping(true).then((value) {
          isPlay.toggle();
          videoPlayerController.play();
        });
    }
  }

  // GERİ DÖNERKEN VİDEOYU DURDURMA
  void pauseVideo() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController
        ..removeListener(() {})
        ..setLooping(true).then((value) {
          isPlay.toggle();
          videoPlayerController.pause();
        });
    }
    Get.back();
  }

  Future<void> getAdvertisementDetail() async {
    isLoading.toggle();
    final AdsDetailApi adsDetailApi = AdsDetailApi();
    final AdvertisementDetailRequestModel adsDetailRequestModel =
        AdvertisementDetailRequestModel(
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userId: storage.read('uid') ?? "",
      userEmail: storage.read('uEmail') ?? "",
      userPassword: storage.read("uPassword") ?? "",
      adId: parameters['adId'].toString(),
    );
    try {
      await adsDetailApi
          .getAdsDetail(data: adsDetailRequestModel.toJson())
          .then((resp) async {
        adDetailsInfo.add(AdvertisementDetailResponseModel.fromJson(resp.data));
        isFavorite.value = adDetailsInfo[0].adFav == 1 ? true : false;
        if (adDetailsInfo[0].adMap.isNotEmpty) {
          location = LatLng(
            double.parse(adDetailsInfo[0].adMap.split(",")[0]),
            double.parse(adDetailsInfo[0].adMap.split(",")[1]),
          );
        }
      });
    } catch (e) {
      e.printError();
      isLoading.toggle();
      print("getAdvertisementDetail error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  Future<void> handleCompare(BuildContext context) async {
    isCompareLoading.toggle();
    final AdsCompareApi adsCompareApi = AdsCompareApi();
    final AdsCompareRequestModel adsCompareRequestModel =
        AdsCompareRequestModel(
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userId: storage.read('uid') ?? "",
      userEmail: storage.read('uEmail') ?? "",
      userPassword: storage.read("uPassword") ?? "",
      adId: parameters['adId'].toString(),
    );
    try {
      await adsCompareApi
          .handleCompare(data: adsCompareRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          Get.dialog(
            CustomCompareDialog(message: resp.data["message"]),
          );
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () {
            Get.back();
            Get.toNamed(Routes.LOGIN);
          });
        }
      });
    } catch (e) {
      isCompareLoading.toggle();
      print("handleCompare error: $e");
    } finally {
      isCompareLoading.toggle();
    }
  }

  void createComplaintDialog(BuildContext context, {String? adId}) async {
    if (Get.isDarkMode) {
      complaintList = proComplaintList;
    }
    selectedComplaint.value = complaintList[0];
    complaintDescController.clear();
    Get.dialog(
      CustomComplaintDialog(
        controller: this,
        sendComplaint: () => handleAdsComplaint(adId: adId),
      ),
    );
  }

  Future<void> handleAdsComplaint({String? adId}) async {
    isComplaintLoading.toggle();
    final AdsComplaintApi adsComplaintApi = AdsComplaintApi();
    final AdsComplaintRequestModel adsComplaintRequestModel =
        AdsComplaintRequestModel(
      secretKey: dotenv.env['SECRET_KEY'].toString(),
      userEmail: storage.read('uEmail') ?? "",
      userPassword: storage.read("uPassword") ?? "",
      adId: adId ?? parameters['adId'].toString(),
      adComplaintType:
          complaintList.indexOf(selectedComplaint.value).toString(),
      adComplaintDesc: complaintDescController.text,
    );

    try {
      await adsComplaintApi
          .handleAdsComplaint(data: adsComplaintRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "Success") {
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () {
            Get.back();
            Get.close(1);
          });
        } else if (resp.data["status"] == "warning") {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isComplaintLoading.toggle();
      print("handleAdsComplaint error: $e");
    } finally {
      isComplaintLoading.toggle();
    }
  }

  void launchGoogleMaps(
      {required double currentLatitude,
      required double currentLongitude}) async {
    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$currentLatitude,$currentLongitude&destination=${location.latitude},${location.longitude}';

    if (await canLaunchUrl(
      Uri.parse(googleMapsUrl),
    )) {
      await launchUrl(
        Uri.parse(googleMapsUrl),
      );
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  void getCurrentLocationAndLaunchMap() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Kullanıcı izin vermedi
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Kullanıcı kalıcı olarak izin vermedi
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    launchGoogleMaps(
      currentLatitude: position.latitude,
      currentLongitude: position.longitude,
    );
  }

  void parcelInquiry({required String url}) async {
    if (await canLaunchUrl(
      Uri.parse(url),
    )) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CustomCompareDialog extends StatelessWidget {
  final String message;
  const CustomCompareDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70.w,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: AppBorderRadius.inputRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.success,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.BLACK,
                  ),
            ),
            Direction.vertical.spacer(1),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.BLACK,
                  ),
            ),
            Direction.vertical.spacer(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDialogButton(
                  onTap: () => Get.back(),
                  color: AppColors.WHITE,
                  text: AppStrings.ok,
                  textColor: AppColors.ASHENVALE_NIGHTS,
                ),
                CustomDialogButton(
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.ADVERTISEMENTCOMPARE);
                  },
                  color: AppColors.ASHENVALE_NIGHTS,
                  text: AppStrings.compareBtnTitle,
                  textColor: AppColors.WHITE,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomComplaintDialog extends StatelessWidget {
  const CustomComplaintDialog({
    super.key,
    required this.controller,
    required this.sendComplaint,
  });

  final AdvertisementDetailController controller;
  final void Function() sendComplaint;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 70.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? AppColors.SOOTY : AppColors.WHITE,
            borderRadius: AppBorderRadius.inputRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Direction.vertical.spacer(1),
              Text(
                AppStrings.complaintDialogTitle,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Get.isDarkMode ? null : AppColors.BLACK,
                      fontFamily: AppFonts.semiBold,
                    ),
              ),
              Direction.vertical.spacer(2),
              CustomInputLabel(
                text: AppStrings.complaintTypeLabel,
                textColor: Get.isDarkMode ? null : AppColors.BLACK,
              ),
              Direction.vertical.spacer(1),
              CustomDropdownFieldWithList(
                value: controller.selectedComplaint.value,
                items: controller.complaintList
                    .map(
                      (element) => DropdownMenuItem(
                        onTap: () async =>
                            controller.selectedComplaint.value = element,
                        value: element,
                        child: Text(
                          element,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color: Get.isDarkMode
                                      ? null
                                      : AppColors.OBSIDIAN_SHARD),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Direction.vertical.spacer(1),
              // ŞİKAYET AÇIKLAMASI
              CustomInputLabel(
                text: AppStrings.complaintDescLabel,
                textColor: Get.isDarkMode ? null : AppColors.BLACK,
              ),
              Direction.vertical.spacer(1),
              Form(
                key: controller.formKey,
                child: _CustomTextAreaInput(controller: controller),
              ),
              Direction.vertical.spacer(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDialogButton(
                    onTap: () => Get.back(),
                    color: Get.isDarkMode
                        ? AppColors.BRANDEIS_BLUE.withOpacity(.1)
                        : AppColors.WHITE,
                    text: AppStrings.cancel.capitalizeFirst.toString(),
                    textColor: Get.isDarkMode
                        ? AppColors.WHITE
                        : AppColors.ASHENVALE_NIGHTS,
                  ),
                  Obx(
                    () => CustomDialogButton(
                      isLoading: controller.isComplaintLoading.value,
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          sendComplaint();
                        }
                      },
                      color: Get.isDarkMode
                          ? AppColors.BRANDEIS_BLUE
                          : AppColors.ASHENVALE_NIGHTS,
                      text: AppStrings.sendComplaint,
                      textColor: AppColors.WHITE,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextAreaInput extends StatelessWidget {
  const _CustomTextAreaInput({
    required this.controller,
  });

  final AdvertisementDetailController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return AppStrings.complaintDescEmptyError;
        }
        return null;
      },
      controller: controller.complaintDescController,
      cursorColor: AppColors.BLACK,
      maxLength: 170,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.HARD_COAL,
          ),
      minLines: 3,
      maxLines: 6,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
          ),
        ),
        hintText: AppStrings.complaintDescHint,
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.SILVER,
            ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: BorderSide(
            width: .2.w,
            color: AppColors.ASHENVALE_NIGHTS.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
