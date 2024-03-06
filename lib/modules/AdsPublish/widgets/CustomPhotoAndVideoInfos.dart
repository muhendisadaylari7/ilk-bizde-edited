// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdsPublish/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class CustomPhotoAndVideoInfos extends StatelessWidget {
  final AdsPublishController controller;
  const CustomPhotoAndVideoInfos({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 1.5.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            boxShadow: [
              BoxShadow(
                color: AppColors.BLACK.withOpacity(.1),
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Text(
            "Fotoğraflar ve Videolar",
            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                  color: AppColors.CHROMAPHOBIC_BLACK,
                ),
          ),
        ),
        Direction.vertical.spacer(1),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // FOTOĞRAFLAR
                Obx(
                  () => controller.imageList.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                            horizontal: 3.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Fotoğraflar",
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(color: AppColors.BLACK),
                                      ),
                                      Text(
                                        "(${controller.imageList.length}/30)",
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(color: AppColors.BLACK),
                                      ),
                                    ],
                                  ),
                                  // VİTRİN FOTOĞRAFI İÇİN İSTEDİĞİNİZ GÖRSELİ İLK SIRAYA KAYDIRIN DILAGOU ÇIKACAK
                                  Bounceable(
                                    onTap: () {
                                      Get.dialog(
                                        Center(
                                          child: SizedBox(
                                            width: 70.w,
                                            child: Material(
                                              borderRadius:
                                                  AppBorderRadius.inputRadius,
                                              color: AppColors.WHITE,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w,
                                                  vertical: 1.h,
                                                ),
                                                child: Text(
                                                  "Vitrin Görseli İçin İstediğiniz Görseli İlk Sıraya Kaydırın",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 1.6.w,
                                          vertical: .65.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              AppBorderRadius.inputRadius,
                                          color:
                                              AppColors.BLACK.withOpacity(.3),
                                        ),
                                        child: const Icon(
                                          Icons.info_outline,
                                          color: AppColors.WHITE,
                                        )),
                                  ),
                                ],
                              ),
                              Direction.vertical.spacer(1),
                              ReorderableGridView.builder(
                                onReorder: (oldIndex, newIndex) {
                                  final image =
                                      controller.imageList.removeAt(oldIndex);
                                  controller.imageList.insert(newIndex, image);
                                },
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 3.w,
                                  crossAxisSpacing: 3.w,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.imageList.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    key: ValueKey(controller.imageList[index]),
                                    borderRadius: AppBorderRadius.inputRadius,
                                    child: SizedBox(
                                      width: 100.w,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Image.file(
                                              controller.imageList[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          index == 0
                                              ? Positioned(
                                                  child: Images.showcase
                                                      .pngWithColor(
                                                    null,
                                                    scale: 2,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Positioned(
                                            top: 1.w,
                                            right: 1.w,
                                            child: CustomIconButton(
                                              onTap: () {
                                                controller.imageList
                                                    .removeAt(index);
                                                controller.imageLoadingState
                                                    .removeAt(index);
                                              },
                                              color: AppColors.BLACK
                                                  .withOpacity(.3),
                                              child: const Icon(
                                                Icons.close,
                                                color: AppColors.WHITE,
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => !controller
                                                    .isShowcasePhoto.value
                                                ? const SizedBox.shrink()
                                                : index == 0
                                                    ? const SizedBox.shrink()
                                                    : Positioned.fill(
                                                        child: Bounceable(
                                                          onTap: () async {
                                                            final image =
                                                                controller
                                                                        .imageList[
                                                                    index];
                                                            controller.imageList
                                                                .removeAt(
                                                                    index);
                                                            controller.imageList
                                                                .insert(
                                                                    0, image);
                                                            controller
                                                                .isShowcasePhoto
                                                                .toggle();
                                                            SnackbarType.success
                                                                .CustomSnackbar(
                                                              title: AppStrings
                                                                  .success,
                                                              message:
                                                                  "Vitrin fotoğrafı seçilmiştir.",
                                                            );
                                                            await Future
                                                                .delayed(
                                                              const Duration(
                                                                  seconds: 2),
                                                              () => Get.back(),
                                                            );
                                                            // İLK ELEMAN İLE TIKLADIĞIM GÖRSELİN YERİNİ DEĞİŞTİRİYORUM
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .FENNEL_FIESTA,
                                                            size: 70.sp,
                                                          ),
                                                        ),
                                                      ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                ),
                // VİDEO
                Obx(
                  () => !controller.hasVideo.value
                      ? const SizedBox.shrink()
                      : Container(
                          width: 100.w,
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                            horizontal: 3.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Videolar",
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: AppColors.BLACK),
                              ),
                              Direction.vertical.spacer(1),
                              SizedBox(
                                width: 30.w,
                                height: 50.w,
                                child: ClipRRect(
                                  borderRadius: AppBorderRadius.inputRadius,
                                  child: SizedBox(
                                    width: 100.w,
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: VideoPlayer(
                                            controller.videoPlayerController,
                                          ),
                                        ),
                                        Positioned(
                                          top: 1.w,
                                          right: 1.w,
                                          child: CustomIconButton(
                                            onTap: () {
                                              controller.isPlay.value = false;
                                              controller.hasVideo.toggle();
                                              controller.video.value = File("");
                                            },
                                            color:
                                                AppColors.BLACK.withOpacity(.3),
                                            child: const Icon(
                                              Icons.close,
                                              color: AppColors.WHITE,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 1.w,
                                          left: 1.w,
                                          child: Obx(
                                            () => CustomIconButton(
                                              onTap: () {
                                                controller.playPauseVideo();
                                              },
                                              color: AppColors.BLACK
                                                  .withOpacity(.3),
                                              child: Icon(
                                                controller.isPlay.value
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: AppColors.WHITE,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        Direction.vertical.spacer(1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // FOTOĞRAF ÇEK BUTONU
                  Expanded(
                    child: Bounceable(
                      onTap: () {
                        controller.takePhoto();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.YANG_CHENG_ORANGE,
                          border: Border.all(
                            width: .5.w,
                            color: AppColors.BITCOIN,
                          ),
                          borderRadius: AppBorderRadius.inputRadius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.WHITE,
                            ),
                            Direction.horizontal.spacer(1),
                            Text(
                              "Fotoğraf Çek",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.WHITE,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Direction.horizontal.spacer(2),
                  // FOTOĞRAF YÜKLE BUTONU
                  Expanded(
                    child: Bounceable(
                      onTap: () {
                        controller.getImage();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.YANG_CHENG_ORANGE,
                          border: Border.all(
                            width: .5.w,
                            color: AppColors.BITCOIN,
                          ),
                          borderRadius: AppBorderRadius.inputRadius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.image_outlined,
                              color: AppColors.WHITE,
                            ),
                            Direction.horizontal.spacer(1),
                            Text(
                              "Fotoğraf Ekle",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.WHITE,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Direction.vertical.spacer(1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // VİDEO YÜKLE BUTONU
                  Expanded(
                    child: Bounceable(
                      onTap: () async {
                        if (controller.imageList.isEmpty) {
                          SnackbarType.error.CustomSnackbar(
                            title: AppStrings.error,
                            message: "Lütfen önce fotoğraf yükleyiniz",
                          );
                          await Future.delayed(
                              const Duration(seconds: 2), () => Get.back());
                        } else if (controller.hasVideo.value) {
                          SnackbarType.error.CustomSnackbar(
                              title: AppStrings.error,
                              message: "1 den fazla video yükleyemezsiniz");
                          await Future.delayed(
                              const Duration(seconds: 2), () => Get.back());
                        } else {
                          controller.uploadVideo();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.YANG_CHENG_ORANGE,
                          border: Border.all(
                            width: .5.w,
                            color: AppColors.BITCOIN,
                          ),
                          borderRadius: AppBorderRadius.inputRadius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.video_collection_outlined,
                              color: AppColors.WHITE,
                            ),
                            Direction.horizontal.spacer(1),
                            Text(
                              "Video Ekle",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.WHITE,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Direction.horizontal.spacer(2),
                  // VİTRİN FOTOĞRAFI YAP
                  Expanded(
                    child: Bounceable(
                      onTap: () {
                        controller.isShowcasePhoto.toggle();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.AQUA_FOREST,
                          border: Border.all(
                            width: .5.w,
                            color: AppColors.FENNEL_FIESTA,
                          ),
                          borderRadius: AppBorderRadius.inputRadius,
                        ),
                        child: Text(
                          "Vitrin Görseli Yap",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.WHITE,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Direction.vertical.spacer(2),
      ],
    );
  }
}
