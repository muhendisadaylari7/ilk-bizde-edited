// ignore_for_file: must_be_immutable, file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GetMyStoreContentRequestModel.dart';
import 'package:ilkbizde/data/model/UpdateMyStoreContentRequestModel.dart';
import 'package:ilkbizde/data/network/api/GetMyStoreContentApi.dart';
import 'package:ilkbizde/data/network/api/UpdateMyStoreContentApi.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;

class MyStoreInformation extends StatefulWidget {
  const MyStoreInformation({super.key});

  @override
  State<MyStoreInformation> createState() => _MyStoreInformationState();
}

class _MyStoreInformationState extends State<MyStoreInformation> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());
  final GetStorage storage = GetStorage();
  final GetMyStoreContentApi getMyStoreContentApi = GetMyStoreContentApi();
  final UpdateMyStoreContentApi updateMyStoreContentApi =
      UpdateMyStoreContentApi();

  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeAboutController = TextEditingController();
  final TextEditingController _storeLogoController = TextEditingController();
  final TextEditingController _storeUserName = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  initState() {
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
            InputItem(
              text: "Mağaza Adı",
              controller: _storeNameController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputItem(
              text: "Hakkında",
              controller: _storeAboutController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputItem(
              text: "Mağaza Kullanıcı Adı",
              controller: _storeUserName,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                (_storeLogoController.text.isEmpty)
                    ? SizedBox(
                        width: 100,
                        child: Images.noImages.png,
                      )
                    : Image.file(
                        File(_storeLogoController.text),
                        width: 100,
                      ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 49,
                  child: ElevatedButton(
                    onPressed: () {
                      picker
                          .pickImage(source: ImageSource.gallery)
                          .then((value) {
                        if (value == null) return;
                        setState(() {
                          _storeLogoController.text = value.path;
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.WHITE,
                      backgroundColor:
                          AppColors.AQUA_FOREST, // Yazı rengi beyaz
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Kenarları yuvarlama
                      ),
                    ),

                    child: const Text('Resmi Güncelle',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                          color: AppColors.WHITE,
                        )), // Buton üzerindeki yazı
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 49,
              child: ElevatedButton(
                onPressed: () {
                  var storeLogoPath = _storeLogoController.text;
                  File file = File(storeLogoPath);

                  updateMyStoreContentApi
                      .updateMyStoreContent(
                          data: UpdateMyStoreContentRequestModel(
                    secretKey: dotenv.env["SECRET_KEY"].toString(),
                    userId: storage.read("uid") ?? "",
                    userEmail: storage.read("uEmail") ?? "",
                    userPassword: storage.read("uPassword") ?? "",
                    storeUserName: _storeUserName.text,
                    storeAbout: _storeAboutController.text,
                    storeName: _storeNameController.text,
                    storeLogoPath: file.path,
                  ))
                      .then((response) {
                    if (response.data != null) {
                      Get.snackbar("Başarılı", "Mağaza bilgileri güncellendi");
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.WHITE,
                  backgroundColor: AppColors.FENNEL_FIESTA, // Yazı rengi beyaz
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Kenarları yuvarlama
                  ),
                ),

                child: const Text('Kaydet',
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

  _getBusinessInfo() async {
    final dioPack = dio.Dio();
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    getMyStoreContentApi
        .getMyStoreContent(
            data: GetMyStoreContentRequesetModel(
                secretKey: dotenv.env["SECRET_KEY"].toString(),
                userId: storage.read("uid") ?? "",
                userEmail: storage.read("uEmail") ?? "",
                userPassword: storage.read("uPassword") ?? ""))
        .then((response) {
      if (response.data != null) {
        _storeNameController.text = response.data["magazaAdi"];
        _storeAboutController.text = response.data["magazaAciklamasi"];
        _storeUserName.text = response.data["magazaKullaniciAdi"];
        String imagePath = response.data["magazaLogo"];
        dioPack
            .get(
          imagePath,
          options: dio.Options(
            responseType: dio.ResponseType.bytes,
          ),
        )
            .then((imageBytes) {
          File("${appDocDirectory.path}/${imagePath.split("/").last}")
              .writeAsBytes(imageBytes.data)
              .then((File image) {
            setState(() {
              _storeLogoController.text = image.path;
            });
          }).catchError((error) {
            print('Hata oluştu: $error');
          });
        });

        setState(() {
          File x = File(response.data["magazaLogo"]);
        });
      }
    }).onError((error, stackTrace) {
      print("error : $error");
    });
  }
}

class InputItem extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const InputItem({
    super.key,
    required this.text,
    required this.controller,
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
