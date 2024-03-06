// ACİL, FİYATI DÜŞEN ve HER İKİSİNİN OLDUĞU DURUMA GÖRE RESİM DÖNDEREN EXTENSİON
import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/enum/images.dart';

enum BadgeType { hasUrgent, hasPriceDrop, hasUrgentAndPriceDrop }

extension UrgentAndPriceDropExtension on BadgeType {
  Widget get getImage {
    switch (this) {
      case BadgeType.hasUrgent:
        return Images.hasUrgent.pngWithScale;
      case BadgeType.hasPriceDrop:
        return Images.hasPriceDrop.pngWithScale;
      case BadgeType.hasUrgentAndPriceDrop:
        return Images.urgentAndPriceDrop.pngWithScale;
    }
  }
}
