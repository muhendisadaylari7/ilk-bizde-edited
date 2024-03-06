// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreDetail/MyStoreDetailController.dart';
import 'package:ilkbizde/modules/MyStoreDetail/extension/MyStoreDetailTypeExtension.dart';
import 'package:ilkbizde/modules/MyStoreDetail/widgets/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class MyStoreDetail extends StatefulWidget {
  const MyStoreDetail({super.key});

  @override
  State<MyStoreDetail> createState() => _MyStoreDetailState();
}

class _MyStoreDetailState extends State<MyStoreDetail> {
  final MyStoreDetailController controller = Get.put(MyStoreDetailController());

  @override
  Widget build(BuildContext context) {
    Get.put(MyStoreDetailController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomMyAccountItemAppBar(
          title: "Mağaza Detay",
          height: 8.h,
          bottom: TabBar(
            controller: controller.tabController,
            indicatorColor: AppColors.WHITE,
            tabs: [
              Tab(
                child: Text(
                  "Mağaza Bilgileri",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.WHITE,
                      ),
                ),
              ),
              Tab(
                child: Text(
                  "Danışmanlar",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.WHITE,
                      ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: TabBarView(
            controller: controller.tabController,
            children: [
              CustomMarketInfosTabWidget(controller: controller),
              CustomCounselorTabWidget(controller: controller),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => controller.isLoading.value
              ? const SizedBox.shrink()
              : !controller.infos.first.magazaYetki
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        controller.currentTabIndex.value == 1
                            ? const SizedBox.shrink()
                            : FloatingActionButton(
                                heroTag: "edit",
                                backgroundColor: AppColors.ASHENVALE_NIGHTS,
                                foregroundColor: AppColors.WHITE,
                                onPressed: () async {
                                  controller.getCurrentInfos();
                                  Get.bottomSheet(
                                    CustomMarketInfosBottomSheetWidget(
                                      controller: controller.myStoreController,
                                      buttonTitle: 'Düzenle',
                                      onTap: () =>
                                          controller.handleEditMarketApi(),
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
                                child: const Icon(Icons.edit),
                              ),
                        Direction.horizontal.spacer(2),
                        controller.currentTabIndex.value == 1
                            ? FloatingActionButton(
                                heroTag: "add",
                                backgroundColor: AppColors.ASHENVALE_NIGHTS,
                                foregroundColor: AppColors.WHITE,
                                onPressed: () {
                                  controller.clientEmailController.clear();
                                  Get.dialog(
                                    MyStoreDetailType.counselor.addDialogWidget,
                                  );
                                },
                                child: const Icon(Icons.add),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
        ),
      ),
    );
  }
}
