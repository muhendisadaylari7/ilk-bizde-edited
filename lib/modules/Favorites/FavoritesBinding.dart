// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/Favorites/FavoritesController.dart';

class FavoritesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(() => FavoritesController());
  }
}
