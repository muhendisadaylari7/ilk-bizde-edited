// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:ilkbizde/modules/AddLeaseAgreement/index.dart';
import 'package:ilkbizde/modules/AdsPublish/index.dart';
import 'package:ilkbizde/modules/AdvertisementCompare/index.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/index.dart';
import 'package:ilkbizde/modules/AdvertisementPublishSelectCategory/index.dart';
import 'package:ilkbizde/modules/AllDailyOpportunity/index.dart';
import 'package:ilkbizde/modules/AppSettings/AppSettings.dart';
import 'package:ilkbizde/modules/Blog/index.dart';
import 'package:ilkbizde/modules/BlogDetail/index.dart';
import 'package:ilkbizde/modules/BusinessInfo/BusinessInfo.dart';
import 'package:ilkbizde/modules/CategoryResultPage/index.dart';
import 'package:ilkbizde/modules/ChangePassword/index.dart';
import 'package:ilkbizde/modules/Favorites/index.dart';
import 'package:ilkbizde/modules/ForgotPassword/index.dart';
import 'package:ilkbizde/modules/Home/index.dart';
import 'package:ilkbizde/modules/LeaseAgreements/index.dart';
import 'package:ilkbizde/modules/LeaseAgreementsDetail/index.dart';
import 'package:ilkbizde/modules/LoginWithPhoneNumber/index.dart';
import 'package:ilkbizde/modules/MyAccount/index.dart';
import 'package:ilkbizde/modules/MyAds/index.dart';
import 'package:ilkbizde/modules/MyAdsDetail/index.dart';
import 'package:ilkbizde/modules/MyBillingsAndPayments/MyBillingAndPayments.dart';
import 'package:ilkbizde/modules/MyFavoritesList/index.dart';
import 'package:ilkbizde/modules/MyLists/index.dart';
import 'package:ilkbizde/modules/MyOpportunity/index.dart';
import 'package:ilkbizde/modules/MyStoreInfo/index.dart';
import 'package:ilkbizde/modules/MyStore/index.dart';
import 'package:ilkbizde/modules/MyStoreDetail/index.dart';
import 'package:ilkbizde/modules/MyStoreInformation/MyStoreInformation.dart';
import 'package:ilkbizde/modules/MyStoreList%20copy/index.dart';
import 'package:ilkbizde/modules/MyStoreList/MyStoreList.dart';
import 'package:ilkbizde/modules/Navbar/index.dart';
import 'package:ilkbizde/modules/News/index.dart';
import 'package:ilkbizde/modules/NewsDetail/index.dart';
import 'package:ilkbizde/modules/Notification/index.dart';
import 'package:ilkbizde/modules/NotificationSettings/index.dart';
import 'package:ilkbizde/modules/PersonalInformation/index.dart';
import 'package:ilkbizde/modules/PrivacyAndPolicy/index.dart';
import 'package:ilkbizde/modules/SearchPage/index.dart';
import 'package:ilkbizde/modules/SearchResultPage/index.dart';
import 'package:ilkbizde/modules/SelectCategoryPage/index.dart';
import 'package:ilkbizde/modules/Settings/index.dart';
import 'package:ilkbizde/modules/Showcase/index.dart';
import 'package:ilkbizde/modules/Signup/index.dart';
import 'package:ilkbizde/modules/Splash/index.dart';
import 'package:ilkbizde/modules/Login/index.dart';
import 'package:ilkbizde/modules/UserAdd/UserAdd.dart';
import 'package:ilkbizde/modules/Users/Users.dart';
import 'package:ilkbizde/routes/app_middleware.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final List<GetPage<dynamic>> routes = <GetPage>[
    GetPage(
      name: Routes.SPLASH,
      page: () => const Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const Signup(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.FORGOTPASSWORD,
      page: () => const ForgotPassword(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.LOGINWITHPHONENUMBER,
      page: () => const LoginWithPhoneNumber(),
      binding: LoginWithPhoneNumberBinding(),
    ),
    GetPage(
      name: Routes.NAVBAR,
      page: () => const Navbar(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: Routes.SHOWCASE,
      page: () => const Showcase(),
      binding: ShowcaseBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE,
      page: () => const Favorites(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: Routes.MYACCOUNTINFO,
      page: () => const MyAccount(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: Routes.PERSONALINFORMATION,
      page: () => const PersonalInformation(),
      binding: PersonalInformationBinding(),
    ),
    GetPage(
      name: Routes.CHANGEPASSWORD,
      page: () => const ChangePassword(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.SEARCHPAGE,
      page: () => const SearchPage(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: Routes.SEARCHRESULTPAGE,
      page: () => const SearchResultPage(),
      binding: SearchResultPageBinding(),
    ),
    GetPage(
      name: Routes.SELECTCATEGORYPAGE,
      page: () => const SelectCategoryPage(),
      binding: SelectCategoryPageBinding(),
    ),
    GetPage(
      name: Routes.CATEGORYRESULTPAGE,
      page: () => const CategoryResultPage(),
      binding: CategoryResultPageBinding(),
    ),
    GetPage(
      name: Routes.ADVERTISEMENT,
      page: () => const AdvertisementDetail(),
      middlewares: [DynamicDeeplinkMiddleware(priority: 1)],
      binding: AdvertisementDetailBinding(),
    ),
    GetPage(
      name: '${Routes.ADVERTISEMENTDETAIL}:adId',
      page: () => const AdvertisementDetail(),
      binding: AdvertisementDetailBinding(),
    ),
    GetPage(
      name: Routes.ADVERTISEMENTCOMPARE,
      page: () => const AdvertisementCompare(),
      binding: AdvertisementCompareBinding(),
    ),
    GetPage(
      name: Routes.BLOG,
      page: () => const Blog(),
      binding: BlogBinding(),
    ),
    GetPage(
      name: Routes.BLOGDETAIL,
      page: () => const BlogDetail(),
      binding: BlogDetailBinding(),
    ),
    GetPage(
      name: Routes.NEWS,
      page: () => const News(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: Routes.NEWSDETAIL,
      page: () => const NewsDetail(),
      binding: NewsDetailBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ADVERTISEMENTPUBLISHSELECTCATEGORY,
      page: () => const AdvertisementPublishSelectCategory(),
      binding: AdvertisementPublishSelectCategoryBinding(),
    ),
    GetPage(
      name: Routes.ADSPUBLISH,
      page: () => const AdsPublish(),
      binding: AdsPublishBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => const Notification(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.MYADS,
      page: () => const MyAds(),
      binding: MyAdsBinding(),
    ),
    GetPage(
      name: Routes.MYADSDETAIL,
      page: () => const MyAdsDetail(),
      binding: MyAdsDetailBinding(),
    ),
    GetPage(
      name: Routes.ALLDAILYOPPORTUNITY,
      page: () => const AllDailyOpportunity(),
      binding: AllDailyOpportunityBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const Settings(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONSETTINGS,
      page: () => const NotificationSettings(),
      binding: NotificationSettingsBinding(),
    ),
    GetPage(
      name: Routes.MYSTOREINFO,
      page: () => const MyStoreInfo(),
      binding: MyStoreInfoBinding(),
    ),
    GetPage(
      name: Routes.MYSTOREDETAIL,
      page: () => const MyStoreDetail(),
      binding: MyStoreDetailBinding(),
    ),
    GetPage(
      name: Routes.LEASEAGREEMENTS,
      page: () => const LeaseAgreements(),
      binding: LeaseAgreementsBinding(),
    ),
    GetPage(
      name: Routes.LEASEAGREEMENTSDETAIL,
      page: () => const LeaseAgreementsDetail(),
      binding: LeaseAgreementsDetailBinding(),
    ),
    GetPage(
      name: Routes.ADDLEASEAGREEMENT,
      page: () => const AddLeaseAgreement(),
      binding: AddLeaseAgreementBinding(),
    ),
    GetPage(
      name: Routes.MYOPPORTUNITY,
      page: () => const MyOpportunity(),
      binding: MyOpportunityBinding(),
    ),
    GetPage(
      name: Routes.PRIVACYANDPOLICY,
      page: () => const PrivacyAndPolicy(),
      binding: PrivacyAndPolicyBinding(),
    ),
    GetPage(
      name: Routes.MYSTORE,
      page: () => const MyStore(),
      binding: MyStoreBinding(),
    ),
    GetPage(
      name: Routes.MYLISTS,
      page: () => const MyLists(),
      binding: MyListsBinding(),
    ),
    GetPage(
      name: Routes.MYFAVORITESLIST,
      page: () => const MyFavoritesList(),
    ),
    GetPage(
      name: Routes.MYSTORELIST,
      page: () => const MyStoreList(),
    ),
    GetPage(
      name: Routes.MYSTOREINFORMATION,
      page: () => const MyStoreInformation(),
    ),
    GetPage(
      name: Routes.BUSINESSINFO,
      page: () => const BusinessInfo(),
    ),
    GetPage(
      name: Routes.USERS,
      page: () => const Users(),
    ),
    GetPage(
      name: Routes.USERADD,
      page: () => const UserAdd(),
    ),
    GetPage(
      name: Routes.BILLINGANDPAYMENT,
      page: () => const MyBillingAndPayments(),
    ),
    GetPage(
      name: Routes.APPSETTINGS,
      page: () => const AppSettings(),
    ),
    GetPage(
      name: Routes.MYSTOREPERFORMANCE,
      page: () => const MyStorePerformance(),
    ),
  ];
}
