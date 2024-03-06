// ignore_for_file: file_names, camel_case_extensions

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/CategoryFilterResponseModel.dart';
import 'package:ilkbizde/data/model/CategoryResultPageRequestModel.dart';
import 'package:ilkbizde/data/model/CityModel.dart';
import 'package:ilkbizde/data/model/CityRequestModel.dart';
import 'package:ilkbizde/data/model/DistrictModel.dart';
import 'package:ilkbizde/data/model/DistrictRequestModel.dart';
import 'package:ilkbizde/data/model/NeighborhoodRequestModel.dart';
import 'package:ilkbizde/data/model/NeighborhoodResponseModel.dart';
import 'package:ilkbizde/data/model/PopularAdvertisementModel.dart';
import 'package:ilkbizde/data/network/api/CategoryAdvertisementApi.dart';
import 'package:ilkbizde/data/network/api/CityApi.dart';
import 'package:ilkbizde/data/network/api/DistrictApi.dart';
import 'package:ilkbizde/data/network/api/GetDynamicCategoryFilter.dart';
import 'package:ilkbizde/data/network/api/Last24HourApi.dart';
import 'package:ilkbizde/data/network/api/Last24HourCategoryAdvertisementApi.dart';
import 'package:ilkbizde/data/network/api/NeighborhoodApi.dart';
import 'package:ilkbizde/data/network/api/UrgentCategoryAdvertisementApi.dart';
import 'package:ilkbizde/data/network/api/UrgentCategoryApi.dart';
import 'package:ilkbizde/shared/widgets/index.dart';

class CategoryResultPageController extends GetxController {
  final GetStorage storage = GetStorage();
  final Map<String, String?> parameters = Get.parameters;
  ScrollController scrollController = ScrollController();
  final TextEditingController atLeastController = TextEditingController();
  final TextEditingController atMostController = TextEditingController();
  final TextEditingController searchTextEditingController =
      TextEditingController();

  RxDouble maxScrollExtent = 0.0.obs;

  final RxBool isLoading = false.obs;

  final RxInt totalAds = 0.obs;
  final RxInt nextPage = 1.obs;
  final RxInt selectedSortItem = 0.obs;
  final RxInt selectedIndex = 0.obs;

  final RxString searchQuery = "".obs;

  RxString selectedDropdownValue = "".obs;
  RxString selectedCity = "".obs;
  RxString selectedDistrict = "".obs;
  RxString selectedNeighborhood = "".obs;
  RxList<CityModel> cities = <CityModel>[].obs;
  RxList<DistrictModel> districts = <DistrictModel>[].obs;
  RxList<NeighborhoodResponseModel> neighborhoods =
      <NeighborhoodResponseModel>[].obs;

  RxList<PopularAdvertisementModel> categoryAdsResult =
      <PopularAdvertisementModel>[].obs;
  RxList<PopularAdvertisementModel> searchCategoryAdsResult =
      <PopularAdvertisementModel>[].obs;
  RxList<PopularAdvertisementModel> filteredCategoryAdsResult =
      <PopularAdvertisementModel>[].obs;
  bool isPerformingScroll = false;
  RxList<String> selectedCheckboxValueList = <String>[].obs;
  Map<String, String> filterValues = {};
  List<String> sortItems = [
    "Önerilen",
    "Tarihe Göre (Yeni)",
    "Tarihe Göre (Eski)",
    "Fiyata Göre (Azalan)",
    "Fiyata Göre (Artan)",
  ];

  RxList filterItems = [
    {
      "selectedValue": "",
      "data": CategoryFilterResponseModel(
        filterId: "",
        filterName: "Fiyat",
        filterParamName: "",
        filterType: "text",
        filterChoises: "",
        filterMultiple: "",
        fieldsMultipleName: "",
        fieldsMaxMin: "",
        fields8: "",
      ),
    },
    {
      "selectedValue": "",
      "data": CategoryFilterResponseModel(
        filterId: "",
        filterName: "Adres",
        filterParamName: "",
        filterType: "select",
        filterChoises: "",
        filterMultiple: "",
        fieldsMultipleName: "",
        fieldsMaxMin: "",
        fields8: "",
      ),
    },
    {
      "selectedValue": "",
      "data": CategoryFilterResponseModel(
        filterId: "",
        filterName: "Kelime ile Filtrele",
        filterParamName: "",
        filterType: "text",
        filterChoises: "",
        filterMultiple: "",
        fieldsMultipleName: "",
        fieldsMaxMin: "",
        fields8: "",
      ),
    },
    {
      "selectedValue": "",
      "data": CategoryFilterResponseModel(
        filterId: "",
        filterName: "İlan Tarihi",
        filterParamName: "",
        filterType: "select",
        filterChoises:
            "Son 24 Saat||Son 3 Gün||Son 7 Gün||Son 15 Gün||Son 1 Ay",
        filterMultiple: "",
        fieldsMultipleName: "",
        fieldsMaxMin: "",
        fields8: "",
      ),
    },
    {
      "selectedValue": "",
      "data": CategoryFilterResponseModel(
        filterId: "",
        filterName: "Seçenekler",
        filterParamName: "",
        filterType: "checkbox",
        filterChoises: "Videolu İlanlar||Fotoğraflı İlanlar||Haritalı İlanlar",
        filterMultiple: "",
        fieldsMultipleName: "",
        fieldsMaxMin: "",
        fields8: "",
      ),
    },
  ].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getDynamicCategoryFilter();
    if (parameters["isUrgent"] == "1") {
      await getCategoryAdvertisements(
          categoryAdvertisementApi: UrgentCategoryAdvertisementApi());
    } else if (parameters["isLast24"] == "1") {
      await getCategoryAdvertisements(
          categoryAdvertisementApi: Last24HourCategoryAdvertisementApi());
    } else {
      await getCategoryAdvertisements(
          categoryAdvertisementApi: CategoryAdvertisementApi());
    }
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        maxScrollExtent.value = scrollController.position.maxScrollExtent;
        await onScroll();
      }
    });
  }

// GET CITY ID
  String getCityId(String city) {
    if (city == "") {
      return "";
    }
    CityModel id = cities.where((p0) => p0.name == city).first;
    return id.id;
  }

  // GET DISTRICT ID
  String getDistrictId(String district) {
    if (district == "") {
      return "";
    }
    DistrictModel id = districts.where((p0) => p0.name == district).first;
    return id.id;
  }

// GET NEIGHBORHOOD ID
  String getNeighborhoodId(String neighborhood) {
    if (neighborhood == "") {
      return "";
    }
    NeighborhoodResponseModel id =
        neighborhoods.where((p0) => p0.name == neighborhood).first;
    return id.id;
  }

  // GET CITIES
  Future<void> getCities() async {
    final CityApi cityApi = CityApi();
    final CityRequestModel cityRequestModel = CityRequestModel(
      countryCode: "TR",
      secretKey: dotenv.env["SECRET_KEY"].toString(),
    );
    try {
      await cityApi
          .getCities(data: cityRequestModel.toJson())
          .then((resp) async {
        cities.clear();
        for (var city in resp.data) {
          cities.add(CityModel.fromJson(city));
        }
        cities.insert(0, CityModel(id: "", name: "İl Seçiniz"));
        if (filterItems[1]["selectedValue"] == "") {
          selectedCity.value = cities.first.name;
          districts.clear();
          neighborhoods.clear();
        } else {
          selectedCity.value = filterItems[2]["selectedValue"].split("-")[0];

          if (filterItems[1]["selectedValue"].split("-")[1] != "") {
            await getDistricts(
                cityId:
                    getCityId(filterItems[2]["selectedValue"].split("-")[0]));
          }
          if (filterItems[1]["selectedValue"].split("-")[2] != "") {
            await getNeighborhood(
                districtId: getDistrictId(
                    filterItems[1]["selectedValue"].split("-")[1]));
          }
        }
      });
    } catch (e) {
      print("getCities error : $e");
    }
  }

  // GET DISTRICTS
  Future<void> getDistricts({required String cityId}) async {
    final DistrictApi districtApi = DistrictApi();
    final DistrictRequestModel districtRequestModel = DistrictRequestModel(
        cityId: cityId, secretKey: dotenv.env["SECRET_KEY"].toString());
    try {
      await districtApi
          .getDistricts(data: districtRequestModel.toJson())
          .then((resp) async {
        districts.clear();
        if (resp.data.isEmpty) {
          selectedDistrict.value = "";
          return;
        }
        for (var district in resp.data) {
          districts.add(DistrictModel.fromJson(district));
        }
        districts.insert(0, DistrictModel(id: "", name: "İlçe Seçiniz"));
        if (filterItems[1]["selectedValue"] == "") {
          selectedDistrict.value = districts.first.name;
          neighborhoods.clear();
        } else {
          if (filterItems[1]["selectedValue"].split("-")[1] == "") {
            selectedDistrict.value = districts.first.name;
          }
          selectedDistrict.value =
              filterItems[1]["selectedValue"].split("-")[1];
          if (filterItems[1]["selectedValue"].split("-")[2] != "") {
            await getNeighborhood(
                districtId: getDistrictId(
                    filterItems[1]["selectedValue"].split("-")[1]));
          }
        }
      });
    } catch (e) {
      print("getDistricts error : $e");
    }
  }

// GET NEIGHBORHOODS
  Future<void> getNeighborhood({required String districtId}) async {
    final NeighborhoodApi neighborhoodApi = NeighborhoodApi();
    final NeighborhoodRequestModel neighborhoodRequestModel =
        NeighborhoodRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      distinctId: districtId,
    );

    try {
      await neighborhoodApi
          .getNeighborhood(data: neighborhoodRequestModel.toJson())
          .then((resp) {
        neighborhoods.clear();
        for (var neighborhood in resp.data) {
          neighborhoods.add(NeighborhoodResponseModel.fromJson(neighborhood));
        }
        neighborhoods.insert(
            0,
            NeighborhoodResponseModel(
                id: "", name: "Mahalle Seçiniz", semtId: '', semtName: ''));
        if (filterItems[1]["selectedValue"] == "") {
          selectedNeighborhood.value = neighborhoods.first.name;
        } else {
          if (filterItems[1]["selectedValue"].split("-")[2] == "") {
            selectedNeighborhood.value = neighborhoods.first.name;
          }
          selectedNeighborhood.value =
              filterItems[1]["selectedValue"].split("-")[2];
        }
      });
    } catch (e) {
      print("getNeighborhood error : $e");
    }
  }

  // KATEGORİ İLANLARI
  Future<void> getCategoryAdvertisements({
    String page = "1",
    String sort = "1",
    bool isSort = false,
    required dynamic categoryAdvertisementApi,
  }) async {
    isLoading.toggle();

    final CategoryResultPageRequestModel categoryResultPageRequestModel =
        CategoryResultPageRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
      categoryId: parameters["categoryId"].toString(),
      limit: "",
      sort: sort,
      page: page,
      search: filterItems[2]["selectedValue"] != ""
          ? filterItems[2]["selectedValue"].split("-")[0]
          : "",
      searchDescInc: "",
      country: "",
      city: filterItems[1]["selectedValue"] == ""
          ? ""
          : filterItems[1]["selectedValue"].contains("İl Seçiniz")
              ? ""
              : getCityId(filterItems[1]["selectedValue"].split("-")[0]),
      distinct: filterItems[1]["selectedValue"].contains("İlçe Seçiniz") ||
              filterItems[1]["selectedValue"] == ""
          ? ""
          : getDistrictId(filterItems[1]["selectedValue"].split("-")[1]),
      mahalle: filterItems[1]["selectedValue"].contains("Mahalle Seçiniz") ||
              filterItems[1]["selectedValue"] == ""
          ? ""
          : getNeighborhoodId(filterItems[1]["selectedValue"].split("-")[2]),
      price1: filterItems[0]["selectedValue"] != ""
          ? filterItems[0]["selectedValue"].split("-")[0]
          : "",
      price2: filterItems[0]["selectedValue"] != ""
          ? filterItems[0]["selectedValue"].split("-")[1]
          : "",
      currency: "TL",
      date: getDateIdFromDateString(filterItems[3]["selectedValue"] ?? ""),
      video: getCheckboxIdFromCheckboxString(
          filterItems[4]["selectedValue"] != ""
              ? filterItems[4]["selectedValue"].split("-")[0]
              : ""),
      photo: getCheckboxIdFromCheckboxString(
          filterItems[4]["selectedValue"] != ""
              ? filterItems[4]["selectedValue"].split("-")[1]
              : ""),
      map: getCheckboxIdFromCheckboxString(
        filterItems[4]["selectedValue"] != ""
            ? filterItems[4]["selectedValue"].split("-")[2]
            : "",
      ),
      pro: Get.isDarkMode ? "1" : "",
    );

    Map<String, dynamic> mergedFilterMap =
        categoryResultPageRequestModel.toJson();
    mergedFilterMap.addAll(filterValues);

    try {
      await categoryAdvertisementApi
          .getCategoryAdvertisements(data: mergedFilterMap)
          .then((resp) async {
        if (resp.data.isEmpty) {
          isPerformingScroll = true;
        }
        if (isSort) {
          isPerformingScroll = false;
          categoryAdsResult.clear();
          for (var category in resp.data) {
            categoryAdsResult.add(PopularAdvertisementModel.fromJson(category));
          }
          totalAds.value = categoryAdsResult.length;
          searchCategoryResults();
          return;
        } else {
          if (resp.data.length < 100) {
            isPerformingScroll = true;
          } else {
            isPerformingScroll = false;
          }
          for (var category in resp.data) {
            categoryAdsResult.add(PopularAdvertisementModel.fromJson(category));
          }
          totalAds.value = int.parse(parameters["totalAds"]
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""));
          searchCategoryResults();
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("getCategoryAdvertisements error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // SIRALA
  Future<void> handleSort() async {
    await clearFilter();
    nextPage.value = 1;
    selectedSortItem.value = selectedIndex.value + 1;
    if (parameters["isUrgent"] == "1") {
      await getCategoryAdvertisements(
        categoryAdvertisementApi: UrgentCategoryApi(),
        sort: selectedSortItem.value.toString(),
        isSort: true,
      );
    } else if (parameters["isLast24"] == "1") {
      await getCategoryAdvertisements(
        categoryAdvertisementApi: Last24HourCategoryAdvertisementApi(),
        sort: selectedSortItem.value.toString(),
        isSort: true,
      );
    } else {
      await getCategoryAdvertisements(
        categoryAdvertisementApi: CategoryAdvertisementApi(),
        sort: selectedSortItem.value.toString(),
        isSort: true,
      );
    }

    Get.back();
  }

  Future<void> onScroll() async {
    if (isPerformingScroll) return;
    if (categoryAdsResult.length <
        int.parse(
          parameters["totalAds"]
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
        )) {
      nextPage.value++;
      if (parameters["isUrgent"] == "1") {
        await getCategoryAdvertisements(
          categoryAdvertisementApi: UrgentCategoryApi(),
          page: nextPage.value.toString(),
          sort: selectedSortItem.value.toString(),
          isSort: false,
        );
      } else if (parameters["isLast24"] == "1") {
        await getCategoryAdvertisements(
          categoryAdvertisementApi: Last24HourApi(),
          page: nextPage.value.toString(),
          sort: selectedSortItem.value.toString(),
          isSort: false,
        );
      } else {
        await getCategoryAdvertisements(
          categoryAdvertisementApi: CategoryAdvertisementApi(),
          page: nextPage.value.toString(),
          sort: selectedSortItem.value.toString(),
          isSort: false,
        );
      }
      totalAds.value = categoryAdsResult.length;
      Future.delayed(
        const Duration(milliseconds: 50),
        () => scrollController.animateTo(
          maxScrollExtent.value + 500,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeOut,
        ),
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    atLeastController.dispose();
    atMostController.dispose();
    searchTextEditingController.dispose();
    isPerformingScroll = false;
  }

  Future<void> clearFilter() async {
    nextPage.value = 1;
    atLeastController.clear();
    atMostController.clear();
    await getDynamicCategoryFilter();
    for (var i = 0; i < filterItems.length; i++) {
      filterItems[i]["selectedValue"] = "";
      checkboxSelectedValueRandom(i);
    }
    totalAds.value = int.parse(parameters["totalAds"]
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", ""));
    if (parameters["isUrgent"] == "1") {
      await getCategoryAdvertisements(
          categoryAdvertisementApi: UrgentCategoryApi(), isSort: true);
    } else if (parameters["isLast24"] == "1") {
      await getCategoryAdvertisements(
          categoryAdvertisementApi: Last24HourApi(), isSort: true);
    } else {
      await getCategoryAdvertisements(
        categoryAdvertisementApi: CategoryAdvertisementApi(),
        isSort: true,
      );
    }
  }

  void createFilterBottomSheet() {
    Get.bottomSheet(
      isDismissible: false,
      enableDrag: false,
      ignoreSafeArea: false,
      isScrollControlled: true,
      CustomFilterAdsBottomSheet(
        controller: this,
      ),
    );
  }

  Future<void> handleFilter() async {
    selectedSortItem.value = 0;
    for (var item in filterItems) {
      if (item['data'] != null &&
          item['data'].filterParamName != null &&
          item['selectedValue'] != "") {
        if (item['data'].filterType == "text" &&
            item['data'].filterParamName != "") {
          List<String> selectedValues = item['selectedValue'].split('-');
          for (int i = 0; i < selectedValues.length; i++) {
            filterValues["${item["data"].filterParamName}-${i + 1}"] =
                selectedValues[i];
          }
        } else if (item['data'].filterType == "select") {
          final choices = item['data'].filterChoises.split("||");
          final selectedValue = item['selectedValue'];
          final selectedIndex = choices.indexOf(selectedValue);
          if (selectedIndex != -1) {
            filterValues[item["data"].filterParamName] =
                selectedIndex.toString();
          } else {
            // Seçilen değer bulunamadıysa boş dönecek.
            filterValues[item["data"].filterParamName] = "Merhaba";
          }
        } else if (item["data"].filterType == "checkbox") {
          List<String> selectedValues = item['selectedValue'].split('-');
          String paramName = item["data"].filterParamName;
          String updatedValue = "";
          for (int i = 0; i < selectedValues.length; i++) {
            if (selectedValues[i] == "true") {
              updatedValue += "$i-";
            }
          }
          // Son elemanın sağında "-" işaretini kaldırın.
          if (updatedValue.isNotEmpty) {
            updatedValue = updatedValue.substring(0, updatedValue.length - 1);
          }
          if (paramName != "") {
            filterValues[paramName] = updatedValue;
          }
        }
      }
    }
    nextPage.value = 1;
    if (parameters["isUrgent"] == "1") {
      await filterAdvertisements(
          categoryAdvertisementApi: UrgentCategoryApi(),
          filterItems: filterItems);
    } else if (parameters["isLast24"] == "1") {
      await filterAdvertisements(
          categoryAdvertisementApi: Last24HourApi(), filterItems: filterItems);
    } else {
      await filterAdvertisements(
          categoryAdvertisementApi: CategoryAdvertisementApi(),
          filterItems: filterItems);
    }

    totalAds.value = categoryAdsResult.length;

    Get.back();
  }

  // KATEGORİYE GÖRE FİLTRELEME
  Future<void> filterAdvertisements({
    required dynamic categoryAdvertisementApi,
    bool isSort = true,
    required RxList<dynamic> filterItems,
  }) async {
    isLoading.toggle();

    try {
      await getCategoryAdvertisements(
        categoryAdvertisementApi: categoryAdvertisementApi,
        isSort: isSort,
      );
    } catch (e) {
      isLoading.toggle();
      print("filterAdvertisements error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // İLAN TARİHİNDEKİ SEÇENEĞE GÖRE İD DÖNDERİYORUZ
  String getDateIdFromDateString(String date) {
    switch (date) {
      case "Son 24 Saat":
        return "1";
      case "Son 3 Gün":
        return "2";
      case "Son 7 Gün":
        return "3";
      case "Son 15 Gün":
        return "4";
      case "Son 1 Ay":
        return "5";
      default:
        return "";
    }
  }

  // İLANIN HARİTALI,VİDEOLU VEYA FOTOĞRAFLI OLMASINA GÖRE İD DÖNDERİYORUZ
  String getCheckboxIdFromCheckboxString(String isEnabled) {
    switch (isEnabled) {
      case "true":
        return "1";
      case "false":
        return "";
      default:
        return "";
    }
  }

  // DİNAMİK FİLTRELERİ GETİR
  Future<void> getDynamicCategoryFilter() async {
    final CategoryDynamicFilter categoryDynamicFilter = CategoryDynamicFilter();
    try {
      await categoryDynamicFilter.getCategoryDynamicFilter(data: {
        "secretKey": dotenv.env["SECRET_KEY"].toString(),
        "categoryId": parameters["categoryId"].toString(),
      }).then((resp) {
        for (var item in resp.data) {
          filterItems.add(
            {
              "selectedValue": "",
              "data": CategoryFilterResponseModel.fromJson(item),
            },
          );
          if (item['filterType'] == 'text') {
            String paramName = item['filterParamName'];
            int index1 = 1;
            int index2 = 2;

            filterValues["$paramName-$index1"] = "";
            filterValues["$paramName-$index2"] = "";
          } else {
            filterValues[item['filterParamName']] = "";
          }
        }
      });
    } catch (e) {
      print("deneme hata: $e");
    }
  }

// CHECKBOX OLAN FİLTRE TİPLERİNE OTOMATİK BAŞTA FALSE DEĞER ATAR
  void checkboxSelectedValueRandom(int filterItemIndex) {
    if (filterItems[filterItemIndex]["selectedValue"] != "") return;
    if (filterItems[filterItemIndex]["data"].filterType == "checkbox") {
      for (var i = 0;
          i <
              filterItems[filterItemIndex]["data"]
                  .filterChoises
                  .split("||")
                  .length;
          i++) {
        filterItems[filterItemIndex]["selectedValue"] += "false";
        selectedCheckboxValueList.add("false");

        if (i <
            filterItems[filterItemIndex]["data"]
                    .filterChoises
                    .split("||")
                    .length -
                1) {
          filterItems[filterItemIndex]["selectedValue"] += "-";
          selectedCheckboxValueList.join("-");
        }
      }
    }
  }

// FİLTRELEME BUTONUNA BASILDIĞINDA ÇALIŞIR
  void filterItemOnTap(int index, BuildContext context) {
    if (filterItems[index]["data"].filterType == "checkbox") {
      List<String> selectedValueList =
          filterItems[index]["selectedValue"].split("-");
      selectedCheckboxValueList.clear();
      selectedCheckboxValueList.value = selectedValueList;
      selectedCheckboxValueList.refresh();
    }
    if (filterItems[index]["selectedValue"] == "" &&
        filterItems[index]["data"].filterType == "select") {
      selectedDropdownValue.value =
          filterItems[index]["data"].filterChoises.split("||")[0];
    }

    if (filterItems[index]["selectedValue"] != "" &&
        filterItems[index]["data"].filterType == "text") {
      atLeastController.text =
          filterItems[index]["selectedValue"].split("-")[0];
      atMostController.text = filterItems[index]["selectedValue"].split("-")[1];
    } else {
      atLeastController.clear();
      atMostController.clear();
    }
    Get.dialog(
      getDialogWidgetFromFilterType
          .getFilterType(filterItems[index]["data"].filterType)
          .getDialogWidget(
            filterItems[index]["data"].filterName,
            this,
            context,
            index,
          ),
    );
  }

  // SEARCH CATEGORY ADS RESULT
  void searchCategoryResults() {
    searchCategoryAdsResult.clear();

    if (searchQuery.isEmpty) {
      searchCategoryAdsResult.addAll(categoryAdsResult);
      return;
    }

    for (var adsResult in categoryAdsResult) {
      if (adsResult.adSubject
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase())) {
        searchCategoryAdsResult.add(adsResult);
      }
    }
  }
}

enum FilterType { text, select, checkbox }

extension getDialogWidgetFromFilterType on FilterType {
  static FilterType getFilterType(String filterType) {
    switch (filterType) {
      case "text":
        return FilterType.text;
      case "select":
        return FilterType.select;
      case "checkbox":
        return FilterType.checkbox;
      default:
        return FilterType.text;
    }
  }

  Widget getDialogWidget(
    String title,
    CategoryResultPageController controller,
    BuildContext context,
    int filterItemIndex,
  ) {
    switch (this) {
      case FilterType.text:
        return filterItemIndex == 3
            ? CustomFilterTypeTextSearchWidget(
                title: title,
                atLeastController: controller.atLeastController,
                cancelOnTap: () {
                  Get.back();
                  controller.atLeastController.clear();
                },
                saveOnTap: () {
                  Get.back();
                  controller.filterItems[filterItemIndex]["selectedValue"] =
                      "${controller.atLeastController.text}-";
                },
              )
            : CustomFilterTypeTextWidget(
                title: title,
                isNumberType: true,
                atLeastController: controller.atLeastController,
                atMostController: controller.atMostController,
                cancelOnTap: () {
                  Get.back();
                  controller.atLeastController.clear();
                  controller.atMostController.clear();
                },
                saveOnTap: () {
                  Get.back();
                  controller.filterItems[filterItemIndex]["selectedValue"] =
                      "${controller.atLeastController.text}-${controller.atMostController.text}";
                },
              );
      case FilterType.select:
        return filterItemIndex == 2
            ? CustomFilterTypeAdressSelectWidget(
                title: title,
                controller: controller,
                filterItemIndex: filterItemIndex,
              )
            : CustomFilterTypeSelectWidget(
                title: title,
                categoryResultPageController: controller,
                filterItemIndex: filterItemIndex,
                saveOnTap: () {
                  controller.filterItems[filterItemIndex]["selectedValue"] =
                      controller.selectedDropdownValue.value;
                  Get.back();
                },
              );
      case FilterType.checkbox:
        return CustomFilterTypeCheckboxWidget(
          title: title,
          controller: controller,
          filterItemIndex: filterItemIndex,
        );
    }
  }
}
