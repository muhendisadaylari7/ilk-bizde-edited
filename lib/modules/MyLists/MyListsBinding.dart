import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyLists/MyListsController.dart';

class MyListsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyListsController>(() => MyListsController());
  }
}
