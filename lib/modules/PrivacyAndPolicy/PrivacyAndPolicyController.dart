import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/PrivacyAndUsageResponseModel.dart';
import 'package:ilkbizde/data/network/api/GetPrivacyAndUsageApi.dart';

class PrivacyAndPolicyController extends GetxController {
  final RxBool isLoading = false.obs;

  final RxList<PrivacyAndUsageResponseModel> privacyAndUsageList =
      <PrivacyAndUsageResponseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPrivacyAndPolicy();
  }

  // GİZLİLİK VE KULLANIM KOŞULLARINI GETİR
  Future<void> getPrivacyAndPolicy() async {
    isLoading.toggle();
    final GetPrivacyAndUsageApi _getPrivacyAndUsageApi =
        GetPrivacyAndUsageApi();
    try {
      await _getPrivacyAndUsageApi.getPrivacyAndUsageApi(data: {
        "secretKey": dotenv.env["SECRET_KEY"],
      }).then((resp) {
        if (resp.data == null) return;
        privacyAndUsageList.clear();
        for (var item in resp.data) {
          privacyAndUsageList.add(PrivacyAndUsageResponseModel.fromJson(item));
        }
      });
    } catch (e) {
      print("getPrivacyAndPolicy error: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
