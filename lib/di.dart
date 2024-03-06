import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/network/services/deep_link_service.dart';
import 'package:ilkbizde/firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

class AppInit {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await localization.init(
      mapLocales: [
        const MapLocale('tr', AppLocale.TR),
      ],
      initLanguageCode: 'tr',
    );
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    await GetStorage.init();
    final GetStorage storage = GetStorage();
    await dotenv.load(fileName: ".env");
    await DeeplinkService.instance.initialize();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (storage.read("isNotificationAllowed") == null) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      OneSignal.initialize(dotenv.env['ONE_SIGNAL_APP_ID'].toString());
      OneSignal.Notifications.requestPermission(true).then((value) {
        storage.write("isNotificationAllowed", value);
      });
    } else if (storage.read("isNotificationAllowed") == false) {
      return;
    } else {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      OneSignal.initialize(dotenv.env['ONE_SIGNAL_APP_ID'].toString());
      OneSignal.Notifications.requestPermission(true);
    }
  }
}

mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> TR = {title: 'Lokalizasyon'};
}
