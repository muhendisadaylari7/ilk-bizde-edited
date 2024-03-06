// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/PrivacyAndPolicy/PrivacyAndPolicyController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class PrivacyAndPolicy extends StatefulWidget {
  const PrivacyAndPolicy({super.key});

  @override
  State<PrivacyAndPolicy> createState() => _PrivacyAndPolicyState();
}

class _PrivacyAndPolicyState extends State<PrivacyAndPolicy> {
  final PrivacyAndPolicyController controller =
      Get.put(PrivacyAndPolicyController());

  @override
  Widget build(BuildContext context) {
    Get.put(PrivacyAndPolicyController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: "Gizlilik ve Politika"),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.ASHENVALE_NIGHTS,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.privacyAndUsageList.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(controller.privacyAndUsageList[index].title),
                    children: [
                      _CustomHtmlWidget(
                          html: controller.privacyAndUsageList[index].content)
                    ],
                  );
                }),
      ),
    );
  }
}

class _CustomHtmlWidget extends StatelessWidget {
  final String html;
  const _CustomHtmlWidget({
    required this.html,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.h,
      ),
      child: HtmlWidget(html),
    );
  }
}
