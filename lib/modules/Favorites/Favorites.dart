// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/data/model/AddOrDeleteFavoriteRequestModel.dart';
import 'package:ilkbizde/data/model/AllFavoritesAdvertisementModel.dart';
import 'package:ilkbizde/data/model/GetListAdsRequestModel.dart';
import 'package:ilkbizde/data/network/api/AddOrDeleteFavoriteApi.dart';
import 'package:ilkbizde/data/network/api/GetListAdsRequestApi.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/extensions/CacheSize.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:sizer/sizer.dart';

import '../../shared/widgets/index.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Future<bool>? allFavoritesAdded;
  RxBool isLoading = false.obs;
  RxString searchQuery = "".obs;
  var data = Get.parameters;
  String? listId;

  final GetStorage storage = GetStorage();
  final GetListAdsRequestApi getListAdsRequestApi = GetListAdsRequestApi();

  RxList<AllFavoritesAdvertisementModel> allFavoritesAdvertisement =
      <AllFavoritesAdvertisementModel>[].obs;
  RxList<AllFavoritesAdvertisementModel> searchFavoritAdvertisement =
      <AllFavoritesAdvertisementModel>[].obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listId = data["listId"];
    if (listId == null) {
      Get.back();
    } else {
      allFavoritesAdded = getAllFavoriteAdvertisements();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.SOOTY : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                searchController.addListener(() {
                  searchQuery.value = searchController.text;
                  searchFavorites();
                });
              },
              cursorColor: AppColors.BLACK,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Get.isDarkMode ? null : AppColors.OBSIDIAN_SHARD,
                  ),
              decoration: InputDecoration(
                hintText: AppStrings.favoriteSearchHintText,
                hintStyle: Theme.of(context).textTheme.labelMedium,
                suffixIcon: const CustomImageAsset(path: Images.inputSearch),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            Direction.vertical.spacer(2),
            Expanded(
                child: FutureBuilder(
                    future: allFavoritesAdded, builder: _pageBuilder)),
          ],
        );
      }),
    );
  }

  Widget _pageBuilder(
    BuildContext _,
    AsyncSnapshot<bool> snapshot,
  ) {
    if (snapshot.hasData) {
      return allFavoritesAdvertisement.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Images.noFavorite.pngWithScale,
                  Direction.vertical.spacer(2),
                  Text(
                    AppStrings.noFavorites,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.SHY_MOMENT,
                        ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 6.h),
              itemCount: searchFavoritAdvertisement.length,
              separatorBuilder: (context, index) =>
                  Direction.vertical.spacer(1.5),
              itemBuilder: (context, index) {
                return CustomAdvertisementCard(
                  hasUrgent: searchFavoritAdvertisement[index].acil,
                  hasPriceDrop: searchFavoritAdvertisement[index].fiyatiDusen,
                  hasStyle: searchFavoritAdvertisement[index].hasStyle,
                  isLoading: isLoading,
                  onFavoriteTap: () {
                    deleteFavorite(
                        adId: searchFavoritAdvertisement[index].adId);
                  },
                  isFavoriteAdvertisement: true,
                  title: searchFavoritAdvertisement[index].adSubject,
                  onTap: () {
                    Get.toNamed(
                      Routes.ADVERTISEMENTDETAIL +
                          searchFavoritAdvertisement[index].adId,
                    );
                  },
                  location:
                      "${searchFavoritAdvertisement[index].adCity}, ${searchFavoritAdvertisement[index].adDistrict}",
                  price:
                      "${searchFavoritAdvertisement[index].adPrice} ${searchFavoritAdvertisement[index].adCurrency}",
                  image: searchFavoritAdvertisement[index].adPics.isNotEmpty
                      ? CachedNetworkImage(
                          memCacheHeight: 9.5.h.cacheSize(context),
                          imageUrl: ImageUrlTypeExtension.getImageType(
                                  searchFavoritAdvertisement[index]
                                      .adPics
                                      .split(",")
                                      .first)
                              .ImageUrl(
                                  searchFavoritAdvertisement[index].adPics),
                          fit: BoxFit.cover,
                        )
                      : Images.noImages.pngWithColor(
                          Get.isDarkMode ? AppColors.WHITE : AppColors.BLACK,
                        ),
                );
              },
            );
    } else if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Images.noFavorite.pngWithScale,
            Direction.vertical.spacer(2),
            Text(
              AppStrings.noFavorites,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.SHY_MOMENT,
                  ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.ASHENVALE_NIGHTS,
        ),
      );
    }
  }

  Future<bool> getAllFavoriteAdvertisements() async {
    isLoading.toggle();
    allFavoritesAdvertisement.clear();
    final GetListAdsRequestApi allFavoriteApi = GetListAdsRequestApi();
    final GetListAdsRequestModel advertisementRequestModel =
        GetListAdsRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userEmail: storage.read("uEmail") ?? "",
      userId: storage.read("uid") ?? "",
      userPassword: storage.read("uPassword") ?? "",
      listId: listId ?? "",
    );
    try {
      return await allFavoriteApi
          .getListAds(data: advertisementRequestModel)
          .then((resp) {
        if (resp.data != null) {
          isLoading.toggle();
          for (var ads in resp.data) {
            allFavoritesAdvertisement
                .add(AllFavoritesAdvertisementModel.fromJson(ads));
            searchFavorites();
          }
          // allFavoritesAdvertisement.refresh();
          return true;
        }
        return false;
      });
    } catch (e) {
      isLoading.toggle();
      return false;
    }
  }

  Future<void> deleteFavorite({required String adId}) async {
    final AddOrDeleteFavoriteApi addOrDeleteFavoriteApi =
        AddOrDeleteFavoriteApi();
    final AddOrDeleteFavoriteRequestModel addOrDeleteFavoriteRequestModel =
        AddOrDeleteFavoriteRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      id: adId,
    );
    try {
      await addOrDeleteFavoriteApi
          .addOrDeleteFavorite(data: addOrDeleteFavoriteRequestModel.toJson())
          .then((resp) async {
        searchFavoritAdvertisement
            .removeWhere((element) => element.adId == adId);
        allFavoritesAdvertisement
            .removeWhere((element) => element.adId == adId);
        searchFavoritAdvertisement.refresh();
        SnackbarType.success.CustomSnackbar(
          title: AppStrings.success,
          message: resp.data["message"],
        );
        await Future.delayed(const Duration(seconds: 2), () => Get.back());
      });
    } catch (e) {
      print("addFavorite() error: $e");
    }
  }

  // SEARCH FAVORITES5
  void searchFavorites() {
    searchFavoritAdvertisement.clear();

    if (searchQuery.isEmpty) {
      searchFavoritAdvertisement.addAll(allFavoritesAdvertisement);
      return;
    }

    for (var ads in allFavoritesAdvertisement) {
      if (ads.adSubject
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase())) {
        searchFavoritAdvertisement.add(ads);
      }
    }
  }
}

class CustomImageAsset extends StatelessWidget {
  final Images path;
  const CustomImageAsset({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/${path.value}.png",
      scale: 4,
      color: AppColors.ASHENVALE_NIGHTS,
    );
  }
}
