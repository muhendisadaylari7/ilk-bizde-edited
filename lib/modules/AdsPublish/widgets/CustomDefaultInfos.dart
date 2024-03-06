// ignore_for_file: file_names

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdsPublish/AdsPublishController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_loading/widget_loading.dart';

class CustomDefaultInfos extends StatelessWidget {
  final AdsPublishController controller;

  const CustomDefaultInfos({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.imageLoadingState.isEmpty
                  ? const SizedBox.shrink()
                  : Text(
                      "Fotoğraflar(${controller.imageLoadingState.lastIndexOf(true) + 1}/30) Video(${controller.hasVideo.value ? 1 : 0}/1)",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 13.sp),
                    ),
              Direction.vertical.spacer(1),
              Row(
                children: [
                  Bounceable(
                    onTap: controller.isPhotoAndVideoLoading.value
                        ? null
                        : () => controller.pageController.jumpToPage(1),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.WHITE,
                        borderRadius: AppBorderRadius.inputRadius,
                        border: Border.all(
                          color: AppColors.SHY_MOMENT,
                          width: .2.w,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            color: AppColors.SHY_MOMENT,
                            size: 13.sp,
                          ),
                          Text(
                            "Fotoğraf/\nVideo Ekle",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontSize: 7.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Direction.horizontal.spacer(2),
                  Expanded(
                    child: SizedBox(
                      height: 20.w,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: controller.imageList.length,
                        separatorBuilder: (context, index) =>
                            Direction.horizontal.spacer(2),
                        itemBuilder: (context, index) {
                          return Obx(
                            () => Row(
                              children: [
                                // Image
                                ClipRRect(
                                  key: ValueKey(controller.imageList[index]),
                                  borderRadius: AppBorderRadius.inputRadius,
                                  child: SizedBox(
                                    width: 20.w,
                                    child: controller
                                            .imageList[index].path.isEmpty
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Stack(
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
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: controller
                                                            .isPhotoAndVideoLoading
                                                            .value
                                                        ? 2
                                                        : 0,
                                                    sigmaY: controller
                                                            .isPhotoAndVideoLoading
                                                            .value
                                                        ? 2
                                                        : 0,
                                                  ),
                                                  child: Center(
                                                    child:
                                                        CircularWidgetLoading(
                                                      loading: !controller
                                                          .imageLoadingState[
                                                              index]
                                                          .value,
                                                      dotRadius: 2,
                                                      sizeDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      loadingDuration:
                                                          const Duration(
                                                              seconds: 1),
                                                      dotColor: AppColors
                                                          .FENNEL_FIESTA,
                                                      child: const CircleAvatar(
                                                        backgroundColor:
                                                            AppColors
                                                                .FENNEL_FIESTA,
                                                        foregroundColor:
                                                            AppColors.WHITE,
                                                        child: Icon(Icons.done),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                                index + 1 == controller.imageList.length
                                    ? Direction.horizontal.spacer(2)
                                    : const SizedBox.shrink(),
                                // Video
                                Obx(
                                  () => !controller.hasVideo.value
                                      ? const SizedBox.shrink()
                                      : index + 1 == controller.imageList.length
                                          ? SizedBox(
                                              width: 20.w,
                                              child: ClipRRect(
                                                borderRadius:
                                                    AppBorderRadius.inputRadius,
                                                child: SizedBox(
                                                  width: 100.w,
                                                  child: Stack(
                                                    children: [
                                                      Positioned.fill(
                                                        child: VideoPlayer(
                                                          controller
                                                              .videoPlayerController,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 7.w,
                                                        top: 7.w,
                                                        left: 7.w,
                                                        right: 7.w,
                                                        child: Obx(
                                                          () =>
                                                              CustomIconButton(
                                                            onTap: () {
                                                              controller
                                                                  .playPauseVideo();
                                                            },
                                                            color: AppColors
                                                                .BLACK
                                                                .withOpacity(
                                                                    .3),
                                                            child: Icon(
                                                              controller.isPlay
                                                                      .value
                                                                  ? Icons.pause
                                                                  : Icons
                                                                      .play_arrow,
                                                              color: AppColors
                                                                  .WHITE,
                                                              size: 8.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Direction.vertical.spacer(2),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        controller.allFilters.length,
                        (index) => Column(
                              children: [
                                getFilterWidgetFromFilterType
                                    .getFilterType(controller.allFilters[index]
                                        ["filterType"])
                                    .getWidget(
                                      controller.allFilters[index]
                                          ["filterName"],
                                      controller,
                                      context,
                                      index,
                                    ),
                                Direction.vertical.spacer(2),
                                index == controller.allFilters.length - 1
                                    ? Row(
                                        children: [
                                          controller.parameters["isEdit"] == "1"
                                              ? Switch(
                                                  value: true,
                                                  onChanged: (value) {
                                                    controller.isRuleAccepted
                                                        .value = value;
                                                  },
                                                  activeTrackColor: AppColors
                                                      .VERDANT_OASIS
                                                      .withOpacity(.3),
                                                  inactiveTrackColor:
                                                      AppColors.WHITE,
                                                  activeColor:
                                                      AppColors.IMAGINATION,
                                                  thumbColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          AppColors
                                                              .VERDANT_OASIS),
                                                )
                                              : Obx(
                                                  () => Switch(
                                                    value: controller
                                                        .isRuleAccepted.value,
                                                    onChanged: (value) {
                                                      controller.isRuleAccepted
                                                          .value = value;
                                                    },
                                                    activeTrackColor: AppColors
                                                        .VERDANT_OASIS
                                                        .withOpacity(.3),
                                                    inactiveTrackColor:
                                                        AppColors.WHITE,
                                                    activeColor:
                                                        AppColors.IMAGINATION,
                                                    thumbColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            AppColors
                                                                .VERDANT_OASIS),
                                                  ),
                                                ),
                                          Direction.horizontal.spacer(1),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                text: "İlan verme kurallarını",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color:
                                                          AppColors.BLUE_RIBBON,
                                                      fontFamily:
                                                          AppFonts.medium,
                                                    ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          backgroundColor:
                                                              AppColors.WHITE,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.sp),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.sp),
                                                            ),
                                                          ),
                                                          builder: (context) {
                                                            return Container(
                                                              padding: AppPaddings
                                                                  .generalPadding,
                                                              child:
                                                                  SingleChildScrollView(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical: 2.h,
                                                                ),
                                                                child: Text(
                                                                  AppStrings
                                                                      .rules,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelSmall
                                                                      ?.copyWith(
                                                                        fontFamily:
                                                                            AppFonts.medium,
                                                                      ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                children: [
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                    text: AppStrings.rule2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
