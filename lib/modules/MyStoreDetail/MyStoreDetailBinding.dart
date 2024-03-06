import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreDetail/MyStoreDetailController.dart';

class MyStoreDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStoreDetailController>(() => MyStoreDetailController());
  }
}
