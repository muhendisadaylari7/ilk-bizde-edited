// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: 'Ayarlar'),
      backgroundColor: AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Column(
        children: [
          ListItem(
            text: 'İzinlerim',
            onTap: () => {},
          ),
          ListItem(
            text: 'Güvenlik',
            onTap: () => {},
          ),
          ListItem(
            text: 'Dil Seçenekleri',
            onTap: () => {},
          ),
          ListItem(
            text: 'ilkbizde.com çerez politikası',
            onTap: () => Get.toNamed(Routes.PRIVACYANDPOLICY),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const ListItem({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
              color: Colors.white,
              // border-top: 1px solid rgba(0, 0, 0, 0.15)
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF000000).withOpacity(0.15),
                  width: 1.0,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF171725),
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF2D7797),
                size: 44,
              ),
            ],
          ),
        ));
  }
}
