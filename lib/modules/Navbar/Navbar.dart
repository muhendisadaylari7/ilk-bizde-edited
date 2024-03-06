import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/Home/index.dart';
import 'package:ilkbizde/modules/Navbar/NavbarController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/CustomMyAccountItemAppBar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';
import 'package:upgrader/upgrader.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final NavbarController controller = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        showIgnore: false,
        showLater: false,
        canDismissDialog: false,
        messages: UpgraderMessages(
          code: "tr",
        ),
      ),
      child: Obx(
        () => Scaffold(
          appBar: controller.currentIndex.value == 1
              ? AppBar(
                  leadingWidth: 16.w,
                  leading: Container(
                    margin: EdgeInsets.only(left: 5.7.w),
                    child: Bounceable(
                        onTap: !Get.isDarkMode
                            ? null
                            : () async {
                                controller.isNotProLoading.toggle();
                                final HomeController homeController =
                                    Get.put<HomeController>(HomeController());
                                Get.changeTheme(CustomTheme.lightTheme);
                                homeController.isProPopup.value = false;
                                await Future.delayed(
                                    const Duration(milliseconds: 300),
                                    () async {
                                  await homeController
                                      .getPopularAdvertisements();
                                  await homeController.getCategories();
                                });
                                controller.isNotProLoading.toggle();
                              },
                        child: Images.homeAppBarLeadingIcon.pngWithScale),
                  ),
                  title: Text(
                    Get.isDarkMode ? "İlk Bizde Pro" : AppStrings.callUsFirst,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  actions: [
                    Get.isDarkMode
                        ? Padding(
                            padding: EdgeInsets.only(right: 5.7.w),
                            child: Images.private.pngWithScale,
                          )
                        : const SizedBox.shrink()
                    // : Bounceable(
                    //     onTap: () => Get.toNamed(Routes.ALLDAILYOPPORTUNITY),
                    //     child: Padding(
                    //       padding: EdgeInsets.only(right: 5.7.w),
                    //       child: Icon(
                    //         Icons.hourglass_bottom_outlined,
                    //       ),
                    //     ),
                    //   ),
                  ],
                )
              : controller.currentIndex.value == 2
                  ? CustomMyAccountItemAppBar(
                      title: "İlan Ver",
                      onBackButtonPressed: () {
                        if (controller
                                .advertisementPublishSelectCategoryController
                                .currenPageIndex
                                .value !=
                            0) {
                          controller
                              .advertisementPublishSelectCategoryController
                              .subCategories
                              .removeRange(
                            controller
                                .advertisementPublishSelectCategoryController
                                .currenPageIndex
                                .value,
                            controller
                                .advertisementPublishSelectCategoryController
                                .subCategories
                                .length,
                          );
                        } else {
                          controller.currentIndex.value = 1;
                          controller.persistentTabController.index = 1;
                        }
                      },
                    )
                  : AppBar(
                      automaticallyImplyLeading: false,
                      title: Text(
                        controller
                            .navBarItems(context)[controller.currentIndex.value]
                            .title
                            .toString(),
                      ),
                    ),
          body: Obx(
            () => controller.isNotProLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.ASHENVALE_NIGHTS,
                    ),
                  )
                : WillPopScope(
                    onWillPop: () async {
                      SystemNavigator.pop();
                      return false;
                    },
                    child: PersistentTabView(
                      context,
                      navBarHeight: 9.h,
                      backgroundColor: Get.isDarkMode
                          ? AppColors.TRAPPED_DARKNESS
                          : AppColors.WHITE,
                      controller: controller.persistentTabController,
                      screens: controller.screens,
                      items: controller.navBarItems(context),
                      resizeToAvoidBottomInset: true,
                      onItemSelected: (value) =>
                          controller.currentIndex.value = value,
                      decoration: NavBarDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(21.sp),
                          topLeft: Radius.circular(21.sp),
                        ),
                        colorBehindNavBar: AppColors.WHITE,
                        border: Border.all(
                          color: AppColors.STELLAR_BLUE.withOpacity(0.3),
                          width: .3.w,
                        ),
                      ),
                      popAllScreensOnTapOfSelectedTab: true,
                      popActionScreens: PopActionScreensType.all,
                      itemAnimationProperties: const ItemAnimationProperties(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                      screenTransitionAnimation:
                          const ScreenTransitionAnimation(
                        animateTabTransition: true,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 200),
                      ),
                      navBarStyle: NavBarStyle.style15,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
