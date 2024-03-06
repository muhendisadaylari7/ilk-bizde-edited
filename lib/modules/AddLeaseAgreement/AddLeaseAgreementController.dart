// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/AddLeaseRequestModel.dart';
import 'package:ilkbizde/data/network/api/AddLeaseApi.dart';
import 'package:ilkbizde/modules/LeaseAgreements/LeaseAgreementsController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';
import 'package:intl/intl.dart';

class AddLeaseAgreementController extends GetxController {
  final GetStorage storage = GetStorage();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerSurnameController = TextEditingController();
  final TextEditingController ownerPhoneController = TextEditingController();
  final TextEditingController ownerTcController = TextEditingController();
  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController tenantSurnameController = TextEditingController();
  final TextEditingController tenantPhoneController = TextEditingController();
  final TextEditingController tenantTcController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController leasePriceController = TextEditingController();

  final RxBool isLoading = false.obs;

  final List<DropdownMenuItem<String>> leaseDurations = [
    const DropdownMenuItem<String>(
      value: "12 Ay",
      child: Text("12 Ay"),
    ),
    const DropdownMenuItem<String>(
      value: "24 Ay",
      child: Text("24 Ay"),
    ),
    const DropdownMenuItem<String>(
      value: "36 Ay",
      child: Text("36 Ay"),
    ),
    const DropdownMenuItem<String>(
      value: "48 Ay",
      child: Text("48 Ay"),
    ),
    const DropdownMenuItem<String>(
      value: "60 Ay",
      child: Text("60 Ay"),
    ),
  ];

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedLeaseDuration = "12 Ay".obs;

  @override
  void onClose() {
    titleController.dispose();
    ownerNameController.dispose();
    ownerSurnameController.dispose();
    ownerPhoneController.dispose();
    ownerTcController.dispose();
    tenantNameController.dispose();
    tenantSurnameController.dispose();
    tenantPhoneController.dispose();
    tenantTcController.dispose();
    addressController.dispose();
    leasePriceController.dispose();
    super.onClose();
  }

  // KİRA SÖZLEŞMESİ EKLE
  Future<void> addLeaseAgreement() async {
    isLoading.toggle();
    final AddLeaseRequestModel addLeaseRequestModel = AddLeaseRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      baslik: titleController.text,
      saticiAdi: ownerNameController.text,
      saticiSoyad: ownerSurnameController.text,
      adres: addressController.text,
      saticiTel: ownerPhoneController.text,
      saticiTc: ownerTcController.text,
      kiraBaslangicTarihi: DateFormat("yyyy-MM-dd").format(selectedDate.value),
      kiraSuresi: selectedLeaseDuration.value.split("Ay").first.trim(),
      kiraUcreti: leasePriceController.text,
      kiraciAdi: tenantNameController.text,
      kiraciSoyad: tenantSurnameController.text,
      kiraciTel: tenantPhoneController.text,
      kiraciTc: tenantTcController.text,
    );
    final AddLeaseApi addLeaseApi = AddLeaseApi();
    try {
      await addLeaseApi
          .addLease(data: addLeaseRequestModel.toJson())
          .then((resp) async {
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
      });
    } catch (e) {
      isLoading.toggle();
      print("addLeaseAgreement HATA: $e");
    } finally {
      isLoading.toggle();
    }
  }
}
