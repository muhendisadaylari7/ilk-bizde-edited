// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdsPublish/index.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/widgets/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CacheSize.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomAdsPreviewInfos extends StatelessWidget {
  final AdsPublishController controller;
  const CustomAdsPreviewInfos({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.OROCHIMARU,
      body: Obx(
        () => controller.isStepLoading.value
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
                    decoration:
                        BoxDecoration(color: AppColors.OROCHIMARU, boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: AppColors.BLACK.withOpacity(.1),
                      ),
                    ]),
                    child: Text(
                      controller.previewInfos.first.adSubject,
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
                                    controller.previewInfos.first.adPicCount ==
                                            0
                                        ? Center(
                                            child: Images.noImages.pngWithColor(
                                              AppColors.BLACK,
                                            ),
                                          )
                                        : PageView.builder(
                                            controller: controller
                                                .previewImagePageController,
                                            itemCount: controller
                                                .previewInfos.first.adPicCount,
                                            onPageChanged: (value) {
                                              controller
                                                  .previewImageSliderCurrentIndex
                                                  .value = value;
                                            },
                                            itemBuilder: (context, index) {
                                              return Bounceable(
                                                onTap: () =>
                                                    customFullImageDialog(),
                                                child: CachedNetworkImage(
                                                  fadeInDuration: Duration.zero,
                                                  memCacheHeight:
                                                      35.h.cacheSize(context),
                                                  imageUrl:
                                                      ImageUrlTypeExtension
                                                          .getImageType(
                                                    controller.previewInfos
                                                        .first.adPic
                                                        .split(",")[index],
                                                  ).ImageUrlList(
                                                          controller
                                                              .previewInfos
                                                              .first
                                                              .adPic,
                                                          index),
                                                ),
                                              );
                                            },
                                          ),
                                    (controller.previewInfos.first.video ??
                                                false) ==
                                            false
                                        ? const SizedBox.shrink()
                                        : Positioned(
                                            top: 1.h,
                                            right: 1.w,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w,
                                                  vertical: .5.h),
                                              decoration: BoxDecoration(
                                                color: AppColors.BLACK
                                                    .withOpacity(.5),
                                                borderRadius:
                                                    AppBorderRadius.inputRadius,
                                              ),
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .video_collection_outlined,
                                                    color: AppColors.WHITE,
                                                  ),
                                                  Text(
                                                    "Video",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall
                                                        ?.copyWith(
                                                          color:
                                                              AppColors.WHITE,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    controller.previewInfos.first.adPicCount ==
                                            0
                                        ? const SizedBox.shrink()
                                        : Positioned(
                                            width: 15.w,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.BLACK
                                                    .withOpacity(.5),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.sp,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${controller.previewImageSliderCurrentIndex.value + 1}/${controller.previewInfos.first.adPicCount}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color: AppColors.WHITE,
                                                    ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Direction.vertical.spacer(.5),
                              // ŞEHİR, İLÇE, MAHALLE
                              Text(
                                "${controller.previewInfos.first.adLocation.adCity}, ${controller.previewInfos.first.adLocation.adDistinct}, ${controller.previewInfos.first.adLocation.adMahalle}",
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
                          backgroundColor: AppColors.OROCHIMARU,
                          automaticallyImplyLeading: false,
                          titleSpacing: 0,
                          title: Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.CHEERFUL_YELLOW,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _CustomTabWidget(
                                    tabIndex: 0,
                                    title: "İlan Bilgileri",
                                  ),
                                ),
                                Expanded(
                                  child: _CustomTabWidget(
                                    tabIndex: 1,
                                    title: "Açıklama",
                                  ),
                                ),
                                Expanded(
                                  child: _CustomTabWidget(
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
                                  ? _CustomAdsInfoTab(controller: controller)
                                  : controller.selectedTab.value == 1
                                      ? _CustomDescTab(controller: controller)
                                      : _CustomLocationTab(
                                          controller: controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // ADS IMAGE FULL SLIDER
  Future<dynamic> customFullImageDialog() {
    return Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: AppColors.BLACK.withOpacity(.5),
          body: WillPopScope(
            onWillPop: () async {
              controller.previewImagePageController.animateToPage(
                controller.previewImageSliderCurrentIndex.value,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
              return true;
            },
            child: SafeArea(
              child: Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: PageController(
                          initialPage:
                              controller.previewImageSliderCurrentIndex.value),
                      itemCount: controller.previewInfos.first.adPicCount,
                      onPageChanged: (value) {
                        controller.previewImageSliderCurrentIndex.value = value;
                      },
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          fadeInDuration: Duration.zero,
                          imageUrl: ImageUrlTypeExtension.getImageType(
                            controller.previewInfos.first.adPic
                                .split(",")[index],
                          ).ImageUrlList(
                              controller.previewInfos.first.adPic, index),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      width: 15.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.BLACK.withOpacity(.5),
                          borderRadius: BorderRadius.circular(
                            14.sp,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "${controller.previewImageSliderCurrentIndex.value + 1}/${controller.previewInfos.first.adPicCount}",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.WHITE,
                                  ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2.h,
                      right: 2.h,
                      child: CustomIconButton(
                        onTap: () {
                          controller.previewImagePageController.animateToPage(
                            controller.previewImageSliderCurrentIndex.value,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                          Get.back();
                        },
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
}

class _CustomLocationTab extends StatelessWidget {
  const _CustomLocationTab({
    required this.controller,
  });

  final AdsPublishController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          controller.currentLocation == const LatLng(0, 0)
              ? Column(
                  children: [
                    Direction.vertical.spacer(5),
                    const Icon(
                      Icons.not_listed_location_outlined,
                      color: AppColors.BLACK,
                    ),
                    Direction.vertical.spacer(3),
                    Text(
                      "Konum bilgisi eklenmemiştir.",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.BLACK,
                              ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 70.h,
                      child: FlutterMap(
                        options: MapOptions(
                          interactionOptions: const InteractionOptions(
                            rotationWinGestures: MultiFingerGesture.none,
                          ),
                          initialCenter: controller.currentLocation,
                          initialZoom: 15,
                        ),
                        children: [
                          Obx(
                            () => TileLayer(
                              retinaMode: true,
                              urlTemplate: controller.isSatellite.value
                                  ? "https://mt.google.com/vt/lyrs=s&x={x}&y={y}&z={z}"
                                  : "https://mt.google.com/vt/lyrs=r&x={x}&y={y}&z={z}",
                              subdomains: const ['a', 'b', 'c'],
                            ),
                          ),
                          MarkerLayer(
                            rotate: true,
                            markers: [
                              Marker(
                                rotate: true,
                                point: controller.currentLocation,
                                child: Icon(
                                  Icons.location_on,
                                  size: 25.sp,
                                  color: AppColors.ASHENVALE_NIGHTS,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8.5.h,
                      right: 2.w,
                      child: Bounceable(
                        onTap: () => controller.isSatellite.toggle(),
                        child: Container(
                          width: 7.h,
                          height: 7.h,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.ASHENVALE_NIGHTS,
                            shape: BoxShape.circle,
                          ),
                          child: Obx(
                            () => Icon(
                              controller.isSatellite.value
                                  ? Icons.width_normal_outlined
                                  : Icons.satellite_alt_outlined,
                              color: AppColors.WHITE,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          Direction.vertical.spacer(9),
        ],
      ),
    );
  }
}

class _CustomTabWidget extends StatelessWidget {
  final int tabIndex;
  final String title;
  final AdsPublishController controller = Get.find();
  _CustomTabWidget({required this.tabIndex, required this.title});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Bounceable(
        onTap: () {
          controller.selectedTab.value = tabIndex;
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          padding: EdgeInsets.symmetric(vertical: 1.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.selectedTab.value == tabIndex
                ? AppColors.CHEERFUL_YELLOW
                : Get.isDarkMode
                    ? AppColors.BLACK_WASH
                    : AppColors.OROCHIMARU,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
            border: Border(
              left: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 1,
              ),
              right: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 1,
              ),
              top: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 1,
              ),
              bottom: BorderSide(
                color: controller.selectedTab.value == tabIndex
                    ? AppColors.BANANA_CLAN
                    : AppColors.STELLAR_BLUE.withOpacity(.4),
                width: 0,
              ),
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontFamily: AppFonts.regular,
                  color: Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
                ),
          ),
        ),
      ),
    );
  }
}

class _CustomDescTab extends StatelessWidget {
  const _CustomDescTab({
    required this.controller,
  });

  final AdsPublishController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.previewInfos.first.adDesc,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.CORBEAU),
          ),
          Direction.vertical.spacer(9),
        ],
      ),
    );
  }
}

class _CustomAdsInfoTab extends StatelessWidget {
  const _CustomAdsInfoTab({
    required this.controller,
  });

  final AdsPublishController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SABİT ÖZELLİKLER
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          shrinkWrap: true,
          itemCount: controller.previewInfos.first.adInfo.length,
          separatorBuilder: (context, index) => CustomSeperatorWidget(
              color: AppColors.SHY_MOMENT.withOpacity(.1)),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.previewInfos.first.adInfo[index].key,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.BLACK,
                        ),
                  ),
                  controller.previewInfos.first.adInfo[index].key == "Fiyat"
                      ? Text(
                          controller.previewInfos.first.adInfo[index].value ??
                              "",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.ROMAN_EMPIRE_RED,
                                    fontFamily: AppFonts.semiBold,
                                  ),
                        )
                      : (controller.previewInfos.first.adInfo[index].key)
                              .contains("Parsel Sorgu")
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: .5.h),
                              decoration: BoxDecoration(
                                color: AppColors.CLEAR_CHILL,
                                borderRadius: AppBorderRadius.inputRadius,
                              ),
                              child: Text(
                                AppStrings.query,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.WHITE,
                                    ),
                              ),
                            )
                          : Text(
                              (controller.previewInfos.first.adInfo[index]
                                              .value ??
                                          "")
                                      .isEmpty
                                  ? "Belirtilmemiş"
                                  : controller.previewInfos.first.adInfo[index]
                                          .value ??
                                      "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontFamily: controller.previewInfos.first
                                            .adInfo[index].key
                                            .contains("İlan No")
                                        ? AppFonts.semiBold
                                        : null,
                                    color: controller.previewInfos.first
                                            .adInfo[index].key
                                            .contains("İlan No")
                                        ? AppColors.ASHENVALE_NIGHTS
                                        : AppColors.STEEL,
                                  ),
                            ),
                ],
              ),
            );
          },
        ),
        controller.previewInfos.first.dinamikOzellikler.isEmpty
            ? const SizedBox.shrink()
            : Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: const BoxDecoration(
                  color: AppColors.OROCHIMARU,
                ),
                child: Text(
                  AppStrings.features,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.STEEL,
                      ),
                ),
              ),
        // DİNAMİK ÖZELLİKLER
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          shrinkWrap: true,
          itemCount: controller.previewInfos.first.dinamikOzellikler.length,
          separatorBuilder: (context, index) => CustomSeperatorWidget(
            color: AppColors.SHY_MOMENT.withOpacity(.1),
          ),
          itemBuilder: (context, index) {
            return (controller.previewInfos.first.dinamikOzellikler[index]
                                .features ??
                            [])
                        .length >
                    1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Direction.vertical.spacer(1),
                      Text(
                        controller.previewInfos.first.dinamikOzellikler[index]
                                .groupName ??
                            "",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.BLACK,
                            ),
                      ),
                      Direction.vertical.spacer(1),
                      CustomSeperatorWidget(
                        color: AppColors.SHY_MOMENT.withOpacity(.1),
                      ),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, dynamicFeaturesIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Text(
                              controller
                                  .previewInfos
                                  .first
                                  .dinamikOzellikler[index]
                                  .features![dynamicFeaturesIndex],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.STEEL,
                                  ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            CustomSeperatorWidget(
                          color: AppColors.SHY_MOMENT.withOpacity(.1),
                        ),
                        itemCount: controller.previewInfos.first
                                .dinamikOzellikler[index].features?.length ??
                            0,
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.previewInfos.first.dinamikOzellikler[index]
                                  .groupName ??
                              "",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.BLACK,
                                  ),
                        ),
                        Text(
                          (controller.previewInfos.first
                                          .dinamikOzellikler[index].features ??
                                      [])
                                  .isEmpty
                              ? "Belirtilmemiş"
                              : controller
                                      .previewInfos
                                      .first
                                      .dinamikOzellikler[index]
                                      .features
                                      ?.first ??
                                  "",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.STEEL,
                                  ),
                        ),
                      ],
                    ),
                  );
          },
        ),

        (controller.previewInfos.first.ekspertiz ?? "").isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Container(
                    width: 100.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: const BoxDecoration(
                      color: AppColors.WHITE_SMOKE,
                    ),
                    child: Text(
                      "BOYA,DEĞİŞEN VE EKSPERTİZ BİLGİSİ",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.STEEL,
                          ),
                    ),
                  ),
                  Container(
                    height: 20.h,
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setBackgroundColor(const Color(0x00000000))
                        ..setNavigationDelegate(
                          NavigationDelegate(
                            onProgress: (int progress) {
                              // Update loading bar.
                            },
                          ),
                        )
                        ..loadHtmlString(
                          controller.previewInfos.first.ekspertiz ?? "",
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        (controller.previewInfos.first.degisenler ?? []).isEmpty
                            ? const SizedBox.shrink()
                            : CustomExpertiseInfo(
                                parts:
                                    controller.previewInfos.first.degisenler ??
                                        [],
                                title: "Değişen Parçalar",
                                partsTitleColor: AppColors.GLOOMY_PURPLE,
                              ),
                        (controller.previewInfos.first.boyalilar ?? []).isEmpty
                            ? const SizedBox.shrink()
                            : CustomExpertiseInfo(
                                parts:
                                    (controller.previewInfos.first.boyalilar ??
                                        []),
                                title: "Boyalı Parçalar",
                                partsTitleColor: AppColors.TOXIC_ORANGE,
                              ),
                        (controller.previewInfos.first.blokalBoyalar ?? [])
                                .isEmpty
                            ? const SizedBox.shrink()
                            : CustomExpertiseInfo(
                                parts: (controller
                                        .previewInfos.first.blokalBoyalar ??
                                    []),
                                title: "Lokal Boyalı Parçalar",
                                partsTitleColor: AppColors.MATCH_STRIKE,
                              ),
                      ],
                    ),
                  )
                ],
              ),
      ],
    );
  }
}

class Watermark extends StatelessWidget {
  final int rowCount;
  final int columnCount;
  final String text;

  const Watermark(
      {super.key,
      required this.rowCount,
      required this.columnCount,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        children: createColumnWidgets(),
      ),
    );
  }

  List<Widget> createRowWidgets() {
    List<Widget> list = [];
    for (var i = 0; i < rowCount; i++) {
      final widget = Expanded(
        child: Center(
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(-25 / 360),
            child: Text(
              text,
              style: Theme.of(Get.context!).textTheme.headlineLarge?.copyWith(
                    color: AppColors.WHITE,
                    fontFamily: AppFonts.bold,
                  ),
            ),
          ),
        ),
      );
      if (list.length <= 7) {
        list.add(widget);
      }
    }
    return list;
  }

  List<Widget> createColumnWidgets() {
    List<Widget> list = [];
    for (var i = 0; i < columnCount; i++) {
      final widget = Expanded(
          child: Row(
        children: createRowWidgets(),
      ));
      list.add(widget);
    }
    return list;
  }
}
