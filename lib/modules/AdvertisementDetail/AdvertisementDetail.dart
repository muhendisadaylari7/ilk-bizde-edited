// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/data/model/GetListsRequestModel.dart';
import 'package:ilkbizde/data/network/api/GeListsApi.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/AdvertisementDetailController.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/widgets/index.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class AdvertisementDetail extends StatefulWidget {
  const AdvertisementDetail({super.key});

  @override
  State<AdvertisementDetail> createState() => _AdvertisementDetailState();
}

class _AdvertisementDetailState extends State<AdvertisementDetail> {
  final AdvertisementDetailController controller =
      Get.put(AdvertisementDetailController());
  final GetListsApi getListsApi = GetListsApi();
  final GetStorage storage = GetStorage();
  List<AdsList> lists = [];

  @override
  Widget build(BuildContext context) {
    Get.put(AdvertisementDetailController());
    return WillPopScope(
      onWillPop: () async {
        await controller.backFunction();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Bounceable(
                onTap: () async => await controller.backFunction(),
                child: Icon(
                  Icons.chevron_left_outlined,
                  size: 35.sp,
                ),
              ),
              const Spacer(flex: 4),
              const Text(
                "İlan Detayı",
                textAlign: TextAlign.center,
              ),
              Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      onTap: () {
                        Share.share(
                            "https://ilkbizde.com.tr/Advertisement-Detail/${controller.parameters["adId"]}");
                      },
                      child: Icon(
                        Icons.ios_share_outlined,
                        color: AppColors.WHITE,
                        size: 13.sp,
                      ),
                    ),
                    Direction.horizontal.spacer(2),
                    Obx(
                      () => controller.isLoading.value
                          ? SizedBox(
                              width: 2.h,
                              height: 2.h,
                              child: CircularProgressIndicator(
                                strokeWidth: .4.w,
                                color: AppColors.WHITE,
                              ),
                            )
                          : controller.parameters["dailyOpportunity"] != null
                              ? const SizedBox.shrink()
                              : CustomIconButton(
                                  onTap: () async {
                                    if (controller.isFavorite.value) {
                                      controller.homeController.removeFavorite(
                                          adId: controller.parameters['adId']
                                              .toString());
                                    } else {
                                      _onAddFavoriteButtonPressed();
                                    }

                                    controller.isFavorite.toggle();
                                  },
                                  child: Icon(
                                    controller.isFavorite.value
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: controller.isFavorite.value
                                        ? AppColors.HORNET_STING
                                        : AppColors.WHITE,
                                    size: 13.sp,
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: GetBuilder<NetworkController>(builder: (networkController) {
          if (networkController.connectionType.value == 0) {
            return const CustomNoInternetWidget();
          }
          return Stack(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.ASHENVALE_NIGHTS,
                        ),
                      )
                    : Column(
                        children: [
                          // İLAN BAŞLIĞI
                          Container(
                            width: 100.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColors.BLACK_WASH
                                    : AppColors.WHITE,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    color: AppColors.BLACK.withOpacity(.1),
                                  ),
                                ]),
                            child: Text(
                              controller.unescape.convert(
                                  controller.adDetailsInfo[0].adSubject),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          // İLAN İÇERİĞİ
                          Expanded(
                            child: CustomScrollView(
                              physics: const ClampingScrollPhysics(),
                              slivers: <Widget>[
                                SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      // Görsel
                                      SizedBox(
                                        width: 100.w,
                                        height: 35.h,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            controller.adDetailsInfo.first
                                                        .adPicCount ==
                                                    0
                                                ? Center(
                                                    child: Images.noImages
                                                        .pngWithColor(
                                                      Get.isDarkMode
                                                          ? AppColors.WHITE
                                                          : AppColors.BLACK,
                                                    ),
                                                  )
                                                : PageView.builder(
                                                    controller: controller
                                                        .pageController,
                                                    itemCount: controller
                                                        .adDetailsInfo[0]
                                                        .adPicCount,
                                                    onPageChanged: (value) {
                                                      controller.currenPageIndex
                                                          .value = value;
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Obx(
                                                        () => Bounceable(
                                                          onTap: () =>
                                                              customFullImageDialog(),
                                                          child:
                                                              CachedNetworkImage(
                                                            fadeInDuration:
                                                                Duration.zero,
                                                            imageUrl: ImageUrlTypeExtension
                                                                .getImageType(
                                                              controller
                                                                  .adDetailsInfo
                                                                  .first
                                                                  .adPic
                                                                  .split(
                                                                      ",")[index],
                                                            ).ImageUrlList(
                                                                controller
                                                                    .adDetailsInfo
                                                                    .first
                                                                    .adPic,
                                                                index),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                            !(controller.adDetailsInfo.first
                                                        .video ??
                                                    false)
                                                ? const SizedBox.shrink()
                                                : Positioned(
                                                    top: 1.h,
                                                    right: 1.w,
                                                    child: Bounceable(
                                                      onTap: () async {
                                                        if (!controller
                                                            .failedToLoadVideo
                                                            .value) {
                                                          controller
                                                              .playPauseVideo();
                                                          customFullVideoDialog();
                                                        } else {
                                                          SnackbarType.error
                                                              .CustomSnackbar(
                                                            title: AppStrings
                                                                .error,
                                                            message:
                                                                "İlana ait video henüz yüklenemedi.Tekrar deneyiniz.",
                                                          );
                                                          await Future.delayed(
                                                              const Duration(
                                                                  seconds: 2),
                                                              () => Get.back());
                                                        }
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 3.w,
                                                                vertical: .5.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors.BLACK
                                                              .withOpacity(.5),
                                                          borderRadius:
                                                              AppBorderRadius
                                                                  .inputRadius,
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .video_collection_outlined,
                                                              color: AppColors
                                                                  .WHITE,
                                                            ),
                                                            Text(
                                                              "Video",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.copyWith(
                                                                    color: AppColors
                                                                        .WHITE,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            controller.adDetailsInfo.first
                                                        .adPicCount ==
                                                    0
                                                ? const SizedBox.shrink()
                                                : Positioned(
                                                    width: 15.w,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors.BLACK
                                                            .withOpacity(.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          14.sp,
                                                        ),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${controller.currenPageIndex.value + 1}/${controller.adDetailsInfo.first.adPicCount}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                              color: AppColors
                                                                  .WHITE,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      // İLAN SAHİBİ BİLGİLERİ
                                      Container(
                                        width: 100.w,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 1.5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Get.isDarkMode
                                              ? AppColors.BLACK_WASH
                                              : AppColors.WHITE,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 4),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color: AppColors.BLACK
                                                  .withOpacity(.1),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "${controller.adDetailsInfo[0].userDt?.ad ?? ""} ${controller.adDetailsInfo[0].userDt?.soyad ?? ""}",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  color: AppColors.BLUE_RIBBON),
                                        ),
                                      ),
                                      Direction.vertical.spacer(.5),
                                      // KATEGORİ YOLU
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          controller.adDetailsInfo[0]
                                              .categoryList.length,
                                          (index) => Bounceable(
                                            onTap: () {
                                              if (Get.previousRoute !=
                                                      Routes.NAVBAR &&
                                                  Get.previousRoute !=
                                                      Get.currentRoute) {
                                                Get.back();
                                                Get.offNamed(
                                                  Routes.CATEGORYRESULTPAGE,
                                                  parameters: {
                                                    "categoryId": controller
                                                        .adDetailsInfo[0]
                                                        .categoryList[index]
                                                        .categoryId
                                                        .toString(),
                                                    "totalAds": (controller
                                                                        .parameters[
                                                                    "isUrgent"] ??
                                                                "")
                                                            .isNotEmpty
                                                        ? controller
                                                            .adDetailsInfo[0]
                                                            .categoryList[index]
                                                            .categoryUrgentAdCount
                                                        : (controller.parameters[
                                                                        "isLast24"] ??
                                                                    "")
                                                                .isNotEmpty
                                                            ? controller
                                                                .adDetailsInfo[
                                                                    0]
                                                                .categoryList[
                                                                    index]
                                                                .categoryLast48AdCount
                                                            : controller
                                                                .adDetailsInfo[
                                                                    0]
                                                                .categoryList[
                                                                    index]
                                                                .categoryAdCount
                                                                .replaceAll(
                                                                    "(", "")
                                                                .replaceAll(
                                                                    ")", ""),
                                                    "isUrgent": controller
                                                        .parameters["isUrgent"]
                                                        .toString(),
                                                    "isLast24": controller
                                                        .parameters["isLast24"]
                                                        .toString(),
                                                  },
                                                );
                                              } else {
                                                Get.toNamed(
                                                  Routes.CATEGORYRESULTPAGE,
                                                  parameters: {
                                                    "categoryId": controller
                                                        .adDetailsInfo[0]
                                                        .categoryList[index]
                                                        .categoryId
                                                        .toString(),
                                                    "totalAds": (controller
                                                                        .parameters[
                                                                    "isUrgent"] ??
                                                                "")
                                                            .isNotEmpty
                                                        ? controller
                                                            .adDetailsInfo[0]
                                                            .categoryList[index]
                                                            .categoryUrgentAdCount
                                                        : (controller.parameters[
                                                                        "isLast24"] ??
                                                                    "")
                                                                .isNotEmpty
                                                            ? controller
                                                                .adDetailsInfo[
                                                                    0]
                                                                .categoryList[
                                                                    index]
                                                                .categoryLast48AdCount
                                                            : controller
                                                                .adDetailsInfo[
                                                                    0]
                                                                .categoryList[
                                                                    index]
                                                                .categoryAdCount
                                                                .replaceAll(
                                                                    "(", "")
                                                                .replaceAll(
                                                                    ")", ""),
                                                    "isUrgent": controller
                                                        .parameters["isUrgent"]
                                                        .toString(),
                                                    "isLast24": controller
                                                        .parameters["isLast24"]
                                                        .toString(),
                                                  },
                                                );
                                              }
                                            },
                                            child: Text(
                                              "${controller.adDetailsInfo[0].categoryList[index].categoryName}${controller.adDetailsInfo[0].categoryList.length - 1 == index ? "" : " > "}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    color:
                                                        AppColors.BLUE_RIBBON,
                                                    fontFamily: AppFonts.medium,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Direction.vertical.spacer(.5),
                                      // ŞEHİR, İLÇE, MAHALLE
                                      Text(
                                        "${controller.adDetailsInfo[0].adLocation.adCity}, ${controller.adDetailsInfo[0].adLocation.adDistinct}, ${controller.adDetailsInfo[0].adLocation.adMahalle}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontFamily: AppFonts.medium,
                                            ),
                                      ),
                                      Direction.vertical.spacer(.5),
                                    ],
                                  ),
                                ),
                                // ALL TABS
                                SliverAppBar(
                                  pinned: true,
                                  backgroundColor: Get.isDarkMode
                                      ? AppColors.BLACK_WASH
                                      : AppColors.WHITE,
                                  automaticallyImplyLeading: false,
                                  titleSpacing: 0,
                                  title: Container(
                                    width: 100.w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.CHEERFUL_YELLOW,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomTabWidget(
                                            onTap: () {
                                              controller.tabController
                                                  .animateTo(0);
                                            },
                                            tabIndex: 0,
                                            title: "İlan Bilgileri",
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomTabWidget(
                                            onTap: () {
                                              controller.tabController
                                                  .animateTo(1);
                                            },
                                            tabIndex: 1,
                                            title: "Açıklama",
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomTabWidget(
                                            onTap: () {
                                              controller.tabController
                                                  .animateTo(2);
                                            },
                                            tabIndex: 2,
                                            title: "Konumu",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // TABS CONTENT
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                    [
                                      controller.selectedTab.value == 0
                                          ? CustomAdsInfoTab(
                                              controller: controller,
                                            )
                                          : controller.selectedTab.value == 1
                                              ? CustomDescTab(
                                                  controller: controller)
                                              : CustomLocationTab(
                                                  controller: controller,
                                                )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              // ARAMA YÖNLENDİRME BUTONU
              Positioned(
                bottom: 0,
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ).copyWith(
                    bottom: 3.h,
                  ),
                  child: CustomButton(
                    height: 4.2.h,
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 11.2.sp,
                          color: Get.isDarkMode ? AppColors.WHITE : null,
                        ),
                    title: AppStrings.call,
                    bg: Get.isDarkMode
                        ? AppColors.BRANDEIS_BLUE
                        : AppColors.ASHENVALE_NIGHTS,
                    onTap: () async {
                      final Uri phone = Uri(
                        scheme: 'tel',
                        path: controller.adDetailsInfo[0].userDt?.gsm ?? "",
                      );
                      if (await canLaunchUrl(phone)) {
                        await launchUrl(phone);
                      } else {
                        SnackbarType.error.CustomSnackbar(
                            title: AppStrings.error,
                            message: "Telefon numarası bulunamadı.");
                        await Future.delayed(
                            const Duration(seconds: 2), () => Get.back());
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  _onAddFavoriteButtonPressed() {
    return _getMyLists().then((lists) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Liste Seç",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: AppColors.BLACK,
              )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.WHITE,
                    backgroundColor: AppColors.RED, // Yazı rengi beyaz
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Kenarları yuvarlama
                    ),
                  ),

                  child: const Text('İptal',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        color: AppColors.WHITE,
                      )), // Buton üzerindeki yazı
                ),
              ],
            )
          ],
          content: SizedBox(
              width: 100.w,
              height: 40.h,
              child: ListView(children: [
                if (lists.isEmpty)
                  const ListTile(
                    title: Text("Liste bulunamadı."),
                  ),
                for (var item in lists)
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.BLACK.withOpacity(.1),
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(item.title),
                      onTap: () {
                        Get.back(result: item.id);
                        controller.homeController.addFavorite(
                            adId: controller.parameters['adId'].toString(),
                            listId: item.id.toString());
                      },
                    ),
                  ),
              ])),
        ),
      );
    });
  }

  Future<List<AdsList>> _getMyLists() async {
    List<AdsList> lists = [];
    return await getListsApi
        .getLists(
            data: GetListsRequestModel(
                secretKey: dotenv.env["SECRET_KEY"].toString(),
                userId: storage.read("uid") ?? "",
                userEmail: storage.read("uEmail") ?? "",
                userPassword: storage.read("uPassword") ?? ""))
        .then((value) {
      if (value.data == null) return [];
      for (var item in value.data) {
        lists.add(AdsList(id: item["id"], title: item["baslik"]));
      }
      return lists;
    });
  }

  // ADS IMAGE FULL SLIDER
  Future<dynamic> customFullImageDialog() {
    return Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomSliderPhotoFocus(
          controller: controller,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  // ADS VIDEO FULL SCREEN
  Future<dynamic> customFullVideoDialog() {
    return Get.dialog(
      Scaffold(
        backgroundColor: AppColors.BLACK.withOpacity(.5),
        body: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Center(
                    child: SizedBox(
                      height: 75.h,
                      child: VideoPlayer(
                        controller.videoPlayerController,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1.w,
                  left: 1.w,
                  child: Obx(
                    () => CustomIconButton(
                      onTap: () => controller.playPauseVideo(),
                      color: AppColors.BLACK.withOpacity(.3),
                      child: Icon(
                        controller.isPlay.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: AppColors.WHITE,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 2.h,
                  right: 2.h,
                  child: CustomIconButton(
                    onTap: () => controller.pauseVideo(),
                    child: Icon(
                      Icons.close,
                      color: AppColors.WHITE,
                      size: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class AdsList {
  final String id;
  final String title;

  AdsList({required this.id, required this.title});
}
