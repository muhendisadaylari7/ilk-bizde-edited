import 'package:flutter/material.dart';
import 'package:ilkbizde/shared/extensions/GetBadge.dart';

Widget getBadge(bool hasUrgent, bool hasPriceDrop) {
  if (hasUrgent && hasPriceDrop) {
    return BadgeType.hasUrgentAndPriceDrop.getImage;
  } else if (hasUrgent) {
    return BadgeType.hasUrgent.getImage;
  } else if (hasPriceDrop) {
    return BadgeType.hasPriceDrop.getImage;
  } else {
    return SizedBox.shrink();
  }
}
