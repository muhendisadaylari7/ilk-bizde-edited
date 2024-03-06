// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_watermark/flutter_watermark.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/AddressInfosRequestModel.dart';
import 'package:ilkbizde/data/model/AdsPublishRequestModel.dart';
import 'package:ilkbizde/data/model/CityModel.dart';
import 'package:ilkbizde/data/model/CityRequestModel.dart';
import 'package:ilkbizde/data/model/CountryModel.dart';
import 'package:ilkbizde/data/model/CountryRequestModel.dart';
import 'package:ilkbizde/data/model/CreateAdsCategoryFilterResponseModel.dart';
import 'package:ilkbizde/data/model/CreateAdsFilterRequestModel.dart';
import 'package:ilkbizde/data/model/DefaultInfosRequestModel.dart';
import 'package:ilkbizde/data/model/DeleteAdsVideoRequestModel.dart';
import 'package:ilkbizde/data/model/DistrictModel.dart';
import 'package:ilkbizde/data/model/DistrictRequestModel.dart';
import 'package:ilkbizde/data/model/DopingInfosRequestModel.dart';
import 'package:ilkbizde/data/model/NeighborhoodRequestModel.dart';
import 'package:ilkbizde/data/model/NeighborhoodResponseModel.dart';
import 'package:ilkbizde/data/model/PhotoAndVideoRequestModel.dart';
import 'package:ilkbizde/data/model/PreviewInfoRequestModel.dart';
import 'package:ilkbizde/data/model/PreviewInfoResponseModel.dart';
import 'package:ilkbizde/data/model/SelectedDopingsModel.dart';
import 'package:ilkbizde/data/network/api/CityApi.dart';
import 'package:ilkbizde/data/network/api/CountryApi.dart';
import 'package:ilkbizde/data/network/api/CreateAdsFilterApi.dart';
import 'package:ilkbizde/data/network/api/CreateAdsSaveApi.dart';
import 'package:ilkbizde/data/network/api/DeleteAdsVideoApi.dart';
import 'package:ilkbizde/data/network/api/DistrictApi.dart';
import 'package:ilkbizde/data/network/api/NeighborhoodApi.dart';
import 'package:ilkbizde/data/network/api/PaymentCheckApi.dart';
import 'package:ilkbizde/data/network/api/PaymentTrackApi.dart';
import 'package:ilkbizde/data/network/api/UpdateAdsApi.dart';
import 'package:ilkbizde/modules/AdsPublish/widgets/CustomAdsPreviewInfos.dart';
import 'package:ilkbizde/modules/AdsPublish/widgets/index.dart';
import 'package:ilkbizde/modules/CategoryResultPage/CategoryResultPageController.dart';
import 'package:ilkbizde/modules/MyAds/index.dart';
import 'package:ilkbizde/modules/MyAdsDetail/index.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/enum/myAdsType.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdsPublishController extends GetxController
    with GetSingleTickerProviderStateMixin {
  DisableScreenshots watermark = DisableScreenshots();

  final OverlayPortalController overlayPortalController =
      OverlayPortalController();
  final String imageCode = DateTime.now().microsecondsSinceEpoch.toString();

  late final AnimationController animationController;

  final ImagePicker picker = ImagePicker();

  final GetStorage storage = GetStorage();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PageController pageController = PageController();
  PageController previewImagePageController = PageController();

  final MapController mapController = MapController();

  VideoPlayerController videoPlayerController =
      VideoPlayerController.file(File(""));

  final WebViewController webViewController = WebViewController();

  final Map<String, dynamic> parameters = Get.parameters;
  final TextEditingController atLeastController = TextEditingController();
  final TextEditingController atMostController = TextEditingController();

  LatLng currentLocation = const LatLng(0, 0);
  final Map<String, String> filterValues = {};

  final RxList<File> imageList = <File>[].obs;

  final RxList<RxBool> imageLoadingState = <RxBool>[].obs;

  final Rx<File> video = File("").obs;

  final RxString selectedCountry = "Türkiye".obs;
  final RxString selectedCity = "".obs;
  final RxString selectedDistrict = "".obs;
  final RxString selectedNeighborhood = "".obs;

  final RxBool isLoading = false.obs;
  final RxBool isStepLoading = false.obs;
  final RxBool isPlay = false.obs;
  final RxBool hasVideo = false.obs;
  final RxBool isRuleAccepted = false.obs;
  final RxBool isPhotoAndVideoLoading = false.obs;
  final RxBool isShowcasePhoto = false.obs;
  final RxBool isSatellite = false.obs;

  final RxInt currentPageIndex = 0.obs;
  final RxInt totalPrice = 0.obs;
  final RxInt previewImageSliderCurrentIndex = 0.obs;
  final RxInt selectedTab = 0.obs;

  final RxList allValues = [].obs;
  final RxList<CountryModel> countries = <CountryModel>[].obs;
  final RxList<CityModel> cities = <CityModel>[].obs;
  final RxList<DistrictModel> districts = <DistrictModel>[].obs;
  final RxList<NeighborhoodResponseModel> neighborhoods =
      <NeighborhoodResponseModel>[].obs;
  final RxList<CreateAdsCategoryFilterResponseModel> filterItems =
      <CreateAdsCategoryFilterResponseModel>[].obs;
  final RxList allFilters = [].obs;
  final RxList<Doping> dopingFilters = <Doping>[].obs;
  final RxList<Map<String, dynamic>> createAdsSteps =
      <Map<String, dynamic>>[].obs;
  final RxList<Marker> markers = <Marker>[].obs;
  final RxSet<SelectedDopingsModel> selectedDopingsSet =
      <SelectedDopingsModel>{}.obs;
  final RxList<SelectedDoping> selectedDopings = <SelectedDoping>[].obs;
  final RxList<PreviewInfoResponseModel> previewInfos =
      <PreviewInfoResponseModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    overlayPortalController.show();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    if (parameters["isEdit"] != "1") {
      getAdsFilter();
      getCountries(countryCode: "TR");
    }
    if (parameters["isEdit"] == "1") {
      if (parameters["buyDoping"] == "1") {
        currentPageIndex.value = 4;
        pageController = PageController(initialPage: 4);
      }
    }

    createAdsSteps.addAll([
      {
        "title": "Temel Bilgiler",
        "widget": CustomDefaultInfos(controller: this),
      },
      {
        "title": "Fotoğraf/Video Bilgileri",
        "widget": CustomPhotoAndVideoInfos(controller: this),
      },
      {
        "title": "Adres Bilgileri",
        "widget": CustomAddressInfos(controller: this),
      },
      {
        "title": "Önizleme",
        "widget": CustomAdsPreviewInfos(controller: this),
      },
      {
        "title": "Doping",
        "widget": CustomDopingInfos(
          dopingFilters: dopingFilters,
          allValues: allValues,
          allFilters: allFilters,
          totalPrice: totalPrice,
        )
      }
    ]);
  }

// VİDEO OYNATMA
  void playPauseVideo() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController
        ..removeListener(() {})
        ..setLooping(false).then((value) {
          isPlay.toggle();
          videoPlayerController.pause();
        });
    } else {
      videoPlayerController
        ..removeListener(() {})
        ..setLooping(false).then((value) {
          isPlay.toggle();
          videoPlayerController.play();
        });
    }
  }

  @override
  void onClose() {
    atLeastController.dispose();
    atMostController.dispose();
    videoPlayerController.dispose();
    animationController.dispose();
    super.onClose();
  }

  // İLANA AİT FOTOĞRAF/VIDEO GETİR
  Future<void> getAdsPhotosAndVideos() async {
    final MyAdsDetailController myAdsDetailController =
        Get.find<MyAdsDetailController>();
    if (myAdsDetailController.defaultInfos.first.video == true) {
      var tempDir = await getDownloadsDirectory();
      String fullPath = "${tempDir!.path}/${parameters["adId"]}.mp4";
      final Dio dio = Dio();
      dio
          .download(
        "${dotenv.env["VIDEO_URL"]}${parameters["adId"]}.mp4",
        fullPath,
        onReceiveProgress: (rcv, total) async {},
      )
          .catchError((e) async {
        Get.close(1);
        SnackbarType.error.CustomSnackbar(
            title: AppStrings.error, message: "Video yüklenemedi.");
        await Future.delayed(const Duration(seconds: 2), () => Get.back());
        return e;
      });
      hasVideo.toggle();
      video.value = File(fullPath);
      videoPlayerController = VideoPlayerController.file(File(fullPath));
      await videoPlayerController.initialize();
    }

    if (myAdsDetailController.defaultInfos.first.adPic != null) {
      var adPics = myAdsDetailController.defaultInfos.first.adPic!.contains(",")
          ? myAdsDetailController.defaultInfos.first.adPic!.split(",")
          : [myAdsDetailController.defaultInfos.first.adPic!];
      final dioPack = dio.Dio();
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      for (var adPic in adPics) {
        try {
          var imagePath =
              ImageUrlTypeExtension.getImageType(adPic).ImageUrl(adPic);
          // DefaultCacheManager manager = DefaultCacheManager();
          // FileInfo? fileInfo =
          //     await manager.getFileFromCache("${appDocDirectory.path}/$adPic");
          bool isFileExists =
              await File("${appDocDirectory.path}/$adPic").exists();
          if (!isFileExists) {
            // // Resim önbellekte yok, indirme işlemini gerçekleştir
            // var imageId = await ImageDownloader.downloadImage(imagePath);
            var imageBytes = await dioPack.get(
              imagePath,
              options: dio.Options(
                responseType: dio.ResponseType.bytes,
              ),
            );

            File("${appDocDirectory.path}/$adPic")
                .writeAsBytes(imageBytes.data)
                .then((File image) {
              imageLoadingState.add(true.obs);
              imageList.add(image);
            }).catchError((error) {
              print('Hata oluştu: $error');
            });

            // if (imageId == null) {
            //   SnackbarType.error.CustomSnackbar(
            //       title: AppStrings.error,
            //       message: "Galeri izninizi kontrol ediniz.");
            //   await Future.delayed(const Duration(seconds: 2), () => Get.back());
            //   openAppSettings();
            //   Get.close(1);
            //   return;
            // }
            // // Below is a method of obtaining saved image information.
            // var path = await ImageDownloader.findPath(imageId);
            // print("path: $path");
            // imageLoadingState.add(true.obs);
            // imageList.add(File(path!));
          } else {
            // Resim CacheManager önbelleğinde bulundu, buradan oku
            imageLoadingState.add(true.obs);
            imageList.add(File("${appDocDirectory.path}/$adPic"));
          }
        } on PlatformException catch (error) {
          print("RESİM İNDİRME HATASI: $error");
        }
      }
    }
  }

  // GET COUNTRIES
  Future<void> getCountries(
      {required String countryCode, String? cityId}) async {
    final CountryApi countryApi = CountryApi();
    final CountryRequestModel countryRequestModel =
        CountryRequestModel(secretKey: dotenv.env["SECRET_KEY"].toString());
    try {
      await countryApi
          .getCountries(data: countryRequestModel.toJson())
          .then((resp) async {
        selectedCountry.value = resp.data
            .where((p0) => p0["code"] == countryCode)
            .toList()[0]["name"]
            .toString();
        for (var country in resp.data) {
          countries.add(CountryModel.fromJson(country));
        }
        await getCities(countryCode: countryCode, cityId: cityId ?? "");
      });
    } catch (e) {
      print("getCountries error : $e");
    }
  }

// GET CITIES
  Future<void> getCities({required String countryCode, String? cityId}) async {
    final CityApi cityApi = CityApi();
    final CityRequestModel cityRequestModel = CityRequestModel(
      countryCode: countryCode,
      secretKey: dotenv.env["SECRET_KEY"].toString(),
    );
    try {
      await cityApi
          .getCities(data: cityRequestModel.toJson())
          .then((resp) async {
        cities.clear();
        // selectedCity.value = resp.data[0]["name"];
        selectedCity.value = "Seçiniz";
        cities.add(CityModel(id: "", name: "Seçiniz"));
        for (var city in resp.data) {
          cities.add(CityModel.fromJson(city));
        }
        await getDistricts(cityId: cityId ?? cities[0].id);
      });
    } catch (e) {
      print("getCities error : $e");
    }
  }

// GET DISTRICTS
  Future<void> getDistricts({String? cityId, String? districtId}) async {
    final DistrictApi districtApi = DistrictApi();
    final DistrictRequestModel districtRequestModel = DistrictRequestModel(
        cityId: cityId ?? "1", secretKey: dotenv.env["SECRET_KEY"].toString());
    try {
      await districtApi
          .getDistricts(data: districtRequestModel.toJson())
          .then((resp) async {
        districts.clear();
        if (resp.data.isEmpty) {
          selectedDistrict.value = "";
          return;
        }
        // selectedDistrict.value = resp.data[0]["name"];
        selectedDistrict.value = "Seçiniz";
        districts.add(DistrictModel(id: "", name: "Seçiniz"));
        for (var district in resp.data) {
          districts.add(DistrictModel.fromJson(district));
        }
        await getNeighborhood(districtId: districtId ?? districts[0].id);
      });
    } catch (e) {
      print("getDistricts error : $e");
    }
  }

// GET NEIGHBORHOODS
  Future<void> getNeighborhood({String? districtId}) async {
    final NeighborhoodApi neighborhoodApi = NeighborhoodApi();
    final NeighborhoodRequestModel neighborhoodRequestModel =
        NeighborhoodRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      distinctId: districtId ?? "",
    );

    try {
      await neighborhoodApi
          .getNeighborhood(data: neighborhoodRequestModel.toJson())
          .then((resp) {
        neighborhoods.clear();
        if (resp.data.isEmpty) {
          selectedNeighborhood.value = "";
          return;
        }
        // selectedNeighborhood.value = resp.data[0]["name"];
        selectedNeighborhood.value = "Seçiniz";
        neighborhoods.add(NeighborhoodResponseModel(
            id: "", name: "Seçiniz", semtId: "", semtName: ""));
        for (var neighborhood in resp.data) {
          neighborhoods.add(NeighborhoodResponseModel.fromJson(neighborhood));
        }
      });
    } catch (e) {
      print("getNeighborhood error : $e");
    }
  }

// HARİTADAN KONUM SEÇ
  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    Position? position;
    if (permission == LocationPermission.denied) {
      Get.dialog(
        CustomDialogWithIcon(
          image: Icon(
            Icons.location_on,
            size: 8.w,
            color: AppColors.ASHENVALE_NIGHTS,
          ),
          title: "Konumunuzu bulabilmek için izin vermeniz gerekiyor.",
          subtitle: "Uygulamanın Konum servislerine izin vermek ister misiniz?",
          firstButtonText: "Hayır, iptal et",
          secondButtonText: "Evet, onayla",
          firstOnTap: () => Get.back(),
          secondOnTap: () async {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              // Kullanıcı izin vermedi
              return;
            }
            position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
            );
          },
        ),
      );
    }

    if (permission == LocationPermission.deniedForever) {
      // Kullanıcı kalıcı olarak izin vermedi
      return null;
    }
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    if (position == null) {
      return null;
    }
    return position;
  }

// DOPİNG FİYATINA ETKİ EDECEK FİYATI APİYE GÖNDER
  Future<void> getDopingFilter() async {
    isStepLoading.toggle();
    final CreateAdsFilterApi createAdsFilterApi = CreateAdsFilterApi();
    final CreateAdsFilterRequestModel createAdsFilterRequestModel =
        CreateAdsFilterRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      category1: parameters["categoriesIds"].split(",")[0],
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1]
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2]
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3]
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4]
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5]
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6]
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7]
          : "",
      fiyat: allValues[
              allFilters.indexWhere((p0) => p0["filterParamName"] == "fiyat_1")]
          .text,
    );
    try {
      await createAdsFilterApi
          .getAdsFilter(data: createAdsFilterRequestModel.toJson())
          .then((resp) {
        filterItems.clear();
        filterItems
            .add(CreateAdsCategoryFilterResponseModel.fromJson(resp.data));
        dopingFilters.clear();
        for (var doping in resp.data["dopings"]) {
          dopingFilters.add(Doping.fromJson(doping));
        }
        allValues.removeRange(
            allValues.length - dopingFilters.length, allValues.length);
        for (var j = 0; j < dopingFilters.length; j++) {
          dopingFilters[j].filterChoises.insert(0, "Yok");
          dopingFilters[j].fieldsValues.insert(0, "Yok");
          allValues.add(dopingFilters[j].fieldsValues[0]);
        }
      });
    } catch (e) {
      isStepLoading.toggle();
      print("getAdsFilter error: $e");
    } finally {
      isStepLoading.toggle();
    }
  }

// BÜTÜN FİLTRELERİ GETİR
  Future<void> getAdsFilter() async {
    isLoading.toggle();
    final CreateAdsFilterApi createAdsFilterApi = CreateAdsFilterApi();
    final CreateAdsFilterRequestModel createAdsFilterRequestModel =
        CreateAdsFilterRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      category1: parameters["categoriesIds"].split(",")[0],
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1]
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2]
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3]
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4]
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5]
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6]
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7]
          : "",
      fiyat: filterValues["fiyat_1"].toString(),
    );
    try {
      await createAdsFilterApi
          .getAdsFilter(data: createAdsFilterRequestModel.toJson())
          .then((resp) {
        filterItems
            .add(CreateAdsCategoryFilterResponseModel.fromJson(resp.data));
        allFilters.addAll(resp.data["staticFilters"]);
        allFilters.addAll(resp.data["dinamicFilters"]);
        for (var doping in resp.data["dopings"]) {
          dopingFilters.add(Doping.fromJson(doping));
        }
        for (var i = 0; i < allFilters.length; i++) {
          if (allFilters[i]["filterType"] == "checkbox") {
            for (var j = 0;
                j < allFilters[i]["filterChoises"].split("||").length;
                j++) {
              if (allValues.length == i) {
                allValues.add("false-");
              } else if (allFilters[i]["filterChoises"].split("||").length ==
                  j + 1) {
                allValues[i] += "false";
              } else {
                allValues[i] += "false-";
              }
            }
          } else if (allFilters[i]["filterType"] == "text") {
            allValues.add(TextEditingController());
          } else {
            allValues.add(allFilters[i]["filterChoises"].split("||")[0]);
          }
          filterValues[allFilters[i]['filterParamName']] = "";
        }
        for (var j = 0; j < dopingFilters.length; j++) {
          dopingFilters[j].filterChoises.insert(0, "Yok");
          dopingFilters[j].fieldsValues.insert(0, "Yok");
          allValues.add(dopingFilters[j].fieldsValues[0]);
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("getAdsFilter error: $e");
    } finally {
      isLoading.toggle();
    }
  }

// FOTOĞRAF YÜKLE
  Future<void> getImage() async {
    if (imageList.length > 30) {
      SnackbarType.error.CustomSnackbar(
          title: AppStrings.error,
          message: "En fazla 30 fotoğraf yükleyebilirsiniz");
      await Future.delayed(const Duration(seconds: 2), () => Get.back());
      return;
    }
    picker
        .pickMultiImage(
      imageQuality: 40,
      maxWidth: 1920,
      maxHeight: 1080,
    )
        .then(
      (value) async {
        if (value.isEmpty) return;
        for (var item in value) {
          if (imageList.length < 30) {
            imageList.add(File(item.path));
            imageLoadingState.add(false.obs);
            // resimin durumuna göre loading state ekle
            imageLoadingState[imageList.length - 1].value = true;
          } else {
            SnackbarType.error.CustomSnackbar(
                title: AppStrings.error,
                message: "En fazla 30 fotoğraf yükleyebilirsiniz");
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
            return;
          }
        }
        Get.dialog(
          CustomDialogWithIcon(
            image: Icon(
              Icons.warning_amber,
              size: 8.w,
              color: AppColors.ASHENVALE_NIGHTS,
            ),
            title: "Vitrin Fotoğrafı Bilgilendirme",
            subtitle: "Lütfen Vitrin Fotoğrafını seçmeyi unutmayın!",
            firstButtonText: "Tamam",
            secondButtonText: "",
            firstOnTap: () => Get.back(),
          ),
        );
      },
    );
  }

// VİDEO YÜKLE
  Future<void> uploadVideo() async {
    await picker.pickVideo(source: ImageSource.gallery).then((value) async {
      if (value == null) return;
      if (value.path.contains(".mp4") || value.path.contains(".MOV")) {
        video.value = File(value.path);
        videoPlayerController = VideoPlayerController.file(File(value.path));
        await videoPlayerController.initialize();
        hasVideo.toggle();
      } else {
        SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: "Lütfen .mp4 uzantılı video seçiniz");
        await Future.delayed(const Duration(seconds: 2), () => Get.back());
      }
    });
  }

// FOTOĞRAF ÇEK
  Future<void> takePhoto() async {
    if (imageList.length >= 30) {
      SnackbarType.error.CustomSnackbar(
          title: AppStrings.error,
          message: "En fazla 30 fotoğraf yükleyebilirsiniz");
      await Future.delayed(const Duration(seconds: 2), () => Get.back());
      return;
    }
    await picker
        .pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
      maxWidth: 1920,
      maxHeight: 1080,
    )
        .then((value) async {
      if (value == null) return;
      if (imageList.length < 30) {
        imageList.add(File(value.path));
        imageLoadingState.add(false.obs);
        imageLoadingState[imageList.length - 1].value = true;
      } else {
        SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: "En fazla 30 fotoğraf yükleyebilirsiniz");
        await Future.delayed(const Duration(seconds: 2), () => Get.back());
      }
    });
  }

// TEMEL BİLGİLERİ APİYE GÖNDER
  Future<void> handleDefaultInfos() async {
    isStepLoading.toggle();
    for (int i = 0; i < allFilters.length; i++) {
      if (allFilters[i]["filterParamName"] != null) {
        if (allFilters[i]["filterType"] == "text") {
          if (allValues[i].runtimeType == TextEditingController) {
            filterValues["${allFilters[i]["filterParamName"]}"] =
                allValues[i].text;
          }
        } else if (allFilters[i]["filterType"] == "select") {
          final choices = allFilters[i]["filterChoises"].split("||");
          final selectedValue = allValues[i];
          final selectedIndex = choices.indexOf(selectedValue);
          if (selectedIndex != -1) {
            filterValues[allFilters[i]["filterParamName"]] =
                selectedIndex.toString();
          } else {
            // Seçilen değer bulunamadıysa boş dönecek.
            filterValues[allFilters[i]["filterParamName"]] = "";
          }
        } else if (allFilters[i]["filterType"] == "checkbox") {
          List<String> selectedValues = allValues[i].split('-');
          String paramName = allFilters[i]["filterParamName"];
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

    final DefaultInfosRequestModel defaultInfosRequestModel =
        DefaultInfosRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      category1: parameters["categoriesIds"].split(",")[0].toString(),
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1].toString()
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2].toString()
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3].toString()
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4].toString()
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5].toString()
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6].toString()
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7].toString()
          : "",
      asama: "temelBilgiler",
      baslik: filterValues[
              allFilters.indexWhere((p0) => p0["filterParamName"] == "baslik")]
          .toString(),
      aciklama: filterValues[allFilters
              .indexWhere((p0) => p0["filterParamName"] == "aciklama")]
          .toString(),
      hidePrice: filterItems[0].priceShow.hidePrice.toString(),
      hidePenny: filterItems[0].priceShow.hidePenny.toString(),
      fiyat1: filterValues["fiyat_1"].toString(),
      sure: "1m",
      kurallar: parameters["isEdit"] == "1"
          ? "on"
          : isRuleAccepted.value
              ? "on"
              : "off",
    );

    final Map<String, dynamic> mergedFilters =
        defaultInfosRequestModel.toJson();

    mergedFilters.addAll(filterValues);
    mergedFilters["sure"] = "1m";
    dio.FormData formData = dio.FormData.fromMap(mergedFilters);
    final CreateAdsSaveApi createAdsSaveApi = CreateAdsSaveApi();

    try {
      await createAdsSaveApi.createAdsSave(data: formData).then((resp) async {
        if (resp.data["status"] == "success") {
          if (currentLocation == const LatLng(0, 0)) {
            try {
              final permission = await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                await Geolocator.requestPermission();
              }
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              currentLocation = LatLng(position.latitude, position.longitude);
            } catch (e) {
              print("getCurrentPosition error : $e");
            }
          }

          pageController.jumpToPage(2);
          SnackbarType.success.CustomSnackbar(
            title: AppStrings.success,
            message: resp.data["message"],
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        } else {
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: resp.data["message"],
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
        print("TEMEL BİLGİLER SONUÇ:${resp.data}");
      });
    } catch (e) {
      isStepLoading.toggle();
      print("default infos error : $e");
    } finally {
      isStepLoading.toggle();
    }
  }

// ADRES BİLGİLERİNİ APİYE GÖNDER
  Future<void> handleAddressInfos(BuildContext context) async {
    isStepLoading.toggle();
    final AddressInfosRequestModel addressInfosRequestModel =
        AddressInfosRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      category1: parameters["categoriesIds"].split(",")[0].toString(),
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1].toString()
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2].toString()
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3].toString()
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4].toString()
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5].toString()
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6].toString()
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7].toString()
          : "",
      asama: "adresBilgileri",
      ulke: countries
          .where((p0) => p0.name == selectedCountry.value)
          .toList()[0]
          .code,
      il: cities.where((p0) => p0.name == selectedCity.value).toList()[0].id,
      ilce: selectedDistrict.value.isEmpty
          ? ""
          : districts
              .where((p0) => p0.name == selectedDistrict.value)
              .toList()[0]
              .id,
      semt: "",
      mahalle: selectedNeighborhood.value.isEmpty
          ? ""
          : neighborhoods
              .where((p0) => p0.name == selectedNeighborhood.value)
              .toList()[0]
              .id,
      maps: currentLocation != const LatLng(0, 0)
          ? "${currentLocation.latitude},${currentLocation.longitude}"
          : "",
    );
    dio.FormData formData =
        dio.FormData.fromMap(addressInfosRequestModel.toJson());
    final CreateAdsSaveApi createAdsSaveApi = CreateAdsSaveApi();
    try {
      await createAdsSaveApi.createAdsSave(data: formData).then((resp) async {
        if (resp.data["status"] == "success") {
          previewImageSliderCurrentIndex.value = 0;
          selectedTab.value = 0;
          await getPreviewInfos();
          watermark.addCustomWatermark(
            context,
            const Watermark(rowCount: 2, columnCount: 3, text: "ÖNİZLEME"),
          );
          pageController.jumpToPage(3);
          SnackbarType.success.CustomSnackbar(
            title: AppStrings.success,
            message: resp.data["message"],
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        } else {
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: resp.data["message"],
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
        print("ADRES BİLGİLERİ SONUÇ:${resp.data}");
      });
    } catch (e) {
      isStepLoading.toggle();
      print("address infos error : $e");
    } finally {
      isStepLoading.toggle();
    }
  }

// İLAN ÖNİZLEME BİLGİLERİNİ GETİR
  Future<void> getPreviewInfos() async {
    isStepLoading.toggle();
    final PreviewInfoRequestModel previewInfosRequestModel =
        PreviewInfoRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      adId: parameters["isEdit"] == "1" ? parameters["adId"] : "",
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      category1: parameters["categoriesIds"].split(",")[0].toString(),
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1].toString()
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2].toString()
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3].toString()
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4].toString()
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5].toString()
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6].toString()
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7].toString()
          : "",
      asama: "onIzleme",
      baslik: filterValues["baslik"].toString(),
      aciklama: filterValues["aciklama"].toString(),
      hidePrice: filterItems[0].priceShow.hidePrice.toString(),
      hidePenny: filterItems[0].priceShow.hidePenny.toString(),
      fiyat1: filterValues["fiyat_1"].toString(),
      sure: "1m",
      kurallar: parameters["isEdit"] == "1"
          ? "on"
          : isRuleAccepted.value
              ? "on"
              : "off",
      ulke: countries
          .where((p0) => p0.name == selectedCountry.value)
          .toList()[0]
          .code,
      il: cities.where((p0) => p0.name == selectedCity.value).toList()[0].id,
      ilce: selectedDistrict.value.isEmpty
          ? ""
          : districts
              .where((p0) => p0.name == selectedDistrict.value)
              .toList()[0]
              .id,
      semt: "",
      mahalle: selectedNeighborhood.value.isEmpty
          ? ""
          : neighborhoods
              .where((p0) => p0.name == selectedNeighborhood.value)
              .toList()[0]
              .id,
      maps: currentLocation != const LatLng(0, 0)
          ? "${currentLocation.latitude},${currentLocation.longitude}"
          : "",
      resimKod: imageCode,
    );
    final Map<String, dynamic> mergedFilters =
        previewInfosRequestModel.toJson();
    mergedFilters.addAll(filterValues);
    mergedFilters["sure"] = "1m";
    dio.FormData formData = dio.FormData.fromMap(mergedFilters);
    if (parameters["isEdit"] == "1") {
      final UpdateAdsApi updateAdsApi = UpdateAdsApi();
      try {
        await updateAdsApi.updateAds(data: formData).then((resp) async {
          if (resp.data == null) return;
          previewInfos.clear();
          previewInfos.add(PreviewInfoResponseModel.fromJson(resp.data));
        });
      } catch (e) {
        isStepLoading.toggle();
        print("updateAds error : $e");
      } finally {
        isStepLoading.toggle();
      }
    } else {
      final CreateAdsSaveApi createAdsSaveApi = CreateAdsSaveApi();
      try {
        await createAdsSaveApi.createAdsSave(data: formData).then((resp) {
          if (resp.data == null) return;
          previewInfos.clear();
          previewInfos.add(PreviewInfoResponseModel.fromJson(resp.data));
        });
      } catch (e) {
        print("preview infos error : $e");
      } finally {
        isStepLoading.toggle();
      }
    }
  }

// KONUM BİLGİSİNE GÖRE İL,İLÇE,MAHALLE GETİR
  Future<void> getAddressInfosFromMarker(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
        localeIdentifier: "tr_TR",
      );
      Placemark place = placemarks.first;
      if (placemarks.isNotEmpty) {
        if (place.administrativeArea != "Konya" && allValues[1] == "Pasif") {
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: "Sadece Konya ilinde ilan verebilirsiniz",
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          currentLocation = const LatLng(0, 0);
          markers.clear();
          return;
        }
        selectedCity.value = place.administrativeArea ?? "";
        await getDistricts(
          cityId: cities
              .where((p0) => p0.name == selectedCity.value)
              .toList()[0]
              .id,
        );
        selectedDistrict.value = place.subAdministrativeArea ?? "";
        await getNeighborhood(
          districtId: districts
              .where((p0) => p0.name == selectedDistrict.value)
              .toList()[0]
              .id,
        );
      }
    } catch (e) {
      print("getAddressInfosFromMarker error : $e");
    }
  }

// FOTOĞRAF VE VİDEOYU APİYE GÖNDER
  Future<void> uploadPhotoAndVideo() async {
    isPhotoAndVideoLoading.toggle();
    final PhotoAndVideoInfosRequestModel photoAndVideoInfosRequestModel =
        PhotoAndVideoInfosRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      adId: parameters["isEdit"] == "1" ? parameters["adId"] : "",
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      category1: parameters["categoriesIds"].split(",")[0].toString(),
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1].toString()
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2].toString()
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3].toString()
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4].toString()
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5].toString()
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6].toString()
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7].toString()
          : "",
      asama: "fotografVideo",
      resim_kod: imageCode,
    );
    dio.FormData formData =
        dio.FormData.fromMap(photoAndVideoInfosRequestModel.toJson());
    for (int i = 0; i < imageList.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      formData.files.add(
        MapEntry(
          "images[]",
          await dio.MultipartFile.fromFile(
            imageList[i].path,
            filename: imageList[i].path,
          ),
        ),
      );
    }
    if (video.value.path.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "video",
          await dio.MultipartFile.fromFile(
            video.value.path,
            filename: video.value.path,
          ),
        ),
      );
    }

    if (parameters["isEdit"] == "1") {
      final UpdateAdsApi updateAdsApi = UpdateAdsApi();
      try {
        await updateAdsApi.updateAds(data: formData).then((resp) async {
          print("FOTOĞRAF VE VİDEO GÜNCELLEME SONUÇ:${resp.data}");
          if (resp.data["status"] == "success") {
            SnackbarType.success.CustomSnackbar(
              title: AppStrings.success,
              message: resp.data["message"],
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
          } else {
            SnackbarType.error.CustomSnackbar(
              title: AppStrings.error,
              message: resp.data["message"],
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
          }
        });
      } catch (e) {
        isPhotoAndVideoLoading.toggle();
        print("updateAds error : $e");
      } finally {
        isPhotoAndVideoLoading.toggle();
      }
    } else {
      final CreateAdsSaveApi createAdsSaveApi = CreateAdsSaveApi();
      try {
        await createAdsSaveApi.createAdsSave(data: formData).then((resp) async {
          print("FOTOĞRAF VE VİDEO SONUÇ:${resp.data}");
          if (resp.data["status"] == "success") {
            SnackbarType.success.CustomSnackbar(
              title: AppStrings.success,
              message: resp.data["message"],
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
          } else {
            SnackbarType.error.CustomSnackbar(
              title: AppStrings.error,
              message: resp.data["message"],
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
          }
        });
      } catch (e) {
        isPhotoAndVideoLoading.toggle();
        print("photo/video error : $e");
      } finally {
        isPhotoAndVideoLoading.toggle();
      }
    }
  }

// DOPİNG BİLGİSİNİ APİYE GÖNDER
  Future<void> handleDopingInfos() async {
    isStepLoading.toggle();
    final DopingInfosRequestModel dopingInfosRequestModel =
        DopingInfosRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      category1: parameters["categoriesIds"].split(",")[0].toString(),
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1].toString()
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2].toString()
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3].toString()
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4].toString()
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5].toString()
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6].toString()
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7].toString()
          : "",
      asama: "doping",
      doping1: allValues[allValues.length - 8] == "Yok"
          ? ""
          : allValues[allValues.length - 8].split("||")[1],
      doping2: allValues[allValues.length - 7] == "Yok"
          ? ""
          : allValues[allValues.length - 7].split("||")[1],
      doping3: allValues[allValues.length - 6] == "Yok"
          ? ""
          : allValues[allValues.length - 6].split("||")[1],
      doping4: allValues[allValues.length - 5] == "Yok"
          ? ""
          : allValues[allValues.length - 5].split("||")[1],
      doping5: allValues[allValues.length - 4] == "Yok"
          ? ""
          : allValues[allValues.length - 4].split("||")[1],
      doping6: allValues[allValues.length - 3] == "Yok"
          ? ""
          : allValues[allValues.length - 3].split("||")[1],
      doping7: allValues[allValues.length - 2] == "Yok"
          ? ""
          : allValues[allValues.length - 2].split("||")[1],
      doping14: allValues[allValues.length - 1] == "Yok"
          ? ""
          : allValues[allValues.length - 1].split("||")[1],
      fiyat: filterValues["fiyat_1"].toString(),
    );
    dio.FormData formData =
        dio.FormData.fromMap(dopingInfosRequestModel.toJson());
    final CreateAdsSaveApi createAdsSaveApi = CreateAdsSaveApi();
    try {
      await createAdsSaveApi.createAdsSave(data: formData).then((resp) async {
        print("DOPİNG SONUÇ:${resp.data}");
        if (resp.data["status"] == "hediyeDoping") {
          await handleAdsPublish(
            resp.data["Transactions"],
            resp.data["Payment"],
            myAdsType: MyAdsType.ACTIVE,
          );
          return;
        }
        if (resp.data["status"] == "warning") {
          Get.dialog(
            CustomDialogWithIcon(
              image: Images.doping.pngWithScale,
              title: "İlanınızda Doping Eksik!\n",
              subtitle: resp.data["message"],
              firstButtonText: "Yayınla",
              firstOnTap: () async {
                Get.close(1);
                await handleAdsPublish({}, "");
              },
              secondButtonText: "Dopingle",
              secondOnTap: () => Get.back(),
            ),
          );
          return;
        }
        selectedDopingsSet.clear();
        selectedDopings.clear();
        selectedDopingsSet.add(SelectedDopingsModel.fromJson(resp.data));
        selectedDopingsSet.first.selectedDopings.map((key, value) {
          selectedDopings.add(value);
          return MapEntry(key, value);
        });
        Get.dialog(
          Center(
            child: Container(
              width: 75.w,
              child: Material(
                borderRadius: AppBorderRadius.inputRadius,
                color: AppColors.WHITE,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            selectedDopings[index].dopingIsim,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          trailing: Text(
                            "₺${selectedDopings[index].ucret}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.FENNEL_FIESTA,
                                ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          CustomSeperatorWidget(
                              color: AppColors.SHY_MOMENT.withOpacity(.1)),
                      itemCount: selectedDopings.length,
                    ),
                    CustomSeperatorWidget(
                      color: AppColors.SHY_MOMENT.withOpacity(.1),
                    ),
                    ListTile(
                      title: Text(
                        "Toplam: ",
                        style: Theme.of(Get.context!).textTheme.labelSmall,
                      ),
                      trailing: Text(
                        "₺${selectedDopingsSet.first.totalPrice}",
                        style: Theme.of(Get.context!)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: AppColors.FENNEL_FIESTA,
                            ),
                      ),
                    ),
                    Direction.vertical.spacer(2),
                    CustomDialogButton(
                      onTap: () async {
                        await handlePayment();
                      },
                      color: AppColors.ASHENVALE_NIGHTS,
                      text: "Doping al",
                      textColor: AppColors.WHITE,
                    ),
                    Direction.vertical.spacer(2),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    } catch (e) {
      isStepLoading.toggle();
      print("doping error : $e");
    } finally {
      isStepLoading.toggle();
    }
  }

// ÖDEME SİSTEMİNE GİT
  Future<void> handlePayment() async {
    final PaymentTrackApi paymentTrackApi = PaymentTrackApi();
    final DopingInfosRequestModel dopingInfosRequestModel =
        DopingInfosRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      category1: parameters["categoriesIds"].split(",")[0].toString(),
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1].toString()
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2].toString()
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3].toString()
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4].toString()
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5].toString()
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6].toString()
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7].toString()
          : "",
      asama: "doping",
      doping1: allValues[allValues.length - 8] == "Yok"
          ? ""
          : allValues[allValues.length - 8].split("||")[1],
      doping2: allValues[allValues.length - 7] == "Yok"
          ? ""
          : allValues[allValues.length - 7].split("||")[1],
      doping3: allValues[allValues.length - 6] == "Yok"
          ? ""
          : allValues[allValues.length - 6].split("||")[1],
      doping4: allValues[allValues.length - 5] == "Yok"
          ? ""
          : allValues[allValues.length - 5].split("||")[1],
      doping5: allValues[allValues.length - 4] == "Yok"
          ? ""
          : allValues[allValues.length - 4].split("||")[1],
      doping6: allValues[allValues.length - 3] == "Yok"
          ? ""
          : allValues[allValues.length - 3].split("||")[1],
      doping7: allValues[allValues.length - 2] == "Yok"
          ? ""
          : allValues[allValues.length - 2].split("||")[1],
      doping14: allValues[allValues.length - 1] == "Yok"
          ? ""
          : allValues[allValues.length - 1].split("||")[1],
      fiyat: filterValues["fiyat_1"].toString(),
    );
    try {
      await paymentTrackApi
          .handlePayment(data: dopingInfosRequestModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          Get.dialog(
            Center(
              child: Container(
                width: 100.w,
                child: Material(
                  color: AppColors.WHITE,
                  child: Container(
                    child: WebViewWidget(
                      controller: webViewController
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setBackgroundColor(const Color(0x00000000))
                        ..setNavigationDelegate(
                          NavigationDelegate(
                            onNavigationRequest:
                                (NavigationRequest request) async {
                              if (request.url.startsWith(
                                  'https://www.paytr.com/odeme/guvenli')) {
                                return NavigationDecision.navigate;
                              } else if (request.url.contains("iptal")) {
                                Get.back();
                                SnackbarType.error.CustomSnackbar(
                                  title: AppStrings.error,
                                  message: "Ödeme iptal edildi.",
                                );
                                await Future.delayed(const Duration(seconds: 2),
                                    () => Get.back());
                              } else if (request.url.contains("onay")) {
                              } else if (request.url.contains("ilkbizde")) {
                                try {
                                  await checkPayment(
                                    transactionId:
                                        int.parse(resp.data["TransactionId"]),
                                    transactions: resp.data["Transactions"],
                                  );
                                } catch (e) {
                                  SnackbarType.error.CustomSnackbar(
                                    title: AppStrings.error,
                                    message: "İlan oluşturma başarısız oldu.",
                                  );
                                  await Future.delayed(
                                    const Duration(seconds: 2),
                                    () => Get.back(),
                                  );
                                  Get.close(1);
                                }
                              }
                              return NavigationDecision.navigate;
                            },
                          ),
                        )
                        ..loadHtmlString("""
                  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                  ${resp.data["PaymentForm"]},
                  """),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: resp.data["message"],
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      print("payment error : $e");
    }
  }

// ÖDEME KONTROLÜ
  Future<void> checkPayment(
      {required int transactionId,
      required Map<String, dynamic> transactions}) async {
    final PaymentCheckApi paymentCheckApi = PaymentCheckApi();
    final Map<String, dynamic> checkPaymentRequest = {
      "TransactionId": transactionId,
    };
    try {
      await paymentCheckApi
          .checkPayment(data: checkPaymentRequest)
          .then((resp) async {
        print("Kontrol Sonucu: ${resp.data}");
        if (resp.data["status"] == "success") {
          Get.close(2);
          await handleAdsPublish(
            transactions,
            "success",
            myAdsType: MyAdsType.ACTIVE,
          );
        } else {
          Get.back();
          SnackbarType.error.CustomSnackbar(
            title: AppStrings.error,
            message: "Ödeme başarısız oldu.",
          );
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      print("Kontrol Hatası: $e");
    }
  }

// VİDEO SİL
  Future<void> handleDeleteAdsVideo() async {
    final DeleteAdsVideoRequestModel deleteAdsVideoRequestModel =
        DeleteAdsVideoRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      adId: parameters["adId"],
    );
    final DeleteAdsVideoApi deleteAdsVideoApi = DeleteAdsVideoApi();

    try {
      await deleteAdsVideoApi.handleDeleteAdsVideo(
        data: deleteAdsVideoRequestModel.toJson(),
      );
    } catch (e) {
      print("handleDeleteAdsVideo error : $e");
    }
  }

// İLANI OLUŞTUR
  Future<void> handleAdsPublish(
    Map<String, dynamic> transactions,
    String payment, {
    MyAdsType myAdsType = MyAdsType.WAITING,
  }) async {
    isStepLoading.toggle();
    final AdsPublishRequestModel adsPublishRequestModel =
        AdsPublishRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid").toString(),
      userEmail: storage.read("uEmail").toString(),
      userPassword: storage.read("uPassword").toString(),
      category1: parameters["categoriesIds"].split(",")[0].toString(),
      category2: parameters["categoriesIds"].split(",").length >= 2
          ? parameters["categoriesIds"].split(",")[1].toString()
          : "",
      category3: parameters["categoriesIds"].split(",").length >= 3
          ? parameters["categoriesIds"].split(",")[2].toString()
          : "",
      category4: parameters["categoriesIds"].split(",").length >= 4
          ? parameters["categoriesIds"].split(",")[3].toString()
          : "",
      category5: parameters["categoriesIds"].split(",").length >= 5
          ? parameters["categoriesIds"].split(",")[4].toString()
          : "",
      category6: parameters["categoriesIds"].split(",").length >= 6
          ? parameters["categoriesIds"].split(",")[5].toString()
          : "",
      category7: parameters["categoriesIds"].split(",").length >= 7
          ? parameters["categoriesIds"].split(",")[6].toString()
          : "",
      category8: parameters["categoriesIds"].split(",").length >= 8
          ? parameters["categoriesIds"].split(",")[7].toString()
          : "",
      asama: "ilanOlustur",
      baslik: filterValues["baslik"].toString(),
      aciklama: filterValues["aciklama"].toString(),
      hidePrice: filterItems[0].priceShow.hidePrice.toString(),
      hidePenny: filterItems[0].priceShow.hidePenny.toString(),
      fiyat1: filterValues["fiyat_1"].toString(),
      sure: "1m",
      kurallar: parameters["isEdit"] == "1"
          ? "on"
          : isRuleAccepted.value
              ? "on"
              : "off",
      ulke: countries
          .where((p0) => p0.name == selectedCountry.value)
          .toList()[0]
          .code,
      il: cities.where((p0) => p0.name == selectedCity.value).toList()[0].id,
      ilce: selectedDistrict.value.isEmpty
          ? ""
          : districts
              .where((p0) => p0.name == selectedDistrict.value)
              .toList()[0]
              .id,
      semt: "",
      mahalle: selectedNeighborhood.value.isEmpty
          ? ""
          : neighborhoods
              .where((p0) => p0.name == selectedNeighborhood.value)
              .toList()[0]
              .id,
      maps: currentLocation != const LatLng(0, 0)
          ? "${currentLocation.latitude},${currentLocation.longitude}"
          : "",
      doping1: allValues[allValues.length - 8] == "Yok"
          ? ""
          : allValues[allValues.length - 8].split("||")[1],
      doping2: allValues[allValues.length - 7] == "Yok"
          ? ""
          : allValues[allValues.length - 7].split("||")[1],
      doping3: allValues[allValues.length - 6] == "Yok"
          ? ""
          : allValues[allValues.length - 6].split("||")[1],
      doping4: allValues[allValues.length - 5] == "Yok"
          ? ""
          : allValues[allValues.length - 5].split("||")[1],
      doping5: allValues[allValues.length - 4] == "Yok"
          ? ""
          : allValues[allValues.length - 4].split("||")[1],
      doping6: allValues[allValues.length - 3] == "Yok"
          ? ""
          : allValues[allValues.length - 3].split("||")[1],
      doping7: allValues[allValues.length - 2] == "Yok"
          ? ""
          : allValues[allValues.length - 2].split("||")[1],
      doping14: allValues[allValues.length - 1] == "Yok"
          ? ""
          : allValues[allValues.length - 1].split("||")[1],
      Transactions: json.encode(transactions),
      payment: payment,
      adId: parameters["isEdit"] == "1" ? parameters["adId"] : "",
      total: selectedDopingsSet.isEmpty
          ? "0"
          : selectedDopingsSet.first.totalPrice.toString(),
      resim_kod: imageCode,
    );
    final Map<String, dynamic> mergedFilters = adsPublishRequestModel.toJson();
    for (int i = 0; i < filterValues.length; i++) {
      if (filterValues.keys.toList()[i].contains("[]")) {
        filterValues[filterValues.keys.toList()[i]] =
            filterValues[filterValues.keys.toList()[i]]
                .toString()
                .replaceAll("-", ",");
      }
    }
    mergedFilters.addAll(filterValues);
    mergedFilters["sure"] = "1m";
    dio.FormData formData = dio.FormData.fromMap(mergedFilters);

    if (parameters["isEdit"] == "1") {
      await handleDeleteAdsVideo();
      final UpdateAdsApi updateAdsApi = UpdateAdsApi();
      try {
        await updateAdsApi.updateAds(data: formData).then((resp) async {
          print("GÜNCELLEME SONUÇ: ${resp.data.toString()}");
          if (resp.data["status"] == "success") {
            SnackbarType.success.CustomSnackbar(
              title: AppStrings.success,
              message: resp.data["message"],
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
            final MyAdsController myAdsController = Get.find<MyAdsController>();
            myAdsController.myAdsList.clear();
            myAdsController.getMyAds(myAdsType);
            Get.offNamed(Routes.MYADS, arguments: [myAdsType]);
          } else if (resp.data["status"] == "warning") {
            SnackbarType.error.CustomSnackbar(
              title: AppStrings.error,
              message: resp.data["message"],
            );
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
            print("GÜNCELLEME BAŞARISIZ: ${resp.data.toString()}");
          }
        });
      } catch (e) {
        isStepLoading.toggle();
        print("updateAds error : $e");
      } finally {
        isStepLoading.toggle();
      }
    } else {
      final CreateAdsSaveApi createAdsSaveApi = CreateAdsSaveApi();
      try {
        await createAdsSaveApi.createAdsSave(data: formData).then((resp) async {
          print("İLAN OLUŞTURMA SONUÇ: ${resp.data.toString()}");
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(const Duration(seconds: 2), () => Get.back());
          Get.offNamed(Routes.MYADS, arguments: [myAdsType]);
        });
      } catch (e) {
        isStepLoading.toggle();
        print("ads publish error : $e");
      } finally {
        isStepLoading.toggle();
      }
    }
  }
}

extension getFilterWidgetFromFilterType on FilterType {
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

  Widget getWidget(
    String title,
    AdsPublishController controller,
    BuildContext context,
    int filterItemIndex,
  ) {
    switch (this) {
      case FilterType.text:
        return controller.allFilters[filterItemIndex]["filterParamName"] ==
                    "fiyat_1" &&
                controller.filterItems[0].priceShow.hidePrice
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 13.sp),
                  ),
                  Direction.vertical.spacer(1),
                  CustomPersonalInfoInput(
                    hintText: "${title.capitalizeFirst} girin",
                    isPrice: controller.allFilters[filterItemIndex]
                            ["filterParamName"] ==
                        "fiyat_1",
                    isNumberType: controller.allFilters[filterItemIndex]
                                    ["filterParamName"] ==
                                "baslik" ||
                            controller.allFilters[filterItemIndex]
                                    ["filterParamName"] ==
                                "aciklama"
                        ? false
                        : true,
                    validator: (p0) {
                      if (controller.allFilters[filterItemIndex]
                              ["filterParamName"] ==
                          "Aidat-tl") {
                        return null;
                      } else if (p0!.isEmpty) {
                        return "Zorunlu alan";
                      } else if (p0.length < 10 &&
                          controller.allFilters[filterItemIndex]
                                  ["filterParamName"] ==
                              "aciklama") {
                        return "Bu alan en az 10 karakter olmalıdır";
                      }
                      return null;
                    },
                    maxLines: controller.allFilters[filterItemIndex]
                                ["filterParamName"] ==
                            "aciklama"
                        ? 8
                        : 1,
                    textEditingController:
                        controller.allValues[filterItemIndex],
                  ),
                ],
              );
      case FilterType.select:
        return Container(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontSize: 13.sp),
              ),
              Direction.vertical.spacer(1),
              Obx(
                () => CustomDropdownFieldWithList(
                  validator: (p0) {
                    if (p0 == null) {
                      return "Zorunlu alan";
                    }
                    return null;
                  },
                  value: controller.allValues[filterItemIndex].isNotEmpty
                      ? controller.allValues[filterItemIndex]
                      : controller.allFilters[filterItemIndex]["filterChoises"]
                          .split("||")
                          .first,
                  items: controller.allFilters[filterItemIndex]["filterChoises"]
                      .toString()
                      .replaceAll("\n", "")
                      .split("||")
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                                value: value,
                                onTap: () {
                                  controller.allValues[filterItemIndex] = value;
                                },
                                child: Text(value),
                              ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      case FilterType.checkbox:
        return Container(
          width: 100.w,
          child: Obx(
            () => ExpansionTile(
              backgroundColor: AppColors.ASHENVALE_NIGHTS.withOpacity(.1),
              iconColor: AppColors.ASHENVALE_NIGHTS,
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontSize: 13.sp),
              ),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.allFilters[filterItemIndex]
                          ["filterChoises"]
                      .split("||")
                      .length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => CheckboxListTile(
                        activeColor: AppColors.ASHENVALE_NIGHTS,
                        checkColor: AppColors.WHITE,
                        value: controller.allValues[filterItemIndex]
                                    .split("-")[index] ==
                                "true"
                            ? true
                            : false,
                        onChanged: (bool? value) async {
                          final List<String> checkboxValues =
                              controller.allValues[filterItemIndex].split("-");
                          checkboxValues.removeAt(index);
                          checkboxValues.insert(index, value.toString());
                          controller.allValues[filterItemIndex] =
                              checkboxValues.join("-");
                        },
                        title: Text(
                          controller.allFilters[filterItemIndex]
                                  ["filterChoises"]
                              .split("||")[index],
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
    }
  }
}
