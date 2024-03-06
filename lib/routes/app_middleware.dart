import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/routes/app_pages.dart';

class DynamicDeeplinkMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  DynamicDeeplinkMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    return RouteSettings(name: Routes.NAVBAR);
  }
}
