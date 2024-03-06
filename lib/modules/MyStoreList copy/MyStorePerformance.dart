// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GeneralRequestModel.dart';
import 'package:ilkbizde/data/model/GetAdsRequestModel.dart';
import 'package:ilkbizde/data/model/GetMyPackagesRequestModel.dart';
import 'package:ilkbizde/data/model/GetStoreTotalVisitorNumberRequestModel.dart';
import 'package:ilkbizde/data/model/MarktInfosResponseModel.dart';
import 'package:ilkbizde/data/network/api/GetAdsApi.dart';
import 'package:ilkbizde/data/network/api/GetMyPackagesApi.dart';
import 'package:ilkbizde/data/network/api/MarketInfosApi.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ilkbizde/data/network/api/GetStoreTotalVisitorNumberApi.dart';

class MyStorePerformance extends StatefulWidget {
  const MyStorePerformance({super.key});

  @override
  State<MyStorePerformance> createState() => _MyStorePerformanceState();
}

class _MyStorePerformanceState extends State<MyStorePerformance> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());
  final GetStorage storage = GetStorage();
  GetStoreTotalVisitorNumberApi getStoreTotalVisitorNumberApi =
      GetStoreTotalVisitorNumberApi();
  final GetMyPackagesApi getMyPackagesApi = GetMyPackagesApi();
  GetAdsApi getAdsApi = GetAdsApi();
  final RxList<MarketInfosResponseModel> infos =
      <MarketInfosResponseModel>[].obs;
  DateTimeRange? selectedDateRange;
  int _totalAdsNumber = 0;
  int _usedAdsNumber = 0;
  int _totalVisitNumber = 0;
  int _activeAdsNumber = 0;
  int _passiveAdsNumber = 0;
  int _pendingAdsNumber = 0;
  double _percent = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMyPackages();
    getMarketInfos().then((value) {
      _getTotalVisitorNumber();
    });
    _getAds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: 'Mağazam'),
      backgroundColor: AppColors.ZHEN_ZHU_BAI_PEARL,
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Paket Kullanım Raporu",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: Color(0xFF171725),
            ),
          ),
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 20.0,
            animation: true,
            percent: _percent,
            center: Text(
              "%${(_percent * 100).toStringAsFixed(1)}",
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 40,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
                color: AppColors.ASHENVALE_NIGHTS,
              ),
            ),
            footer: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF123E70),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Text(
                        "Kalan ilan hakkı:",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                          color: Color(0xFF9D9D9E),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${_totalAdsNumber - _usedAdsNumber}",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                          color: Color(0xFF9D9D9E),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: const BoxDecoration(
                          color: AppColors.OROCHIMARU,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Text(
                        "Kullanılan ilan hakkı:",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                          color: Color(0xFF9D9D9E),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "$_usedAdsNumber",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                          color: Color(0xFF9D9D9E),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                const TitleItem(
                    title: "Yayındaki İlan Sayısı",
                    subTitle:
                        "Yayında olan satılık, kiralık ilan dağılımını gösterir."),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListItem(
                      text: "Toplam İlan Sayısı",
                      number: _totalAdsNumber,
                    ),
                    ListItem(
                      text: "Aktif İlanlar",
                      number: _activeAdsNumber,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListItem(
                      text: "Pasif İlanlar",
                      number: _passiveAdsNumber,
                    ),
                    ListItem(
                      text: "Onay Beklenen İlanlar",
                      number: _pendingAdsNumber,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const TitleItem(
                    title: "Ziyaret Sayısı",
                    subTitle:
                        "İlanlarınıza gelen toplam ziyaret sayısını gösterir."),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppColors.ASHENVALE_NIGHTS,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
              height: 102,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Color(0xFFF48A0E),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ziyaret Sayısı",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: AppColors.WHITE,
                        ),
                      ),
                      Text(
                        "$_totalVisitNumber",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: AppColors.WHITE,
                        ),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.people,
                    color: AppColors.WHITE,
                    size: 40,
                  )
                ],
              )),
        ],
      ),
    );
  }

  _getMyPackages() async {
    try {
      getMyPackagesApi
          .getMyPackages(
              data: GetMyPackagesRequestModel(
        secretKey: dotenv.env["SECRET_KEY"].toString(),
        userId: storage.read("uid"),
        userEmail: storage.read("uEmail"),
        userPassword: storage.read("uPassword"),
      ))
          .then((resp) {
        if (resp.data == null) return;
        for (var element in resp.data) {
          setState(() {
            _totalAdsNumber += int.parse(element["ilanLimiti"]);
          });
        }
      });
    } catch (e) {
      print("getMyPackages HATA: $e");
    }
  }

  _getAds() async {
    try {
      getAdsApi
          .getAds(
              data: GetAdsRequestModel(
        secretKey: dotenv.env["SECRET_KEY"].toString(),
        userId: storage.read("uid"),
        userEmail: storage.read("uEmail"),
        userPassword: storage.read("uPassword"),
      ))
          .then((resp) {
        if (resp.data == null) return;
        for (var element in resp.data[0]["kullaniciIlanlari"]) {
          if (element["durum"] == "Pasif") {
            setState(() {
              _passiveAdsNumber++;
            });
          } else if (element["durum"] == "Aktif") {
            setState(() {
              _activeAdsNumber++;
            });
          } else if (element["durum"] == "Admin Onayı Bekleniyor") {
            setState(() {
              _pendingAdsNumber++;
            });
          }
          setState(() {
            _usedAdsNumber++;
            _percent = (_totalAdsNumber == 0)
                ? 0
                : (_totalAdsNumber - _usedAdsNumber) / _totalAdsNumber;
          });
        }
        setState(() {});
      });
    } catch (e) {
      print("getAds HATA: $e");
    }
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

  _getTotalVisitorNumber() async {
    getStoreTotalVisitorNumberApi
        .getTotalVisitor(
      data: GetStoreTotalVisitorNumberRequestModel(
          secretKey: dotenv.env["SECRET_KEY"].toString(),
          userId: storage.read("uid") ?? "",
          userEmail: storage.read("uEmail") ?? "",
          userPassword: storage.read("uPassword") ?? "",
          storeId: infos.first.id),
    )
        .then((response) {
      if (response.data != null) {
        setState(() {
          _totalVisitNumber =
              int.parse(response.data["toplamZiyaretci"] ?? "0");
        });
      }
    }).onError((error, stackTrace) {
      print("Error: $error");
    });
  }
}

class TitleItem extends StatelessWidget {
  final String title;
  final String subTitle;
  const TitleItem({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.15),
              width: 1.0,
            ),
            bottom: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.15),
              width: 1.0,
            ),
          )),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    color: Color(0xFF171725),
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  )),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Color(0xFF9D9D9E),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xFFD2D2D2),
            size: 40,
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final int number;
  const ListItem({
    super.key,
    required this.text,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 104,
        width: 191,
        decoration: BoxDecoration(
          color: AppColors.ASHENVALE_NIGHTS,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          border: Border.all(
            color: AppColors.ASHENVALE_NIGHTS,
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 87,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                border: Border.all(
                  color: AppColors.ASHENVALE_NIGHTS,
                  width: 1.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text,
                      style: const TextStyle(
                        color: Color(0xFF171725),
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      )),
                  Text(
                    "$number",
                    style: const TextStyle(
                      color: Color(0xFF171725),
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
