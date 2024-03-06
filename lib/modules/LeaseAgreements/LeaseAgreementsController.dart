// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/LeaseAgreementsModel.dart';
import 'package:ilkbizde/data/network/api/AllLeaseAgreementsApi.dart';

class LeaseAgreementsController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;

  final RxList<LeaseAgreementsModel> allLeaseAgreements =
      <LeaseAgreementsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllLeaseAgreements();
  }

  // KİRA SÖZLEŞMELERİNİ GETİR
  Future<void> getAllLeaseAgreements() async {
    isLoading.toggle();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );
    final AllLeaseAgreementsApi allLeaseAgreementsApi = AllLeaseAgreementsApi();

    try {
      await allLeaseAgreementsApi
          .getAllLeaseAgreements(data: generalRequestModel.toJson())
          .then((resp) {
        if (resp.data == null) return;
        allLeaseAgreements.clear();
        for (var leaseAgreements in resp.data) {
          allLeaseAgreements
              .add(LeaseAgreementsModel.fromJson(leaseAgreements));
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("KİRA SÖZLEŞMELERİ GETİRİLİRKEN HATA OLUŞTU: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
