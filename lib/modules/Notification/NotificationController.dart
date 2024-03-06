import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/DeleteNotificationModel.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/NotificationResponseModel.dart';
import 'package:ilkbizde/data/network/api/AllNotificationsApi.dart';
import 'package:ilkbizde/data/network/api/DeleteNotificationApi.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/extensions/CustomSnackbar.dart';

class NotificationController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxList<NotificationResponseModel> notificationList =
      <NotificationResponseModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isDeleteLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

// TÜM BİLDİRİMLERİ GETİR
  Future<void> getNotificationList() async {
    isLoading.toggle();
    final AllNotificationsApi allNotificationsApi = AllNotificationsApi();
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );
    try {
      await allNotificationsApi
          .getNotifications(data: generalRequestModel.toJson())
          .then((resp) {
        print(resp.data);
        for (var notification in resp.data) {
          notificationList
              .add(NotificationResponseModel.fromJson(notification));
        }
      });
    } catch (e) {
      isLoading.toggle();
      print("getNotificationList error: $e");
    } finally {
      isLoading.toggle();
    }
  }

  // BİLDİRİM SİL
  Future<void> deleteNotification({required String notificationId}) async {
    isDeleteLoading.toggle();
    final DeleteNotificationApi deleteNotificationApi = DeleteNotificationApi();
    final DeleteNotificationModel deleteNotificationModel =
        DeleteNotificationModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
      notId: notificationId,
    );
    try {
      await deleteNotificationApi
          .deleteNotification(data: deleteNotificationModel.toJson())
          .then((resp) async {
        if (resp.data["status"] == "success") {
          notificationList
              .removeWhere((element) => element.notId == notificationId);
          SnackbarType.success.CustomSnackbar(
              title: AppStrings.success, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
        } else {
          SnackbarType.error.CustomSnackbar(
              title: AppStrings.error, message: resp.data["message"]);
          await Future.delayed(Duration(seconds: 2), () => Get.back());
        }
      });
    } catch (e) {
      isDeleteLoading.toggle();
      print("deleteNotification error: $e");
    } finally {
      isDeleteLoading.toggle();
    }
  }
}
