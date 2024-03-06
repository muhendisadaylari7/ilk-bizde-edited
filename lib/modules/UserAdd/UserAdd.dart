// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({super.key});

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController lasNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController photoController = TextEditingController();
    return Scaffold(
      appBar: const CustomMyAccountItemAppBar(title: 'Mağaza İçeriği'),
      backgroundColor: AppColors.WHITE,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: ListView(
          children: [
            InputItem(
              text: "İsim",
              controller: nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputItem(
              text: "Soyisim",
              controller: lasNameController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputItem(
              text: "İletişim Numarası",
              controller: phoneNumberController,
              isNumeric: true,
            ),
            const SizedBox(
              height: 10,
            ),
            InputItem(
              text: "E-posta",
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputItem(
              text: "Logo",
              controller: photoController,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 49,
              child: ElevatedButton(
                onPressed: () {
                  // Butona tıklama işlemi
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.WHITE,
                  backgroundColor: AppColors.FENNEL_FIESTA, // Yazı rengi beyaz
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Kenarları yuvarlama
                  ),
                ),

                child: const Text('Kullanıcı Ekle',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.WHITE,
                    )), // Buton üzerindeki yazı
              ),
            )
            // Buton üzerindeki yazı
          ],
        ),
      ),
    );
  }
}

class InputItem extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool isNumeric;

  const InputItem({
    super.key,
    required this.text,
    required this.controller,
    this.isNumeric = false,
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
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
            ),
            child: TextField(
              controller: controller,
              keyboardType:
                  isNumeric ? TextInputType.number : TextInputType.text,
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
        ),
      ],
    );
  }
}
