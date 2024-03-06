import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/GiftAndMissionModel.dart';
import 'package:ilkbizde/data/network/api/GetGiftDopingInfosApi.dart';
import 'package:ilkbizde/modules/MyAccount/index.dart';

class MyOpportunityController extends GetxController {
  final GetStorage storage = GetStorage();

  final MyAccountController myAccountController =
      Get.find<MyAccountController>();

  final RxList<GiftDopingAndMissionModel> giftAndMissionInfos =
      <GiftDopingAndMissionModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getGiftDopingInfos();
  }

// DOPİNG VE GÖREVLER HAKKINDA BİLGİLERİ GETİR
  Future<void> getGiftDopingInfos() async {
    isLoading.toggle();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      userId: storage.read("uid"),
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );
    final GetGiftDopingInfosApi getGiftDopingInfosApi = GetGiftDopingInfosApi();
    try {
      await getGiftDopingInfosApi
          .getGiftDopingInfosApi(
        data: generalRequestModel.toJson(),
      )
          .then((resp) {
        if (resp.data == null) return;
        giftAndMissionInfos.add(GiftDopingAndMissionModel.fromJson(resp.data));
      });
    } catch (e) {
      isLoading.toggle();
      print("Doping ve görevler hakkında bilgiler getirilemedi: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
