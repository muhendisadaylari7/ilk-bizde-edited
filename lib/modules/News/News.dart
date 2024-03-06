// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/News/NewsController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CacheSize.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    Get.put(NewsController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "HABERLER"),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.ASHENVALE_NIGHTS,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    Direction.vertical.spacer(1),
                    CustomBlogAndNewsSearchInput(
                      controller: controller,
                      hintText: "Haber Ara",
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller.searchResultNews.length,
                        padding: EdgeInsets.only(
                          top: 2.h,
                          bottom: 6.h,
                        ),
                        separatorBuilder: (context, index) =>
                            Direction.vertical.spacer(2),
                        itemBuilder: (context, index) {
                          return Bounceable(
                            onTap: () => Get.toNamed(
                              Routes.NEWSDETAIL,
                              parameters: {
                                "newsId": controller.searchResultNews[index].id
                              },
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColors.BLACK_WASH
                                    : AppColors.WHITE,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.BLACK.withOpacity(.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller
                                          .searchResultNews[index].pics.isEmpty
                                      ? Images.noImages.pngWithColor(
                                          Get.isDarkMode
                                              ? AppColors.WHITE
                                              : AppColors.BLACK,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              AppBorderRadius.inputRadius,
                                          child: SizedBox(
                                            width: 6.h,
                                            height: 6.h,
                                            child: CachedNetworkImage(
                                              memCacheHeight:
                                                  6.h.cacheSize(context),
                                              imageUrl:
                                                  "${dotenv.env["BASE_URL"]}${controller.searchResultNews[index].pics}",
                                            ),
                                          ),
                                        ),
                                  Direction.horizontal.spacer(2),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .searchResultNews[index].subject,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                color:
                                                    AppColors.ASHENVALE_NIGHTS,
                                                fontFamily: AppFonts.medium,
                                              ),
                                        ),
                                        Direction.vertical.spacer(1),
                                        HtmlWidget(
                                          controller
                                              .searchResultNews[index].desc,
                                          renderMode: RenderMode.column,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontFamily: AppFonts.light,
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
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
