// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/Showcase/ShowcaseController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CacheSize.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/helpers/getBadge.dart';
import 'package:sizer/sizer.dart';

class Showcase extends StatefulWidget {
  const Showcase({super.key});

  @override
  State<Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  final ShowcaseController controller = Get.put(ShowcaseController());

  @override
  Widget build(BuildContext context) {
    // Get.put(ShowcaseController());
    return Obx(
      () => Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.ASHENVALE_NIGHTS,
                ),
              )
            : Get.isDarkMode
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Değerli Üyelerimiz",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontFamily: AppFonts.semiBold,
                                color: AppColors.SAILER_MOON,
                              ),
                        ),
                        Direction.vertical.spacer(1),
                        Text(
                          "Bu platformda yer alan ilanların tamamı pasif durumdadır. Evrak eksikliği bulunduğundan onay sürecindedir.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontFamily: AppFonts.semiBold,
                              ),
                        ),
                        Direction.vertical.spacer(1),
                        Text(
                          "Satış yetki belgesi yüklendikten sonra yayına açılacaktır. Kurumsal üyelerimizin hepsinde görülebilen ilanlarımız, mükerrer satış yetkisinin önüne geçilmesi için görüntülenebilmektedir.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontFamily: AppFonts.semiBold,
                              ),
                        ),
                        Direction.vertical.spacer(1),
                        Text(
                          "İlanlara yapılacak itiraz, yetki belgesi ibraz edilerek yapılabilmektedir. Lütfen dikkat ediniz, bu ilanların herhangi bir sosyal medya platformunda veya başka mecralarda paylaşılması kesinlikle yasaktır.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontFamily: AppFonts.semiBold,
                              ),
                        ),
                        Direction.vertical.spacer(1),
                        Text(
                          "Bu kurallara uymayan üyelerimizin üyelikleri iptal edilecektir. Platformumuzun güvenliği ve verimliliği için bu kurallara uymanız önemlidir.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontFamily: AppFonts.semiBold,
                              ),
                        ),
                        Direction.vertical.spacer(1),
                        Text(
                          "Anlayışınız ve iş birliğiniz için teşekkür ederiz.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontFamily: AppFonts.semiBold,
                              ),
                        ),
                        Direction.vertical.spacer(1),
                        Text(
                          "Saygılarımızla,",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontFamily: AppFonts.semiBold,
                              ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    controller: controller.pageController,
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ).copyWith(
                      bottom: 6.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3.w,
                      crossAxisSpacing: 3.w,
                    ),
                    itemCount: controller.showcaseAdvertisements.length,
                    itemBuilder: (context, index) {
                      return Bounceable(
                        onTap: () {
                          Get.toNamed(
                            Routes.ADVERTISEMENTDETAIL +
                                controller.showcaseAdvertisements[index].adId,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            borderRadius: AppBorderRadius.inputRadius,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.BLACK.withOpacity(.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  controller.showcaseAdvertisements[index]
                                          .adPics.isNotEmpty
                                      ? Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(1.h),
                                            ),
                                            child: CachedNetworkImage(
                                              memCacheHeight:
                                                  15.h.cacheSize(context),
                                              imageUrl: ImageUrlTypeExtension
                                                      .getImageType(controller
                                                          .showcaseAdvertisements[
                                                              index]
                                                          .adPics
                                                          .split(",")
                                                          .first)
                                                  .ImageUrl(controller
                                                      .showcaseAdvertisements[
                                                          index]
                                                      .adPics),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Images.noImages.pngWithScale,
                                        ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 1.w,
                                      vertical: 1.h,
                                    ),
                                    child: Text(
                                      controller.showcaseAdvertisements[index]
                                          .adSubject,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                child: getBadge(
                                  controller.showcaseAdvertisements[index].acil,
                                  controller.showcaseAdvertisements[index]
                                      .fiyatiDusen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
