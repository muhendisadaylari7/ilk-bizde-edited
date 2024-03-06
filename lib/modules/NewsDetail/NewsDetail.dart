// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/NewsDetail/NewsDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/CustomMyAccountItemAppBar.dart';
import 'package:sizer/sizer.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final NewsDetailController controller = Get.put(NewsDetailController());

  @override
  Widget build(BuildContext context) {
    Get.put(NewsDetailController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: ""),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.ASHENVALE_NIGHTS,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w).copyWith(
                    bottom: 6.h,
                  ),
                  child: Column(
                    children: [
                      Direction.vertical.spacer(2),
                      controller.newsDetails[0].pics.isEmpty
                          ? Images.noImages.pngWithColor(
                              Get.isDarkMode
                                  ? AppColors.WHITE
                                  : AppColors.BLACK,
                            )
                          : SizedBox(
                              width: 100.w,
                              child: ClipRRect(
                                borderRadius: AppBorderRadius.inputRadius,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${dotenv.env["BASE_URL"]}${controller.newsDetails[0].pics}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Direction.vertical.spacer(2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.newsDetails[0].subject,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Direction.vertical.spacer(1),
                          HtmlWidget(
                            controller.newsDetails[0].desc,
                            renderMode: RenderMode.column,
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontFamily: AppFonts.light,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
