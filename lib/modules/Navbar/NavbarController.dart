// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/modules/AdvertisementPublishSelectCategory/index.dart';
import 'package:ilkbizde/modules/Favorites/index.dart';
import 'package:ilkbizde/modules/Home/index.dart';
import 'package:ilkbizde/modules/MyAccount/index.dart';
import 'package:ilkbizde/modules/Showcase/index.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class NavbarController extends GetxController {
  final GetStorage storage = GetStorage();

  RxInt currentIndex = 1.obs;

  PersistentTabController persistentTabController =
      PersistentTabController(initialIndex: 1);

  final AdvertisementPublishSelectCategoryController
      advertisementPublishSelectCategoryController =
      Get.put<AdvertisementPublishSelectCategoryController>(
          AdvertisementPublishSelectCategoryController());

  final RxBool isNotProLoading = false.obs;

  final List<Widget> screens = [
    const Showcase(),
    const Home(),
    const AdvertisementPublishSelectCategory(),
    const Favorites(),
    const MyAccount()
  ];

  List<PersistentBottomNavBarItem> navBarItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        onPressed: persistentTabController.index == 0
            ? null
            : (p0) {
                final ShowcaseController showcaseController =
                    Get.put<ShowcaseController>(ShowcaseController());
                showcaseController.getShowcaseAdvertisements();
                currentIndex.value = 0;
                persistentTabController.index = 0;
              },
        title: Get.isDarkMode ? "Bilgi" : AppStrings.showcase,
        icon: Get.isDarkMode
            ? Icon(Icons.question_mark_outlined)
            : Images.homeActive.pngWithScale,
        inactiveIcon: Get.isDarkMode
            ? Icon(Icons.question_mark_outlined)
            : Images.homeInactive.pngWithScale,
        activeColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        inactiveColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 8.5.sp,
            ),
      ),
      PersistentBottomNavBarItem(
        onPressed: persistentTabController.index == 1
            ? null
            : (p0) async {
                final HomeController homeController =
                    Get.find<HomeController>();
                currentIndex.value = 1;
                persistentTabController.index = 1;
                if (!Get.isDarkMode) {
                  await homeController.getShowcaseAdvertisements();
                }
              },
        title: AppStrings.search,
        icon: Images.searchActive.pngWithColor(
          Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        ),
        inactiveIcon: Images.searchInactive.pngWithColor(
          Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        ),
        activeColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        inactiveColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 8.5.sp,
            ),
      ),
      PersistentBottomNavBarItem(
        title: Get.isDarkMode ? "" : AppStrings.add,
        onPressed: persistentTabController.index == 2
            ? null
            : Get.isDarkMode
                ? (p0) {
                    if (persistentTabController.index == 1) return;
                    currentIndex.value = 1;
                    persistentTabController.index = 1;
                  }
                : (p0) async {
                    if (storage.read("uid") == null) {
                      SnackbarType.error.CustomSnackbar(
                        title: AppStrings.loginTitle,
                        message: AppStrings.notLogin,
                      );
                      await Future.delayed(const Duration(seconds: 2), () {
                        Get.back();
                        Get.toNamed(Routes.LOGIN);
                      });
                    } else {
                      final AdvertisementPublishSelectCategoryController
                          advertisementPublishSelectCategoryController =
                          Get.put<AdvertisementPublishSelectCategoryController>(
                              AdvertisementPublishSelectCategoryController());
                      advertisementPublishSelectCategoryController.createAds(
                          categoryId: "");
                      currentIndex.value = 2;
                      persistentTabController.index = 2;
                    }
                  },
        icon: Get.isDarkMode
            ? Images.homeActive.png
            : Container(
                width: 8.h,
                height: 8.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? AppColors.BRANDEIS_BLUE
                        : AppColors.GREEK_SEA,
                    shape: BoxShape.circle),
                child: Container(
                  width: 6.5.h,
                  height: 6.5.h,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.TRAPPED_DARKNESS
                          : AppColors.ASHENVALE_NIGHTS,
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    color: AppColors.WHITE,
                    size: 4.h,
                  ),
                ),
              ),
        activeColorPrimary:
            Get.isDarkMode ? AppColors.BLACK_WASH : AppColors.WHITE,
        activeColorSecondary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        inactiveColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 8.5.sp,
            ),
      ),
      PersistentBottomNavBarItem(
        onPressed: persistentTabController.index == 3
            ? null
            : (p0) async {
                if (storage.read("uid") == null) {
                  SnackbarType.error.CustomSnackbar(
                    title: AppStrings.loginTitle,
                    message: AppStrings.notLogin,
                  );
                  await Future.delayed(const Duration(seconds: 2), () {
                    Get.back();
                    Get.toNamed(Routes.LOGIN);
                  });
                } else {
                  Get.toNamed(Routes.MYLISTS);
                }
              },
        title: AppStrings.favorite,
        icon: Images.favoriteActive.pngWithColor(
          Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        ),
        inactiveIcon: Images.favoriteInactive.pngWithColor(
          Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        ),
        activeColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        inactiveColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 8.5.sp,
            ),
      ),
      PersistentBottomNavBarItem(
        onPressed: persistentTabController.index == 4
            ? null
            : (p0) async {
                if (storage.read("uid") == null) {
                  SnackbarType.error.CustomSnackbar(
                    title: AppStrings.loginTitle,
                    message: AppStrings.notLogin,
                  );
                  await Future.delayed(const Duration(seconds: 2), () {
                    Get.back();
                    Get.toNamed(Routes.LOGIN);
                  });
                } else {
                  currentIndex.value = 4;
                  persistentTabController.index = 4;
                }
              },
        title: AppStrings.myAccount,
        icon: Images.myAccountActive.pngWithColor(
          Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        ),
        inactiveIcon: Images.myAccountInactive.pngWithColor(
          Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        ),
        activeColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.ASHENVALE_NIGHTS,
        inactiveColorPrimary:
            Get.isDarkMode ? AppColors.WHITE : AppColors.STELLAR_BLUE,
        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 8.5.sp,
            ),
      ),
    ];
  }
}
