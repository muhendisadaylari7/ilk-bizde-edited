// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/Favorites/index.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class MyFavoritesList extends StatefulWidget {
  const MyFavoritesList({super.key});

  @override
  State<MyFavoritesList> createState() => _MyFavoritesListState();
}

class _MyFavoritesListState extends State<MyFavoritesList> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: 'Favori Listem'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: const Favorites(),
      ),
    );
  }
}
