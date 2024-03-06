// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/controllers/NetworkController.dart';
import 'package:ilkbizde/modules/MyAccount/index.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/enum/myAdsType.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:launch_review/launch_review.dart';
import 'package:sizer/sizer.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final MyAccountController controller = Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    Get.put(MyAccountController());
    return Scaffold(
      backgroundColor: Get.isDarkMode ? null : AppColors.ZHEN_ZHU_BAI_PEARL,
      body: GetBuilder<NetworkController>(builder: (networkController) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternetWidget();
        }
        return Obx(
          () => controller.personalInformationController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.ASHENVALE_NIGHTS,
                  ),
                )
              : SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: AppPaddings.generalPadding.copyWith(bottom: 6.h),
                    child: Column(
                      children: [
                        Direction.vertical.spacer(2),
                        // ACCOUNT NAME
                        CustomAccountNameAndAccountTypeWidget(
                          controller: controller,
                        ),
                        Direction.vertical.spacer(3),
                        // ACCOUNT OTHER INFORMATION
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.8.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, Get.isDarkMode ? 0 : 5),
                                blurRadius: Get.isDarkMode ? 5 : 15,
                                spreadRadius: -5,
                                color: AppColors.BAI_SE_WHITE,
                              )
                            ],
                            color: Get.isDarkMode
                                ? AppColors.BLACK_WASH
                                : AppColors.WHITE,
                            borderRadius: AppBorderRadius.inputRadius,
                          ),
                          child: Column(
                            children: [
                              CustomMyAccountItem(
                                  title: AppStrings.personalInformation,
                                  image: Images.myAccountPersonalInfoIcon,
                                  onTap: () => null //() => Get.toNamed(""),
                                  ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                  title: AppStrings.changePassword,
                                  image: Images.myAccountChangePasswordIcon,
                                  onTap: () => null //() => Get.toNamed(""),
                                  ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                  title: AppStrings.messages,
                                  image: Images.messages,
                                  onTap: () => null //() => Get.toNamed(""),
                                  ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                title: "Blog",
                                image: Images.myAccountBlogIcon,
                                onTap: () => Get.toNamed(Routes.BLOG),
                              ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                title: "Yayında Olan İlanlar",
                                image: Images.myAccountOnTheAirIcon,
                                onTap: () => Get.toNamed(Routes.MYADS,
                                    arguments: [MyAdsType.ACTIVE]),
                              ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                title: "Yayında Olmayan İlanlar",
                                image: Images.myAccountNotOnAirIcon,
                                onTap: () => Get.toNamed(Routes.MYADS,
                                    arguments: [MyAdsType.PASSIVE]),
                              ),
                              Direction.vertical.spacer(2),
                              controller.personalInformationController
                                          .accountType.value ==
                                      "0"
                                  ? const SizedBox.shrink()
                                  : Stack(
                                      children: [
                                        CustomMyAccountItem(
                                          icon: Icons.store_outlined,
                                          title: "Mağazam",
                                          onTap: () =>
                                              controller.marketControl(),
                                        ),
                                        Positioned(
                                          width: 50,
                                          bottom: 0,
                                          top: 0,
                                          left: 115,
                                          child: Images.newImage.png,
                                        ),
                                      ],
                                    ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                title: "Geri bildiriminizi paylaşın",
                                image: Images.myAccountFeedbackIcon,
                                onTap: () {
                                  LaunchReview.launch(
                                    androidAppId: "com.app.ilkbizde",
                                    iOSAppId: "6471280510",
                                  );
                                },
                              ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                title: "Ayarlar",
                                image: Images.myAccountSettingsIcon,
                                onTap: () => Get.toNamed(Routes.SETTINGS),
                              ),
                              Direction.vertical.spacer(2),
                              CustomMyAccountItem(
                                title: "Çıkış Yap",
                                image: Images.myAccountLogoutIcon,
                                onTap: () => controller.handleLogout(),
                              ),
                              Direction.vertical.spacer(4),
                              Container(
                                width: 227,
                                height: 41.09,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0XFFF4F4F4),
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Kenar yuvarlama işlemi
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RoundedButton(
                                      text: 'Light',
                                      backgroundColor: const Color(0xFFFCFCFC),
                                      icon: Icons.light_mode,
                                      elevation: 1,
                                      onPressed: () {},
                                    ),
                                    RoundedButton(
                                      backgroundColor: const Color(0XFFF4F4F4),
                                      text: 'Dark',
                                      icon: Icons.dark_mode_outlined,
                                      elevation: 0,
                                      onPressed: () {
                                        // Dark butona basıldığında yapılacak işlemler
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }
}

class _CustomProPopup extends StatelessWidget {
  const _CustomProPopup();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 90.w,
        child: Material(
          borderRadius: AppBorderRadius.inputRadius,
          color: AppColors.SOOTY,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 1.h,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: CustomIconButton(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.WHITE,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Değerli Üyelerimiz",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily: AppFonts.semiBold,
                                color: AppColors.SAILER_MOON,
                              ),
                    ),
                    Direction.vertical.spacer(1),
                    Text(
                      "Bu platformda yer alan ilanların tamamı pasif durumdadır. Evrak eksikliği bulunduğundan onay sürecindedir.",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.WHITE,
                                fontFamily: AppFonts.semiBold,
                              ),
                    ),
                    Direction.vertical.spacer(1),
                    Text(
                      "Satış yetki belgesi yüklendikten sonra yayına açılacaktır. Kurumsal üyelerimizin hepsinde görülebilen ilanlarımız, mükerrer satış yetkisinin önüne geçilmesi için görüntülenebilmektedir.",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.WHITE,
                                fontFamily: AppFonts.semiBold,
                              ),
                    ),
                    Direction.vertical.spacer(1),
                    Text(
                      "İlanlara yapılacak itiraz, yetki belgesi ibraz edilerek yapılabilmektedir. Lütfen dikkat ediniz, bu ilanların herhangi bir sosyal medya platformunda veya başka mecralarda paylaşılması kesinlikle yasaktır.",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.WHITE,
                                fontFamily: AppFonts.semiBold,
                              ),
                    ),
                    Direction.vertical.spacer(1),
                    Text(
                      "Bu kurallara uymayan üyelerimizin üyelikleri iptal edilecektir. Platformumuzun güvenliği ve verimliliği için bu kurallara uymanız önemlidir.",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.WHITE,
                                fontFamily: AppFonts.semiBold,
                              ),
                    ),
                    Direction.vertical.spacer(1),
                    Text(
                      "Anlayışınız ve iş birliğiniz için teşekkür ederiz.",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.WHITE,
                                fontFamily: AppFonts.semiBold,
                              ),
                    ),
                    Direction.vertical.spacer(1),
                    Text(
                      "Saygılarımızla,",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.WHITE,
                                fontFamily: AppFonts.semiBold,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double elevation;

  const RoundedButton({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 107.5,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.black,
          shadowColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 22,
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Product Sans Medium',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
