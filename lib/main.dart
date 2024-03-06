import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/bindings/NetworkBinding.dart';
import 'package:ilkbizde/di.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  AppInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'İlkBizde',
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          localizationsDelegates: localization.localizationsDelegates,
          supportedLocales: localization.supportedLocales,
          themeMode: ThemeMode.light,
          initialBinding: NetworkBinding(),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
