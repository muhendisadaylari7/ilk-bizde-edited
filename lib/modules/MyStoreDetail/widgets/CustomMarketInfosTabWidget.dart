import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:ilkbizde/modules/MyStoreDetail/MyStoreDetailController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomMarketInfosTabWidget extends StatelessWidget {
  final MyStoreDetailController controller;
  const CustomMarketInfosTabWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.ASHENVALE_NIGHTS,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.SHY_MOMENT.withOpacity(.1),
                      border: Border.all(
                        color: AppColors.SHY_MOMENT,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 1.h,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: ImageUrlTypeExtension.getImageType(
                              controller.infos.first.logo)
                          .ImageUrlWithMarketApiUrl(
                              controller.infos.first.logo),
                      errorWidget: (context, url, error) =>
                          Images.noImages.pngWithScale,
                    ),
                  ),
                ),
                Direction.vertical.spacer(2),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.SHY_MOMENT.withOpacity(.1),
                    border: Border.all(
                      color: AppColors.SHY_MOMENT,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAltTextRich(
                        text: "Mağaza Kullanıcı Adı: ",
                        subtext: controller.infos.first.magazaKullaniciAdi,
                      ),
                      Direction.vertical.spacer(1),
                      CustomAltTextRich(
                        text: "Mağaza Açıklaması: ",
                        subtext: controller.infos.first.magazaAciklamasi,
                      ),
                      Direction.vertical.spacer(1),
                      CustomAltTextRich(
                        text: "Mağaza Adı: ",
                        subtext: controller.infos.first.magazaAdi,
                      ),
                    ],
                  ),
                ),
                Direction.vertical.spacer(3),
                Text(
                  "İLANLARIM",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Direction.vertical.spacer(2),
                Expanded(
                  child: controller.allAdsIsLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.ASHENVALE_NIGHTS,
                          ),
                        )
                      : controller.allAdsInMarket.isEmpty
                          ? Center(
                              child: Text(
                                "İLAN BULUNMAMAKTADIR!",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            )
                          : ListView.separated(
                              itemCount: controller.allAdsInMarket.length,
                              separatorBuilder: (context, index) =>
                                  Direction.vertical.spacer(2),
                              itemBuilder: (context, indexOwner) {
                                return ExpansionTile(
                                  collapsedBackgroundColor:
                                      AppColors.ASHENVALE_NIGHTS,
                                  collapsedTextColor: AppColors.WHITE,
                                  textColor: AppColors.BLACK,
                                  collapsedIconColor: AppColors.WHITE,
                                  iconColor: AppColors.ASHENVALE_NIGHTS,
                                  backgroundColor: AppColors.ASHENVALE_NIGHTS
                                      .withOpacity(.1),
                                  title: Text(
                                    controller.allAdsInMarket[indexOwner]
                                            .ilanSahibi.ad +
                                        " " +
                                        controller.allAdsInMarket[indexOwner]
                                            .ilanSahibi.soyad +
                                        " (" +
                                        controller.allAdsInMarket[indexOwner]
                                            .ilanSahibi.gsm +
                                        ")",
                                  ),
                                  children: [
                                    ListView.separated(
                                      itemCount: controller
                                          .allAdsInMarket.first.ilanlar!.length,
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) =>
                                          Direction.vertical.spacer(2),
                                      itemBuilder: (context, index) {
                                        return Bounceable(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.ADVERTISEMENTDETAIL +
                                                  controller.allAdsInMarket
                                                      .first.ilanlar![index].id,
                                            );
                                          },
                                          child: Container(
                                            width: 100.w,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 2.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? AppColors.BLACK_WASH
                                                  : AppColors.WHITE,
                                              border: Border.all(
                                                color:
                                                    AppColors.ASHENVALE_NIGHTS,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 1.h,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            AppBorderRadius
                                                                .inputRadius,
                                                        child: SizedBox(
                                                          width: 12.5.h,
                                                          height: 9.5.h,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: dotenv
                                                                    .env[
                                                                        "BASE_URL"]
                                                                    .toString() +
                                                                controller
                                                                    .allAdsInMarket
                                                                    .first
                                                                    .ilanlar![
                                                                        index]
                                                                    .resim,
                                                          ),
                                                        ),
                                                      ),
                                                      Direction.horizontal
                                                          .spacer(2),
                                                      Expanded(
                                                        child: Obx(
                                                          () => Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                HtmlUnescape().convert(
                                                                    controller
                                                                        .allAdsInMarket
                                                                        .first
                                                                        .ilanlar![
                                                                            index]
                                                                        .baslik),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelSmall
                                                                    ?.copyWith(
                                                                        fontSize:
                                                                            8.4.sp),
                                                              ),
                                                              Direction.vertical
                                                                  .spacer(2.5),
                                                              Text(
                                                                controller
                                                                    .allAdsInMarket
                                                                    .first
                                                                    .ilanlar![
                                                                        index]
                                                                    .fiyat
                                                                    .replaceAllMapped(
                                                                        RegExp(
                                                                            r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                        (Match m) =>
                                                                            '${m[1]}.'),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium
                                                                    ?.copyWith(
                                                                      color: AppColors
                                                                          .ROMAN_EMPIRE_RED,
                                                                      fontFamily:
                                                                          AppFonts
                                                                              .semiBold,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                ),
              ],
            ),
    );
  }
}
