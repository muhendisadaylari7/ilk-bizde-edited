import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/AddClientRequestModel.dart';
import 'package:ilkbizde/data/model/AllAdsInMarketRequestModel.dart';
import 'package:ilkbizde/data/model/AllAdsInMarketResponseModel.dart';
import 'package:ilkbizde/data/model/CounselorResponseModel.dart';
import 'package:ilkbizde/data/model/DeleteClientRequestModel.dart';
import 'package:ilkbizde/data/model/EditMarketRequestModel.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/MarktInfosResponseModel.dart';
import 'package:ilkbizde/data/network/api/AddClientApi.dart';
import 'package:ilkbizde/data/network/api/AllAdsInMarketApi.dart';
import 'package:ilkbizde/data/network/api/DeleteClientApi.dart';
import 'package:ilkbizde/data/network/api/EditMarketApi.dart';
import 'package:ilkbizde/data/network/api/GetCounselorApi.dart';
import 'package:ilkbizde/data/network/api/MarketInfosApi.dart';
import 'package:ilkbizde/modules/MyStoreInfo/MyStoreInfoController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:ilkbizde/shared/extensions/ImageUrlType.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart';

class MyStoreDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GetStorage storage = GetStorage();

  late final TabController tabController;

  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "adsIdFormKey");
  final GlobalKey<FormState> clientEmailFormKey =
      GlobalKey<FormState>(debugLabel: "clientEmailFormKey");

  final TextEditingController clientEmailController = TextEditingController();

  final MyStoreInfoController myStoreController =
      Get.put<MyStoreInfoController>(MyStoreInfoController());

  final RxInt currentTabIndex = 0.obs;

  final RxBool isLoading = false.obs;
  final RxBool counselorIsLoading = false.obs;
  final RxBool allAdsIsLoading = false.obs;
  final RxBool deleteClientIsLoading = false.obs;

  final RxList<MarketInfosResponseModel> infos =
      <MarketInfosResponseModel>[].obs;
  final RxList<CounselorResponseModel> allCounselor =
      <CounselorResponseModel>[].obs;
  final RxList<AllAdsInMarketResponseModel> allAdsInMarket =
      <AllAdsInMarketResponseModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
    await getMarketInfos();
    await getAllAdsInMarket();

    getCounselor();
    await myStoreController.getMarketCategories();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    clientEmailController.dispose();
  }

  // GÜNCEL BİLGİLERİ GETİR
  Future<void> getCurrentInfos() async {
    final List<String> _infos = [
      infos.first.magazaKullaniciAdi,
      infos.first.magazaAciklamasi,
      infos.first.magazaAdi,
    ];
    final dioPack = dio.Dio();
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    try {
      var imageUrl = ImageUrlTypeExtension.getImageType(infos.first.logo)
          .ImageUrlWithMarketApiUrl(infos.first.logo);
      // DefaultCacheManager manager = DefaultCacheManager();
      // FileInfo? fileInfo = await manager.getFileFromCache(imageUrl);

      bool isFileExists =
          await File("${appDocDirectory.path}/${infos.first.logo}").exists();
      if (!isFileExists) {
        // // Resim cache'de yok indiriliyor.
        // var imageId = await ImageDownloader.downloadImage(imageUrl);

        // if (imageId == null) return;
        // // Below is a method of obtaining saved image information.
        // var path = await ImageDownloader.findPath(imageId);

        var imageBytes = await dioPack.get(
          imageUrl,
          options: dio.Options(
            responseType: dio.ResponseType.bytes,
          ),
        );
        File("${appDocDirectory.path}/${infos.first.logo}")
            .writeAsBytes(imageBytes.data)
            .then((File image) {
          myStoreController.image.value = image;
        }).catchError((error) {
          print('Hata oluştu: $error');
        });
      } else {
        // Resim cache'den alınıyor.
        myStoreController.image.value =
            File("${appDocDirectory.path}/${infos.first.logo}");
      }
    } on PlatformException catch (error) {
      print("RESİM İNDİRME HATASI: $error");
    }
    for (var i = 0; i < myStoreController.marketInfos.length; i++) {
      if (i < _infos.length) {
        myStoreController.marketInfos[i].text = _infos[i];
      }
    }
  }

  // MAĞAZA İLANLARINI GETİR
  Future<void> getAllAdsInMarket() async {
    allAdsIsLoading.toggle();
    final AllAdsInMarketRequestModel allAdsInMarketRequestModel =
        AllAdsInMarketRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      magazaId: infos.first.id,
    );
    final AllAdsInMarketApi allAdsInMarketApi = AllAdsInMarketApi();
    try {
      await allAdsInMarketApi
          .allAdsInMarket(data: allAdsInMarketRequestModel.toJson())
          .then((resp) async {
        if (resp.data == null) return;
        allAdsInMarket.clear();
        if (resp.data.runtimeType == List) {
          for (var ads in resp.data) {
            allAdsInMarket.add(AllAdsInMarketResponseModel.fromJson(ads));
          }
        }

        print("TÜM İLANLAR: ${resp.data}");
      });
    } catch (e) {
      allAdsIsLoading.toggle();
      print("getAllAdsInMarket HATA: $e");
    } finally {
      allAdsIsLoading.toggle();
    }
  }

  // MAĞAZA BİLGİLERİNİ GETİR
  Future<void> getMarketInfos() async {
    isLoading.toggle();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );
    final MarketInfosApi marketInfosApi = MarketInfosApi();
    try {
      if (infos.isNotEmpty) infos.clear();
      await marketInfosApi
          .getMarketInfos(data: generalRequestModel.toJson())
          .then((resp) async {
        if (resp.data == null) return;
        infos.add(MarketInfosResponseModel.fromJson(resp.data));
        print("MARKET BİLGİLERİ: ${infos.first.magazaAdi}");
      });
    } catch (e) {
      isLoading.toggle();
      print("getMarketInfos HATA: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // MAĞAZA BİLGİLERİNİ GÜNCELLE
  Future<void> handleEditMarketApi() async {
    myStoreController.createStoreLoading.toggle();
    final EditMarketRequestModel editMarketRequestModel =
        EditMarketRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      kullaniciAdi: myStoreController.marketInfos[0].text,
      aciklama: myStoreController.marketInfos[1].text,
      ad: myStoreController.marketInfos[2].text,
    );
    dio.FormData formData =
        dio.FormData.fromMap(editMarketRequestModel.toJson());
    if (myStoreController.image.value.path.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "images",
          await dio.MultipartFile.fromFile(
            myStoreController.image.value.path,
            filename: myStoreController.image.value.path,
          ),
        ),
      );
    }
    final EditMarketApi editMarketApi = EditMarketApi();
    try {
      await editMarketApi
          .handleEditMarketApi(data: formData)
          .then((resp) async {
        if (resp.data == null) return;
        if (resp.data["status"] == "success") {
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
          await getMarketInfos();
          Get.close(1);
        } else {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      myStoreController.createStoreLoading.toggle();
      print("handleEditMarketApi HATA: $e");
    } finally {
      myStoreController.createStoreLoading.toggle();
    }
  }

  // DANIŞMANLARI GETİR
  Future<void> getCounselor() async {
    counselorIsLoading.toggle();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );
    final GetCounselorApi getCounselorApi = GetCounselorApi();
    try {
      await getCounselorApi
          .getCounselor(data: generalRequestModel.toJson())
          .then((resp) {
        if (resp.data == null) return;
        for (var counselor in resp.data) {
          allCounselor.add(CounselorResponseModel.fromJson(counselor));
        }
      });
    } catch (e) {
      counselorIsLoading.toggle();
      print("getCounselor HATA: $e");
    } finally {
      counselorIsLoading.toggle();
    }
  }

  // DANIŞMAN EKLE
  Future<void> handleAddClient() async {
    counselorIsLoading.toggle();
    final AddClientRequestModel addClientRequestModel = AddClientRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      email: clientEmailController.text,
    );
    final AddClientApi addClientApi = AddClientApi();
    try {
      await addClientApi
          .addClient(data: addClientRequestModel.toJson())
          .then((resp) async {
        if (resp.data == null) return;
        if (resp.data["status"] == "success") {
          allCounselor.clear();
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
          await getCounselor();
          Get.close(1);
        } else {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      counselorIsLoading.toggle();
      print("handleAddClient HATA: $e");
    } finally {
      counselorIsLoading.toggle();
    }
  }

  // DANIŞMAN SİL
  Future<void> handleDeleteClient({required String counselorId}) async {
    deleteClientIsLoading.toggle();
    final DeleteClientRequestModel deleteClientRequestModel =
        DeleteClientRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      id: counselorId,
    );
    final DeleteClientApi deleteClientApi = DeleteClientApi();
    try {
      await deleteClientApi
          .deleteClient(data: deleteClientRequestModel.toJson())
          .then(
        (resp) async {
          if (resp.data == null) return;
          if (resp.data["status"] == "success") {
            allCounselor.removeWhere((element) => element.id == counselorId);
            SnackbarType.success.CustomSnackbar(
                title: AppStrings.success, message: resp.data["message"]);
            await Future.delayed(Duration(seconds: 2), () => Get.back());
          } else {
            SnackbarType.error.CustomSnackbar(
                title: AppStrings.error, message: resp.data["message"]);
            await Future.delayed(Duration(seconds: 2), () => Get.back());
          }
        },
      );
    } catch (e) {
      deleteClientIsLoading.toggle();
      print("handleDeleteClient HATA: $e");
    } finally {
      deleteClientIsLoading.toggle();
    }
  }
}
