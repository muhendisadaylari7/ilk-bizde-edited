// ignore_for_file: file_names

// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/BlogDetail/BlogDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({super.key});

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  final BlogDetailController controller = Get.put(BlogDetailController());

  @override
  Widget build(BuildContext context) {
    Get.put(BlogDetailController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: ""),
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Obx(
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
                        controller.blogDetails[0].pics.isEmpty
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
                                        "${dotenv.env["BASE_URL"]}${controller.blogDetails[0].pics}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Direction.vertical.spacer(2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.blogDetails[0].subject,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Direction.vertical.spacer(1),
                            Text(controller.blogDetails[0].owner,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontFamily: AppFonts.medium,
                                      color: AppColors.ASHENVALE_NIGHTS,
                                    )),
                            Direction.vertical.spacer(1),
                            HtmlWidget(
                              controller.blogDetails[0].desc,
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
        );
      }),
    );
  }
}
