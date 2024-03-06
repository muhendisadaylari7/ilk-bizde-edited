// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/CreateNewListRequestModel.dart';
import 'package:ilkbizde/data/model/DeleteListRequestModel.dart';
import 'package:ilkbizde/data/model/GetListsRequestModel.dart';
import 'package:ilkbizde/data/model/UpdateListRequestModel.dart';
import 'package:ilkbizde/data/network/api/CreateNewListRequestApi.dart';
import 'package:ilkbizde/data/network/api/DeleteListRequestApi.dart';
import 'package:ilkbizde/data/network/api/GeListsApi.dart';
import 'package:ilkbizde/data/network/api/UpdateListRequestApi.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/modules/MyLists/MyListsController.dart';
import 'package:ilkbizde/routes/app_pages.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class MyLists extends StatefulWidget {
  const MyLists({super.key});

  @override
  State<MyLists> createState() => _MyListsState();
}

class _MyListsState extends State<MyLists> {
  final MyListsController controller = Get.put(MyListsController());
  final MyAccountController myAccountController =
      Get.put(MyAccountController());
  final GetListsApi getListsApi = GetListsApi();
  final CreateNewListRequestApi createNewListRequestApi =
      CreateNewListRequestApi();
  final DeleteListRequestApi deleteListRequestApi = DeleteListRequestApi();
  final UpdateListRequestApi updateListRequestApi = UpdateListRequestApi();
  final GetStorage storage = GetStorage();
  List<AdsList> lists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMyLists();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MyListsController());
    return Scaffold(
      appBar: CustomMyAccountItemAppBar(
        title: 'Listelerim',
        rightWidget: TextButton(
            onPressed: () => _onNewListButtonPressed(),
            child: const Text(
              "Yeni Liste",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.WHITE,
                letterSpacing: -0.7,
                height: 20 / 12,
              ),
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.ASHENVALE_NIGHTS,
                  ),
                )
              : ListView(
                  children: [
                    for (var item in lists) ...[
                      ListWidget(
                        title: item.title,
                        color: (lists.indexOf(item) % 2 == 0)
                            ? AppColors.ASHENVALE_NIGHTS
                            : const Color(0xFFF48A0E),
                        onTap: () {
                          Get.toNamed(Routes.MYFAVORITESLIST,
                              parameters: {"listId": item.id});
                        },
                        onDeleteTap: () {
                          deleteListRequestApi
                              .deleteList(
                                  data: DeleteListRequestModel(
                            secretKey: dotenv.env["SECRET_KEY"].toString(),
                            userId: storage.read("uid") ?? "",
                            userEmail: storage.read("uEmail") ?? "",
                            userPassword: storage.read("uPassword") ?? "",
                            listId: item.id,
                          ))
                              .then((value) {
                            if (value.data["status"] == "success") {
                              Get.snackbar("Başarılı", value.data["message"]);
                              _getMyLists();
                            } else {
                              Get.snackbar("Hata", value.data["message"]);
                            }
                          }).onError((error, stackTrace) {
                            print(error.toString());
                          });
                        },
                        onEditTap: () {
                          _onUpdateListButtonPressed(item.id);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ]
                  ],
                ),
        ),
      ),
    );
  }

  _onUpdateListButtonPressed(String listId) {
    TextEditingController newTitleController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Liste Adını Güncelle",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: AppColors.BLACK,
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.WHITE,
                  backgroundColor: AppColors.RED, // Yazı rengi beyaz
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Kenarları yuvarlama
                  ),
                ),

                child: const Text('İptal',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.WHITE,
                    )), // Buton üzerindeki yazı
              ),
              ElevatedButton(
                onPressed: () {
                  updateListRequestApi
                      .updateList(
                          data: UpdateListRequestModel(
                    secretKey: dotenv.env["SECRET_KEY"].toString(),
                    userId: storage.read("uid") ?? "",
                    userEmail: storage.read("uEmail") ?? "",
                    userPassword: storage.read("uPassword") ?? "",
                    listId: listId,
                    newTitle: newTitleController.text,
                  ))
                      .then((value) {
                    if (value.data["status"] == "success") {
                      Get.back();
                      Get.snackbar("Başarılı", value.data["message"]);
                      _getMyLists();
                    } else {
                      Get.back();
                      Get.snackbar("Hata", value.data["message"]);
                    }
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.WHITE,
                  backgroundColor: AppColors.GREEN_WRASSE, // Yazı rengi beyaz
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Kenarları yuvarlama
                  ),
                ),

                child: const Text('Güncelle',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.WHITE,
                    )), // Buton üzerindeki yazı
              ),
            ],
          )
        ],
        content: TextField(
          controller: newTitleController,
          decoration: const InputDecoration(
            labelText: "Kullanıcı E-posta",
          ),
        ),
      ),
    );
  }

  _onNewListButtonPressed() {
    TextEditingController titleController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Liste Adı",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: AppColors.BLACK,
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.WHITE,
                  backgroundColor: AppColors.RED, // Yazı rengi beyaz
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Kenarları yuvarlama
                  ),
                ),

                child: const Text('İptal',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.WHITE,
                    )), // Buton üzerindeki yazı
              ),
              ElevatedButton(
                onPressed: () {
                  createNewListRequestApi
                      .createNewList(
                          data: CreateNewListRequestModel(
                    secretKey: dotenv.env["SECRET_KEY"].toString(),
                    userId: storage.read("uid") ?? "",
                    userEmail: storage.read("uEmail") ?? "",
                    userPassword: storage.read("uPassword") ?? "",
                    title: titleController.text,
                  ))
                      .then((value) {
                    if (value.data["status"] == "success") {
                      Get.back();
                      Get.snackbar("Başarılı", value.data["message"]);
                      _getMyLists();
                    } else {
                      Get.back();
                      Get.snackbar("Hata", value.data["message"]);
                    }
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.WHITE,
                  backgroundColor: AppColors.GREEN_WRASSE, // Yazı rengi beyaz
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Kenarları yuvarlama
                  ),
                ),

                child: const Text('Oluştur',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: AppColors.WHITE,
                    )), // Buton üzerindeki yazı
              ),
            ],
          )
        ],
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: "Liste Adı",
          ),
        ),
      ),
    );
  }

  _getMyLists() {
    List<AdsList> newLists = [];
    getListsApi
        .getLists(
            data: GetListsRequestModel(
                secretKey: dotenv.env["SECRET_KEY"].toString(),
                userId: storage.read("uid") ?? "",
                userEmail: storage.read("uEmail") ?? "",
                userPassword: storage.read("uPassword") ?? ""))
        .then((value) {
      if (value.data == null) return;

      for (var item in value.data) {
        newLists.add(AdsList(id: item["id"], title: item["baslik"]));
      }
      setState(() {
        lists.clear();
        lists.addAll(newLists);
      });
    });
  }
}

class AdsList {
  final String id;
  final String title;

  AdsList({required this.id, required this.title});
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  final String title;
  final Color color;
  final Function onTap;
  final Function onDeleteTap;
  final Function onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 216,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      onTap();
                    },
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.WHITE,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconText(
                    icon: Icons.edit,
                    text: "Değiştir",
                    onTap: onEditTap,
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  IconText(
                    icon: Icons.delete,
                    text: "Sil",
                    onTap: onDeleteTap,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  const IconText(
      {super.key, required this.icon, required this.text, required this.onTap});

  final IconData icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.ASHENVALE_NIGHTS.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              color: AppColors.WHITE,
            ),
          ),
          Direction.horizontal.spacer(1),
          Text(text,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.WHITE,
              )),
        ],
      ),
    );
  }
}
