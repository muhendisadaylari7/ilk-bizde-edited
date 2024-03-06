// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GetBillingRequestModel.dart';
import 'package:ilkbizde/data/network/api/GetBillingApi.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;

class MyBillingAndPayments extends StatefulWidget {
  const MyBillingAndPayments({super.key});

  @override
  State<MyBillingAndPayments> createState() => _MyBillingAndPaymentsState();
}

class _MyBillingAndPaymentsState extends State<MyBillingAndPayments> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());
  final GetStorage storage = GetStorage();
  final GetBillingApi getBillingApi = GetBillingApi();
  Future<dio.Response<dynamic>>? billResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBilling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomMyAccountItemAppBar(title: 'Fatura ve Ödeme Bilgilerim'),
      backgroundColor: AppColors.WHITE,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Container(
              width: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: const Color(0xFFE3E0E0),
                  width: 1.0,
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning,
                    color: AppColors.RED,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      "Fatura bilgileriniz aşağıda yer almaktadır. Fatura bilgilerinizde bir hata olduğunu düşünüyorsanız lütfen bizimle iletişime geçiniz.",
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.WHITE,
              border: Border.all(
                color: const Color(0xFF000000).withOpacity(0.1),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sıradaki Faturanız",
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
                FutureBuilder(future: billResponse, builder: _nextBillBuilder),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Text(
              "Geçmiş Faturalarım",
              style: TextStyle(
                color: Color(0xFF212121),
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          FutureBuilder(future: billResponse, builder: _billingBuilder)
        ],
      ),
    );
  }

  _getBilling() {
    billResponse = getBillingApi.getBilling(
        data: GetBillingRequestModel(
      secretKey: dotenv.env["SECRET_KEY"].toString(),
      userId: storage.read("uid") ?? "",
      userEmail: storage.read("uEmail") ?? "",
      userPassword: storage.read("uPassword") ?? "",
    ));
  }

  Widget _billingBuilder(
    BuildContext _,
    AsyncSnapshot<dio.Response<dynamic>> snapshot,
  ) {
    if (snapshot.hasData) {
      var billList = snapshot.data?.data["faturalar"]
          .map((e) => Bill(
                billNumber: e["odemeNo"],
                dateTime: DateFormat('dd-MM-yyyy').parse(e["faturaTarihi"]),
                amount: e["tutar"],
                status: e["durum"],
              ))
          .toList();

      List<Widget> billWidgets = [];
      for (var bill in billList) {
        billWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: BillingItem(
              month: _dateTimeToTurkishMonth(bill.dateTime),
              dateTime: bill.dateTime,
              amount: bill.amount,
              isPaid: bill.status == "Ödendi",
              onTap: () {},
            ),
          ),
        );
      }

      return Column(
        children: billWidgets,
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _nextBillBuilder(
    BuildContext _,
    AsyncSnapshot<dio.Response<dynamic>> snapshot,
  ) {
    if (snapshot.hasData) {
      DateTime nextBillDate = DateFormat('dd-MM-yyyy')
          .parse(snapshot.data?.data["siradakiFaturaTarihi"]);
      String nextBillAmount = snapshot.data?.data["siradakiFaturaFiyatı"];

      return BillingItem(
        month: _dateTimeToTurkishMonth(nextBillDate),
        dateTime: nextBillDate,
        amount: nextBillAmount,
        isPaid: false,
        onTap: () {},
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  _dateTimeToTurkishMonth(DateTime dateTime) {
    switch (dateTime.month) {
      case 1:
        return "Ocak";
      case 2:
        return "Şubat";
      case 3:
        return "Mart";
      case 4:
        return "Nisan";
      case 5:
        return "Mayıs";
      case 6:
        return "Haziran";
      case 7:
        return "Temmuz";
      case 8:
        return "Ağustos";
      case 9:
        return "Eylül";
      case 10:
        return "Ekim";
      case 11:
        return "Kasım";
      case 12:
        return "Aralık";
    }
  }
}

class Bill {
  final String billNumber;
  final DateTime dateTime;
  final String amount;
  final String status;

  Bill({
    required this.dateTime,
    required this.amount,
    required this.status,
    required this.billNumber,
  });
}

class BillingItem extends StatelessWidget {
  final String month;
  final DateTime dateTime;
  final String amount;
  final bool isPaid;
  final Function onTap;

  const BillingItem({
    super.key,
    required this.month,
    required this.dateTime,
    required this.amount,
    required this.isPaid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          border: Border.all(
            color: const Color(0xFF000000).withOpacity(0.1),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$month Faturası",
                    style: const TextStyle(
                      color: AppColors.BLACK,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    DateFormat('MM dd, yyyy').format(dateTime),
                    style: const TextStyle(
                      color: Color(0xFF616161),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      color: isPaid ? const Color(0xFF01B763) : AppColors.RED,
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        isPaid ? "Ödendi" : "Ödenmedi",
                        style: const TextStyle(
                          color: Color(0xFF616161),
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                      Icon(
                        isPaid ? Icons.check : Icons.close,
                        color: isPaid ? const Color(0xFF01B763) : AppColors.RED,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: const Column(
                children: [
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFF2D7797),
                    size: 44,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
