// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/GetStoreTotalVisitorNumberRequestModel.dart';
import 'package:ilkbizde/data/model/MarktInfosResponseModel.dart';
import 'package:ilkbizde/data/network/api/GetStoreTotalVisitorNumberApi.dart';
import 'package:ilkbizde/data/network/api/MarketInfosApi.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/modules/MyStore/MyStoreController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class MyStore extends StatefulWidget {
  const MyStore({super.key});

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  final MyStoreController controller = Get.put(MyStoreController());
  final MyAccountController myAccountController =
      Get.put(MyAccountController());
  final GetStoreTotalVisitorNumberApi getStoreTotalVisitorNumberApi =
      GetStoreTotalVisitorNumberApi();
  final GetStorage storage = GetStorage();
  final RxList<MarketInfosResponseModel> infos =
      <MarketInfosResponseModel>[].obs;
  int totalVisitor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarketInfos().then((value) {
      _getStoreTotalVisitorNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MyStoreController());
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: 'Mağazam'),
      body: Column(
        children: [
          CustomAccountNameAndAccountTypeWidget(
            controller: myAccountController,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ASHENVALE_NIGHTS,
                      ),
                    )
                  : Column(
                      children: [
                        const CustomTitleSubtitleWidget(
                          title: 'Saatlik Ziyaret Sayısı',
                          subtitle:
                              'İlanlarınıza gelen toplam ziyaret sayısını gösterir.',
                          titleColor: Color(0xFF171725),
                          subtitleColor: Color(0xFF9D9D9E),
                          titleFontWeight: FontWeight.w600,
                          subtitleFontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ziyaret Sayısı ( Son 24 Saat )",
                                style: TextStyle(
                                  color: Color(0xFF171725),
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TrafficChart(
                                totalClicks: totalVisitor,
                                maxClicks: 500,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "$totalVisitor ",
                                    style: const TextStyle(
                                      color: Color(0xFF123E70),
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    "Ziyaret",
                                    style: TextStyle(
                                      color: Color(0xFF123E70),
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 97,
                                    height: 40,
                                    child: CustomButton(
                                      title: "Detaylı Bak",
                                      textStyle: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          top: 8,
                                          right: 0,
                                          bottom: 12),
                                      bg: AppColors.ASHENVALE_NIGHTS,
                                      onTap: () => {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ListItem(
                          text: 'Listelerim',
                          onTap: () => Get.toNamed(Routes.MYLISTS),
                        ),
                        ListItem(
                          text: 'Mağazam',
                          onTap: () => Get.toNamed(Routes.MYSTORELIST),
                        ),
                        ListItem(
                          text: 'Mağaza Performansı',
                          onTap: () => Get.toNamed(Routes.MYSTOREPERFORMANCE),
                        ),
                        ListItem(
                          text: 'Ayarlar',
                          onTap: () => Get.toNamed(Routes.APPSETTINGS),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getMarketInfos() async {
    final GeneralRequestModel generalRequestModel = GeneralRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid"),
      userEmail: storage.read("uEmail"),
      userPassword: storage.read("uPassword"),
    );
    final MarketInfosApi marketInfosApi = MarketInfosApi();
    try {
      if (infos.isNotEmpty) infos.clear();
      await marketInfosApi
          .getMarketInfos(data: generalRequestModel.toJson())
          .then((resp) async {
        if (resp.data == null) return;
        infos.add(MarketInfosResponseModel.fromJson(resp.data));
        print("MARKET BİLGİLERİ: ${infos.first.magazaAdi}");
      });
    } catch (e) {
      print("getMarketInfos HATA: $e");
    }
  }

  _getStoreTotalVisitorNumber() async {
    try {
      await getStoreTotalVisitorNumberApi
          .getTotalVisitor(
              data: GetStoreTotalVisitorNumberRequestModel(
                  secretKey: dotenv.env["SECRET_KEY"].toString(),
                  userId: storage.read("uid") ?? "",
                  userEmail: storage.read("uEmail") ?? "",
                  userPassword: storage.read("uPassword") ?? "",
                  storeId: infos.first.id))
          .then((value) {
        if (value.data != null) ;
        setState(() {
          totalVisitor = value.data["toplamZiyaretci"] ?? 0;
        });
      }).onError((error, stackTrace) {
        print("Hata: $error");
      }).catchError((error) {
        print("Hata: $error");
      });
    } catch (e) {
      print("Hata: $e");
    }
  }
}

class CustomTitleSubtitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;
  final FontWeight titleFontWeight;
  final FontWeight subtitleFontWeight;

  const CustomTitleSubtitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
    required this.titleFontWeight,
    required this.subtitleFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: titleFontWeight,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: subtitleColor,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: subtitleFontWeight,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TrafficChart extends StatelessWidget {
  final int totalClicks;
  final int maxClicks;

  const TrafficChart(
      {super.key, required this.totalClicks, required this.maxClicks});

  @override
  Widget build(BuildContext context) {
    double ratio = totalClicks / maxClicks;

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Toplam Tıklanma: $totalClicks',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20.0),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                height: 40.0,
                width: MediaQuery.of(context).size.width * ratio,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      '$totalClicks',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
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
          height: 66,
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
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
