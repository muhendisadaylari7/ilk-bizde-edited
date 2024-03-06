// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/PersonalInformation/PersonalInformationController.dart';

class PersonalInformationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInformationController>(
        () => PersonalInformationController());
  }
}
