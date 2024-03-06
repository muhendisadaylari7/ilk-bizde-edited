// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/data/model/GetListsRequestModel.dart';
import 'package:ilkbizde/data/network/api/GeListsApi.dart';
import 'package:ilkbizde/modules/Home/index.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CacheSize.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = Get.put(HomeController());
  final GetListsApi getListsApi = GetListsApi();
  final GetStorage storage = GetStorage();
  List<AdsList> lists = [];

  @override
  void initState() {
    super.initState();

    Future.wait([
      controller.getCategories(),
      controller.getDailyOpportunityAdvertisements(),
      controller.getShowcaseAdvertisements(),
      controller.getPopularAdvertisements(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(NetworkController());
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: GetBuilder<NetworkController>(
        builder: (networkController) {
          if (networkController.connectionType.value == 0) {
            return const CustomNoInternetWidget();
          }
          return Column(
            children: [
              Direction.vertical.spacer(1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: CustomSearchInput(
                  onTap: () => Get.toNamed(Routes.SEARCHPAGE),
                ),
              ),
              Direction.vertical.spacer(1),
              Expanded(
                child: Obx(
                  () => SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 6.h, top: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CATEGORY ROW 1
                              controller.allCategories.isEmpty
                                  ? Center(
                                      child: SizedBox(
                                        width: 3.h,
                                        height: 3.h,
                                        child: const CircularProgressIndicator(
                                          color: AppColors.ASHENVALE_NIGHTS,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CustomCategoryWidget(
                                            image: Images.home,
                                            iconColor: Get.isDarkMode
                                                ? AppColors.SAILER_MOON
                                                : AppColors.ASHENVALE_NIGHTS,
                                            title: controller
                                                .allCategories[0].categoryName,
                                            subtitle: controller
                                                    .allCategories[0]
                                                    .categoryAltName ??
                                                "",
                                            onTap: () => controller
                                                .redirectToSelectCategoryPage(
                                                    0),
                                          ),
                                        ),
                                        Get.isDarkMode
                                            ? const SizedBox.shrink()
                                            : Direction.horizontal.spacer(3),
                                        Get.isDarkMode
                                            ? const SizedBox.shrink()
                                            : Expanded(
                                                child: CustomCategoryWidget(
                                                  image: Images.steering,
                                                  title: controller
                                                      .allCategories[1]
                                                      .categoryName,
                                                  subtitle: controller
                                                          .allCategories[1]
                                                          .categoryAltName ??
                                                      "",
                                                  onTap: () => controller
                                                      .redirectToSelectCategoryPage(
                                                          1),
                                                ),
                                              ),
                                      ],
                                    ),
                              Get.isDarkMode
                                  ? const SizedBox.shrink()
                                  : Direction.vertical.spacer(1.5),
                              // CATEGORY ROW 2
                              Get.isDarkMode
                                  ? const SizedBox.shrink()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CustomCategoryWidget(
                                            image: Images.exclamation,
                                            title: "Acil",
                                            subtitle: "Fırsat İlanlar",
                                            onTap: () => Get.toNamed(
                                              Routes.SELECTCATEGORYPAGE,
                                              parameters: {
                                                "categoryId": "",
                                                "categoryName": "Acil",
                                                "isUrgent": "1",
                                              },
                                            ),
                                          ),
                                        ),
                                        Direction.horizontal.spacer(3),
                                        Expanded(
                                          child: CustomCategoryWidget(
                                            image: Images.clock,
                                            title: "Son Dakika",
                                            subtitle: "48 Saat İlanlar",
                                            onTap: () => Get.toNamed(
                                              Routes.SELECTCATEGORYPAGE,
                                              parameters: {
                                                "categoryId": "",
                                                "categoryName": "Son Dakika",
                                                "isLast24": "1",
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              Get.isDarkMode
                                  ? const SizedBox.shrink()
                                  : Direction.vertical.spacer(2),
                            ],
                          ),
                        ),

                        // DAILY OPPORTUNITY
                        Get.isDarkMode
                            ? const SizedBox.shrink()
                            : controller.dailyOpportunityAdvertisements.isEmpty
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Günün Fırsatı",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    fontFamily: AppFonts.light,
                                                  ),
                                            ),
                                            Direction.horizontal.spacer(1),
                                            Images.opportunity.pngWithScale,
                                          ],
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: SmoothPageIndicator(
                                              controller: controller
                                                  .opportunityPageController,
                                              count: controller
                                                  .calculateSmoothPageIndicatorDotForDailyOpportunity(),
                                              effect: ExpandingDotsEffect(
                                                dotHeight: .6.h,
                                                dotWidth: 1.4.w,
                                                dotColor: AppColors.CYAN_SKY
                                                    .withOpacity(.5),
                                                activeDotColor:
                                                    AppColors.ASHENVALE_NIGHTS,
                                                spacing: 1.w,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        // DAILY OPPORTUNITY SLIDER
                        Get.isDarkMode
                            ? const SizedBox.shrink()
                            : controller.dailyOpportunityAdvertisements.isEmpty
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: 24.h,
                                    width: double.infinity,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 1.h,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: .111.w,
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 2.w,
                                      ),
                                      controller:
                                          controller.opportunityPageController,
                                      itemCount: controller
                                          .dailyOpportunityAdvertisements
                                          .length,
                                      itemBuilder: (context, index) {
                                        return CustomDailyOpportunityAdsCard(
                                          onTap: () => Get.toNamed(
                                              Routes.ALLDAILYOPPORTUNITY),
                                          controller: controller,
                                          index: index,
                                          isLoading: controller.isLoading,
                                        );
                                      },
                                    ),
                                  ),
                        // SHOWCASE INDICATOR AND TITLE
                        Get.isDarkMode
                            ? const SizedBox.shrink()
                            : controller.showcaseAdvertisements.isEmpty
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppStrings.homeShowcase,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                fontFamily: AppFonts.light,
                                              ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: SmoothPageIndicator(
                                              controller:
                                                  controller.pageController,
                                              count: controller
                                                  .calculateSmoothPageIndicatorDot(),
                                              effect: ExpandingDotsEffect(
                                                dotHeight: .6.h,
                                                dotWidth: 1.4.w,
                                                dotColor: AppColors.CYAN_SKY
                                                    .withOpacity(.5),
                                                activeDotColor:
                                                    AppColors.ASHENVALE_NIGHTS,
                                                spacing: 1.w,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        // SHOWCASE SLIDER
                        Get.isDarkMode
                            ? const SizedBox.shrink()
                            : controller.showcaseAdvertisements.isEmpty
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: 22.h,
                                    width: double.infinity,
                                    child: GridView.builder(
                                      controller: controller.pageController,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 1.h,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: .3,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2.w,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller
                                          .showcaseAdvertisements.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomSliderItem(
                                              hasUrgent: controller
                                                  .showcaseAdvertisements[index]
                                                  .acil,
                                              hasPriceDrop: controller
                                                  .showcaseAdvertisements[index]
                                                  .fiyatiDusen,
                                              isLoading: controller.isLoading,
                                              isFavorite: controller
                                                  .showcaseAdvertisements[index]
                                                  .fav,
                                              onTap: () {
                                                Get.toNamed(
                                                  Routes.ADVERTISEMENTDETAIL +
                                                      controller
                                                          .showcaseAdvertisements[
                                                              index]
                                                          .adId,
                                                );
                                              },
                                              title: controller
                                                  .showcaseAdvertisements[index]
                                                  .adSubject,
                                              price:
                                                  "${controller.showcaseAdvertisements[index].adPrice} ${controller.showcaseAdvertisements[index].adCurrency}",
                                              favoriteOnTap: () {
                                                _onAddFavoriteButtonPressed(
                                                    controller
                                                        .showcaseAdvertisements[
                                                            index]
                                                        .adId);
                                              },
                                              image: controller
                                                      .showcaseAdvertisements[
                                                          index]
                                                      .adPics
                                                      .isNotEmpty
                                                  ? CachedNetworkImage(
                                                      memCacheHeight: 7
                                                          .h
                                                          .cacheSize(context),
                                                      imageUrl:
                                                          ImageUrlTypeExtension
                                                              .getImageType(
                                                        controller
                                                            .showcaseAdvertisements[
                                                                index]
                                                            .adPics
                                                            .split(",")
                                                            .first,
                                                      ).ImageUrl(controller
                                                              .showcaseAdvertisements[
                                                                  index]
                                                              .adPics),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Images
                                                      .noImages.pngWithScale,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                        Direction.vertical.spacer(1.5),
                        controller.popularAdvertisements.isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Text(
                                  AppStrings.interestedAdvertisement,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                        Direction.vertical.spacer(1),
                        // INTERESTED ADVERTISEMENT
                        controller.popularAdvertisements.isEmpty
                            ? const SizedBox.shrink()
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.popularAdvertisements.length,
                                separatorBuilder: (context, index) {
                                  return CustomSeperatorWidget(
                                    color:
                                        AppColors.STELLAR_BLUE.withOpacity(.5),
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return CustomAdvertisementCard(
                                    hasUrgent: controller
                                        .popularAdvertisements[index].acil,
                                    hasPriceDrop: controller
                                        .popularAdvertisements[index]
                                        .fiyatiDusen,
                                    adId: controller
                                        .popularAdvertisements[index].adId,
                                    hasStyle: controller
                                        .popularAdvertisements[index].hasStyle,
                                    title: controller
                                        .popularAdvertisements[index].adSubject,
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.ADVERTISEMENTDETAIL +
                                            controller
                                                .popularAdvertisements[index]
                                                .adId,
                                      );
                                    },
                                    location:
                                        "${controller.popularAdvertisements[index].adCity}, ${controller.popularAdvertisements[index].adDistrict}",
                                    price:
                                        "${controller.popularAdvertisements[index].adPrice} ${controller.popularAdvertisements[index].adCurrency}",
                                    image: controller
                                            .popularAdvertisements[index]
                                            .adPics
                                            .isNotEmpty
                                        ? CachedNetworkImage(
                                            memCacheHeight:
                                                9.5.h.cacheSize(context),
                                            imageUrl: ImageUrlTypeExtension
                                                .getImageType(
                                              controller
                                                  .popularAdvertisements[index]
                                                  .adPics
                                                  .split(",")
                                                  .first,
                                            ).ImageUrl(controller
                                                .popularAdvertisements[index]
                                                .adPics),
                                          )
                                        : Images.noImages.pngWithScale,
                                    isLoading: controller.isLoading,
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<AdsList>> _getMyLists() async {
    List<AdsList> lists = [];
    return await getListsApi
        .getLists(
            data: GetListsRequestModel(
                secretKey: dotenv.env["SECRET_KEY"].toString(),
                userId: storage.read("uid") ?? "",
                userEmail: storage.read("uEmail") ?? "",
                userPassword: storage.read("uPassword") ?? ""))
        .then((value) {
      if (value.data == null) return [];
      for (var item in value.data) {
        lists.add(AdsList(id: item["id"], title: item["baslik"]));
      }
      return lists;
    });
  }

  _onAddFavoriteButtonPressed(String adId) {
    return _getMyLists().then((lists) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Liste Seç",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: AppColors.BLACK,
              )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.WHITE,
                    backgroundColor: AppColors.RED, // Yazı rengi beyaz
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Kenarları yuvarlama
                    ),
                  ),

                  child: const Text('İptal',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        color: AppColors.WHITE,
                      )), // Buton üzerindeki yazı
                ),
              ],
            )
          ],
          content: SizedBox(
              width: 100.w,
              height: 40.h,
              child: ListView(children: [
                if (lists.isEmpty)
                  const ListTile(
                    title: Text("Liste bulunamadı."),
                  ),
                for (var item in lists)
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.BLACK.withOpacity(.1),
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(item.title),
                      onTap: () {
                        Get.back(result: item.id);
                        controller.addFavorite(
                            adId: adId, listId: item.id.toString());
                      },
                    ),
                  ),
              ])),
        ),
      );
    });
  }
}

class AdsList {
  final String id;
  final String title;

  AdsList({required this.id, required this.title});
}
