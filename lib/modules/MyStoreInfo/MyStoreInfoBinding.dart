import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyStoreInfo/MyStoreInfoController.dart';

class MyStoreInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyStoreInfoController>(() => MyStoreInfoController());
  }
}
