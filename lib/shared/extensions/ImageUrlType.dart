// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ImageType {
  jpg,
  png,
}

extension ImageUrlTypeExtension on ImageType {
  String ImageUrl(String list) {
    switch (this) {
      case ImageType.jpg:
        return "${dotenv.env["IMAGE_URL"]}${list.split(",").first.split(".jpg").first}_full.jpg";
      case ImageType.png:
        return "${dotenv.env["IMAGE_URL"]}${list.split(",").first.split(".png").first}_full.png";
      default:
        return "${dotenv.env["IMAGE_URL"]}${list.split(",").first.split(".jpg").first}_full.jpg";
    }
  }

  String ImageUrlList(String list, int index) {
    switch (this) {
      case ImageType.jpg:
        return "${dotenv.env["IMAGE_URL"]}${list.split(",")[index].split(".jpg").first}_full.jpg";
      case ImageType.png:
        return "${dotenv.env["IMAGE_URL"]}${list.split(",")[index].split(".png").first}_full.png";
      default:
        return "${dotenv.env["IMAGE_URL"]}${list.split(",")[index].split(".jpg").first}_full.jpg";
    }
  }

  String ImageUrlWithMarketApiUrl(String list) {
    switch (this) {
      case ImageType.jpg:
        return "${dotenv.env["MARKET_IMAGE_URL"]}${list.split(",").first.split(".jpg").first}_full.jpg";
      case ImageType.png:
        return "${dotenv.env["MARKET_IMAGE_URL"]}${list.split(",").first.split(".png").first}_full.png";
      default:
        return "${dotenv.env["MARKET_IMAGE_URL"]}${list.split(",").first.split(".jpg").first}_full.jpg";
    }
  }

// URL in içindeki uzantıya göre ImageType belirler
  static ImageType getImageType(String path) {
    if (path.contains(".jpg")) {
      return ImageType.jpg;
    } else if (path.contains(".png")) {
      return ImageType.png;
    } else {
      return ImageType.jpg;
    }
  }
}
