import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStore/MyStoreController.dart';

class MyStoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStoreController>(() => MyStoreController());
  }
}
