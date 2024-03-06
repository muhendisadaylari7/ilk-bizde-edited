// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilkbizde/data/model/GetUsersRequestModel.dart';
import 'package:ilkbizde/data/model/InvateUserRequestModel.dart';
import 'package:ilkbizde/data/model/RemoveUserRequestModel.dart';
import 'package:ilkbizde/data/model/UserInvitationCancelRequestModel.dart';
import 'package:ilkbizde/data/network/api/GetUsersApi.dart';
import 'package:ilkbizde/data/network/api/InvateUserRequestApi.dart';
import 'package:ilkbizde/data/network/api/RemoveUserApi.dart';
import 'package:ilkbizde/data/network/api/UserInvintationCancelRequestApi.dart';
import 'package:ilkbizde/modules/MyAccount/MyAccountController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/index.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final MyAccountController myAccountController =
      Get.put(MyAccountController());
  final GetStorage storage = GetStorage();
  final GetUsersApi getMyStoreContentApi = GetUsersApi();
  final RemoveUserRequestApi removeUserRequestApi = RemoveUserRequestApi();
  final InvateUserRequestApi invateUserRequestApi = InvateUserRequestApi();
  List<User> activeUsers = [];
  List<User> passiveUsers = [];
  List<User> pendingUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMyAccountItemAppBar(
        title: 'Kullanıcılar',
        rightWidget: TextButton(
          child: const Text(
            "Kullanıcı Ekle",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.7,
              color: Color(0xFFFFFFFF),
            ),
          ),
          onPressed: () => _onInvateUserButtonPressed(),
        ),
      ),
      backgroundColor: AppColors.WHITE,
      body: ListView(
        children: [
          Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Kullanıcı Listesi",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.05,
                      color: Color(0xFFB2B2B2),
                    ),
                  ),
                ],
              ),
              for (var user in activeUsers)
                ActiveUserItem(
                  fullName: "${user.name} ${user.lastName}",
                  email: user.email,
                  authority: user.authority,
                  userId: user.userId,
                  onPressed: () => _onRemoveUserButtonPressed(user.userId),
                ),
            ],
          ),
          Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Onay Bekleyen Kullanıcılar",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.05,
                      color: Color(0xFFB2B2B2),
                    ),
                  ),
                ],
              ),
              for (var user in pendingUsers)
                PendingUserItem(
                  fullName: "${user.name} ${user.lastName}",
                  email: user.email,
                  authority: user.authority,
                  cancelledUserId: user.userId,
                ),
            ],
          ),
          Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Pasif Kullanıcılar",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.05,
                      color: Color(0xFFB2B2B2),
                    ),
                  ),
                ],
              ),
              for (var user in passiveUsers)
                PassiveUserItem(
                  fullName: "${user.name} ${user.lastName}",
                  email: user.email,
                  authority: user.authority,
                  userId: user.userId,
                ),
            ],
          ),
        ],
      ),
    );
  }

  _onInvateUserButtonPressed() {
    TextEditingController userEmailController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Davet gönderilecek mail adresi",
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
                  invateUserRequestApi
                      .invateUser(
                          data: InvateUserRequestModel(
                    secretKey: dotenv.env["SECRET_KEY"].toString(),
                    userId: storage.read("uid") ?? "",
                    userEmail: storage.read("uEmail") ?? "",
                    userPassword: storage.read("uPassword") ?? "",
                    invitedUserEmail: userEmailController.text,
                  ))
                      .then((value) {
                    if (value.data["status"] == "success") {
                      Get.back();
                      Get.snackbar("Başarılı", value.data["message"]);
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

                child: const Text('Davet Gönder',
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
          controller: userEmailController,
          decoration: const InputDecoration(
            labelText: "Kullanıcı E-posta",
          ),
        ),
      ),
    );
  }

  _onRemoveUserButtonPressed(String userId) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        scrollable: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 2,
        ),
        title: Text(
          "İlanların aktarılacağı kullanıcıyı seçin",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        actions: [
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
        ],
        content: Column(
          children: [
            for (var user in activeUsers)
              if (user.userId != userId)
                GestureDetector(
                  onTap: () {
                    removeUserRequestApi
                        .removeUser(
                      data: RemoveUserRequestModel(
                        secretKey: dotenv.env["SECRET_KEY"].toString(),
                        userId: storage.read("uid") ?? "",
                        userEmail: storage.read("uEmail") ?? "",
                        userPassword: storage.read("uPassword") ?? "",
                        removedUserId: userId,
                        selectedUserId: user.userId,
                      ),
                    )
                        .then((value) {
                      if (value.data["status"] == "success") {
                        Get.back();
                        Get.snackbar("Başarılı", value.data["message"]);
                        setState(() {
                          activeUsers.removeWhere(
                              (element) => element.userId == userId);
                        });
                      } else {
                        Get.back();
                        Get.snackbar("Hata", value.data["message"]);
                      }
                    });
                  },
                  child: ActiveUserItem(
                    fullName: "${user.name} ${user.lastName}",
                    email: user.email,
                    authority: user.authority,
                    userId: user.userId,
                    onPressed: () {},
                  ),
                ),
          ],
        ),
      ),
    );
  }

  _getUsers() async {
    getMyStoreContentApi
        .getUsers(
      data: GetUsersRequesetModel(
        secretKey: dotenv.env["SECRET_KEY"].toString(),
        userId: storage.read("uid") ?? "",
        userEmail: storage.read("uEmail") ?? "",
        userPassword: storage.read("uPassword") ?? "",
      ),
    )
        .then((response) {
      if (response.data["status"] != "success") return;
      List<User> myactiveUsers = [];
      List<User> mypassiveUsers = [];
      List<User> mypendingUsers = [];
      for (var activeUser in response.data["aktifKullanicilar"]) {
        myactiveUsers.add(User(
          name: activeUser["ad"],
          lastName: activeUser["soyad"],
          email: activeUser["email"],
          authority: activeUser["yetki"],
          userId: activeUser["id"],
        ));
      }
      myactiveUsers.sort((a, b) => a.authority.compareTo(b.authority));
      setState(() {
        activeUsers = myactiveUsers.reversed.toList();
      });
      for (var passiveUser in response.data["pasifKullanicilar"]) {
        mypassiveUsers.add(User(
          name: passiveUser["ad"],
          lastName: passiveUser["soyad"],
          email: passiveUser["email"],
          authority: passiveUser["yetki"],
          userId: passiveUser["id"],
        ));
      }
      setState(() {
        passiveUsers = mypassiveUsers;
      });
      for (var pendingUser in response.data["bekleyenKullanicilar"]) {
        mypendingUsers.add(User(
          name: pendingUser["ad"],
          lastName: pendingUser["soyad"],
          email: pendingUser["email"],
          authority: pendingUser["yetki"],
          userId: pendingUser["id"],
        ));
      }
      setState(() {
        pendingUsers = mypendingUsers;
      });
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}

class User {
  final String name;
  final String lastName;
  final String email;
  final String authority;
  final String userId;

  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.authority,
    required this.userId,
  });
}

class PendingUserItem extends StatelessWidget {
  final String fullName;
  final String email;
  final String authority;
  final String cancelledUserId;

  final UserInvitationCancelRequestApi userInvitationCancelRequestApi =
      UserInvitationCancelRequestApi();

  PendingUserItem({
    super.key,
    required this.fullName,
    required this.email,
    required this.authority,
    required this.cancelledUserId,
  });

  @override
  Widget build(BuildContext context) {
    return UserItem(
      fullName: fullName,
      email: email,
      rightWidget: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFF01B763),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          authority,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            color: AppColors.WHITE,
          ),
        ),
      ),
      leftWidget: SizedBox(
        width: 40,
        child: (authority != "Mağaza Sahibi")
            ? IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: AppColors.ZHELEZNOGORSK_YELLOW,
                ),
                onPressed: () {
                  userInvitationCancelRequestApi
                      .cancelInvitation(
                          data: UserInvitationCancelRequestModel(
                    secretKey: dotenv.env["SECRET_KEY"].toString(),
                    userId: GetStorage().read("uid") ?? "",
                    userEmail: GetStorage().read("uEmail") ?? "",
                    userPassword: GetStorage().read("uPassword") ?? "",
                    cancelledUserId: cancelledUserId,
                  ))
                      .then((value) {
                    if (value.data["status"] == "success") {
                      Get.snackbar("Başarılı", value.data["message"]);
                    } else {
                      Get.snackbar("Hata", value.data["message"]);
                    }
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                },
              )
            : Images.myAccountPersonalInfoIcon
                .pngWithColor(AppColors.LIGHTISH_BLUE, scale: 1.5),
      ),
    );
  }
}

class PassiveUserItem extends StatelessWidget {
  final String fullName;
  final String email;
  final String authority;
  final String userId;

  const PassiveUserItem({
    super.key,
    required this.fullName,
    required this.email,
    required this.authority,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return UserItem(
      fullName: fullName,
      email: email,
      rightWidget: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFF01B763),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          authority,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            color: AppColors.WHITE,
          ),
        ),
      ),
      leftWidget: SizedBox(
        width: 40,
        child: (authority != "Mağaza Sahibi")
            ? IconButton(
                icon: const Icon(
                  Icons.send,
                  color: AppColors.GREEN_WRASSE,
                ),
                onPressed: () {},
              )
            : Images.myAccountPersonalInfoIcon
                .pngWithColor(AppColors.LIGHTISH_BLUE, scale: 1.5),
      ),
    );
  }
}

class ActiveUserItem extends StatelessWidget {
  final String fullName;
  final String email;
  final String authority;
  final String userId;
  final Function onPressed;

  const ActiveUserItem({
    super.key,
    required this.fullName,
    required this.email,
    required this.authority,
    required this.userId,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return UserItem(
      fullName: fullName,
      email: email,
      rightWidget: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFF01B763),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          authority,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            color: AppColors.WHITE,
          ),
        ),
      ),
      leftWidget: SizedBox(
        width: 40,
        child: (authority != "Mağaza Sahibi")
            ? IconButton(
                icon: const Icon(Icons.delete, color: AppColors.RED),
                onPressed: () {
                  onPressed();
                },
              )
            : Images.myAccountPersonalInfoIcon
                .pngWithColor(AppColors.LIGHTISH_BLUE, scale: 1.5),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  final String fullName;
  final String email;
  final Widget leftWidget;
  final Widget rightWidget;

  const UserItem({
    super.key,
    required this.fullName,
    required this.email,
    required this.leftWidget,
    required this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        border: Border(
          top: BorderSide(
            color: const Color(0xFF000000).withOpacity(0.10),
            width: 1.0,
          ),
          bottom: BorderSide(
            color: const Color(0xFF000000).withOpacity(0.10),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          leftWidget,
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Color(0xFF212121),
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
          Spacer(),
          rightWidget,
        ],
      ),
    );
  }
}
