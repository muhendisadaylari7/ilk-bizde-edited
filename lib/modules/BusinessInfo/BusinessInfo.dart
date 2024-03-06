// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GetBusinessInfoRequestModel.dart';
import 'package:ilkbizde/data/network/api/GetBusinessInfoApi.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({super.key});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());
  final GetStorage storage = GetStorage();
  final GetBusinessInfoApi getBusinessInfoApi = GetBusinessInfoApi();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _tcIdentityController = TextEditingController();
  final TextEditingController _taxOfficeController = TextEditingController();
  final TextEditingController _taxCityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _storeTypeController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();

  int selectedStoreType = 0;
  int selectedBusinessType = 0;
  DateTime selectedDate = DateTime.now();

  List<String> storeTypes = [
    "İnşaat",
    "Otomotiv",
    "Gıda",
    "Tekstil",
    "Eğitim",
    "Sağlık",
    "Emlak",
    "Diğer"
  ];

  List<String> businessTypes = [
    "Şahıs",
    "Limited",
    "Anonim",
    "Kooperatif",
    "Dernek",
    "Vakıf",
    "Diğer"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBusinessInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: 'Mağaza İçeriği'),
      backgroundColor: AppColors.WHITE,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: ListView(
          children: [
            CustomInputItem(
              text: "Mağaza Adı",
              controller: _businessNameController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomInputItem(
              text: "Mağaza Tipi",
              controller: _storeTypeController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomInputItem(
              text: "Firma Tipi",
              controller: _businessTypeController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomInputItem(
              text: "Tc Kimlik No",
              controller: _tcIdentityController,
              isNumberOnly: true,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomInputItem(
              text: "Vergi İli",
              controller: _taxCityController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomInputItem(
              text: "Vergi Dairesi",
              controller: _taxOfficeController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomInputItem(
              text: "Adres",
              controller: _addressController,
            ),
          ],
        ),
      ),
    );
  }

  _getBusinessInfo() async {
    getBusinessInfoApi
        .getBusinessInfo(
            data: GetBusinessRequesetModel(
                secretKey: dotenv.env["SECRET_KEY"].toString(),
                userId: storage.read("uid") ?? "",
                userEmail: storage.read("uEmail") ?? "",
                userPassword: storage.read("uPassword") ?? ""))
        .then((response) {
      if (response.data != null) {
        setState(() {
          _businessNameController.text = response.data["magazaAdi"];
          _storeTypeController.text = response.data["magazaTipi"];
          _businessTypeController.text = response.data["firmaTipi"];
          _tcIdentityController.text = response.data["tcKimlikNo"];
          _taxCityController.text = response.data["vergiIli"];
          _taxOfficeController.text = response.data["vergiDairesi"];
          _addressController.text = response.data["adres"];
        });
      }
    }).onError((error, stackTrace) {
      print("error : $error");
    });
  }
}

class DropDownInputItem extends StatelessWidget {
  final String text;
  final List<String> items;
  final String? selectedItem;
  final void Function(String?)? onChanged;

  const DropDownInputItem({
    super.key,
    required this.text,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.05,
              color: Color(0xFFB2B2B2),
            )),
        Container(
          height: 45,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE6E6E6), width: 2.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: DropdownButton<String>(
            value: selectedItem,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CustomInputItem extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool isNumberOnly;

  const CustomInputItem({
    super.key,
    required this.text,
    required this.controller,
    this.isNumberOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.05,
              color: Color(0xFFB2B2B2),
            )),
        SizedBox(
          height: 45,
          child: TextField(
            readOnly: true,
            controller: controller,
            keyboardType:
                isNumberOnly ? TextInputType.number : TextInputType.text,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE6E6E6), width: 2.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
