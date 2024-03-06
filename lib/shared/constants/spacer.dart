import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

enum Direction {
  horizontal,
  vertical,
}

extension AppSpacer on Direction {
  SizedBox spacer(double value) {
    switch (this) {
      case Direction.horizontal:
        return SizedBox(width: value.w);
      case Direction.vertical:
        return SizedBox(height: value.h);
      default:
    }
    return const SizedBox.shrink();
  }
}
