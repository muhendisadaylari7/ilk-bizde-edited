import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uni_links/uni_links.dart';

class DeeplinkService {
  static final DeeplinkService _instance = DeeplinkService._init();
  static DeeplinkService get instance => _instance;
  DeeplinkService._init();

  Future<void> initialize() async {
    try {
      final Uri? uri = await getInitialUri();
      OneSignal.Notifications.addClickListener((event) {
        Future.delayed(const Duration(milliseconds: 500)).then((value) async {
          if (event.notification.launchUrl!.contains("Advertisement-Detail")) {
            try {
              await Future.delayed(const Duration(seconds: 1));
              Get.toNamed(
                '${Routes.ADVERTISEMENTDETAIL}${event.notification.launchUrl?.split("/").last}',
                parameters: {
                  "isDeeplink": "true",
                  "dailyOpportunity": "1",
                },
              );
            } catch (e) {
              print("HATA: $e");
            }
            return;
          }
        });
      });
      _uniLinkHandler(uri: uri);
    } on PlatformException {
      if (kDebugMode) {
        print("(PlatformException) Failed to receive initial uri.");
      }
    } on FormatException catch (error) {
      if (kDebugMode) {
        print(
            "(FormatException) Malformed Initial URI received. Error: $error");
      }
    }

    uriLinkStream.listen((Uri? uri) async {
      _uniLinkHandler(uri: uri);
    }, onError: (error) {
      if (kDebugMode) print('UniLinks onUriLink error: $error');
    });
  }

  Future<void> _uniLinkHandler({required Uri? uri}) async {
    if (uri == null) return;
    final String path = uri.path;
    Future.delayed(const Duration(milliseconds: 500)).then((value) async {
      if (path.contains(Routes.ADVERTISEMENT)) {
        try {
          var param = path.split('/').last;
          await Future.delayed(const Duration(seconds: 1));
          Get.toNamed(
            '${Routes.ADVERTISEMENTDETAIL}$param',
            parameters: {"isDeeplink": "true"},
          );
        } catch (e) {
          return;
        }
      }
    });
  }
}
