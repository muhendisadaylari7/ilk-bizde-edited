import 'package:flutter/widgets.dart';

enum Images {
  appLogo("appLogo"),
  user("user"),
  lock("lock"),
  email("email"),
  phone("phone"),
  forgotPassword("forgotPassword"),
  send("send"),
  loginWithPhoneNumber("loginWithPhoneNumber"),
  noInternet("noInternet"),
  noLocation("noLocation"),
  homeActive("homeActive"),
  homeInactive("homeInactive"),
  searchActive("searchActive"),
  searchInactive("searchInactive"),
  favoriteActive("favoriteActive"),
  favoriteInactive("favoriteInactive"),
  myAccountActive("myAccountActive"),
  myAccountInactive("myAccountInactive"),
  homeAppBarLeadingIcon("homeAppBarLeadingIcon"),
  home("home"),
  steering("steering"),
  clock("clock"),
  exclamation("exclamation"),
  inputSearch("inputSearch"),
  pin("pin"),
  profile("profile"),
  messages("messages"),
  myAccountBlogIcon("myAccountBlogIcon"),
  myAccountChangePasswordIcon("myAccountChangePasswordIcon"),
  myAccountFeedbackIcon("myAccountFeedbackIcon"),
  myAccountLogoutIcon("myAccountLogoutIcon"),
  myAccountNotOnAirIcon("myAccountNotOnAirIcon"),
  myAccountOnTheAirIcon("myAccountOnTheAirIcon"),
  myAccountPersonalInfoIcon("myAccountPersonalInfoIcon"),
  myAccountSettingsIcon("myAccountSettingsIcon"),
  myAccountArrowRightIcon("myAccountArrowRightIcon"),
  leftIcon("leftIcon"),
  lockFilled("lockFilled"),
  noFavorite("noFavorite"),
  noSearch("noSearch"),
  filter("filter"),
  compare("compare"),
  complaint("complaint"),
  history("history"),
  private("private"),
  locationIcon("locationIcon"),
  doping("doping"),
  opportunity("opportunity"),
  bell("bell"),
  noNotifications("noNotifications"),
  totalVisitors("totalVisitors"),
  noImages("noImages"),
  star("star"),
  chart("chart"),
  buyDoping("buyDoping"),
  google("google"),
  leaseAgreements("leaseAgreements"),
  contract("contract"),
  duration("duration"),
  urgentAndPriceDrop("urgentAndPriceDrop"),
  hasUrgent("hasUrgent"),
  hasPriceDrop("hasPriceDrop"),
  opportunity_doping("opportunity_doping"),
  showcase("showcase"),
  preview("preview"),
  newImage("newImage");

  final String value;
  const Images(this.value);

  Image get png => Image.asset("assets/images/$value.png");
  Image get pngWithScale => Image.asset("assets/images/$value.png", scale: 4);
}

extension ImagesExtension on Images {
  Image pngWithColor(Color? color, {double? scale = 4}) {
    return Image.asset(
      "assets/images/$value.png",
      scale: scale ?? 4,
      color: color,
    );
  }
}
