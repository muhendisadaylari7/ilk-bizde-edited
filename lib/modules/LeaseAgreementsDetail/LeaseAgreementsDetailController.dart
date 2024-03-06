// ignore_for_file: file_names

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/LeaseAgreementsDetailRequestModel.dart';
import 'package:ilkbizde/data/model/LeaseAgreementsDetailResponseModel.dart';
import 'package:ilkbizde/data/network/api/DeleteLeaseAgreementApi.dart';
import 'package:ilkbizde/data/network/api/LeaseAgreementsDetailApi.dart';
import 'package:ilkbizde/modules/LeaseAgreements/index.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class LeaseAgreementsDetailController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;
  final RxBool isDeleteLoading = false.obs;

  final RxList<LeaseAgreementsDetailResponseModel> leaseAgreementsDetail =
      <LeaseAgreementsDetailResponseModel>[].obs;

  final Map<String, dynamic> parameters = Get.parameters;

  @override
  void onInit() {
    super.onInit();
    getLeaseAgreementsDetail();
  }

  // KİRA SÖZLEŞMESİ DETAYLARINI GETİR
  Future<void> getLeaseAgreementsDetail() async {
    isLoading.toggle();
    final LeaseAgreementsDetailRequestModel leaseAgreementsDetailRequestModel =
        LeaseAgreementsDetailRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      sozlesmeId: parameters["contractId"],
    );
    final LeaseAgreementsDetailApi leaseAgreementsDetailApi =
        LeaseAgreementsDetailApi();

    try {
      await leaseAgreementsDetailApi
          .getLeaseAgreementsDetail(
              data: leaseAgreementsDetailRequestModel.toJson())
          .then(
        (resp) {
          if (resp.data == null) return;
          leaseAgreementsDetail
              .add(LeaseAgreementsDetailResponseModel.fromJson(resp.data));
        },
      );
    } catch (e) {
      isLoading.toggle();
      print("KİRA SÖZLEŞMESİ DETAYLARI GETİRİLİRKEN HATA OLUŞTU: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // KİRA SÖZLEŞMESİ SİL
  Future<void> deleteLeaseAgreement() async {
    isDeleteLoading.toggle();
    final LeaseAgreementsDetailRequestModel deleteLeaseAgreementModel =
        LeaseAgreementsDetailRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      sozlesmeId: parameters["contractId"],
    );
    final DeleteLeaseAgreementApi deleteLeaseAgreementApi =
        DeleteLeaseAgreementApi();

    try {
      await deleteLeaseAgreementApi
          .deleteLeaseAgreement(data: deleteLeaseAgreementModel.toJson())
          .then(
        (resp) async {
          if (resp.data == null) return;
          if (resp.data["status"] == "success") {
            SnackbarType.success.CustomSnackbar(
                title: AppStrings.success, message: resp.data["message"]);
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
            final LeaseAgreementsController leaseAgreementsController =
                Get.find<LeaseAgreementsController>();
            await leaseAgreementsController.getAllLeaseAgreements();
            Get.close(1);
          } else {
            SnackbarType.error.CustomSnackbar(
                title: AppStrings.error, message: resp.data["message"]);
            await Future.delayed(const Duration(seconds: 2), () => Get.back());
          }
        },
      );
    } catch (e) {
      isDeleteLoading.toggle();
      print("KİRA SÖZLEŞMESİ SİLİNİRKEN HATA OLUŞTU: $e");
    } finally {
      isDeleteLoading.toggle();
    }
  }
}
