import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomFilterBottomSheetAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final void Function() clearFunction;
  const CustomFilterBottomSheetAppBar({
    super.key,
    required this.clearFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            onTap: () => Get.back(),
            child: Icon(
              Icons.chevron_left_outlined,
              color: AppColors.WHITE,
              size: 18.sp,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 7.w),
            child: Text(
              AppStrings.filter,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.WHITE,
                    fontFamily: AppFonts.medium,
                  ),
            ),
          ),
          Bounceable(
            onTap: clearFunction,
            child: Text(
              AppStrings.clear,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.SHY_MOMENT,
                    fontFamily: AppFonts.light,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.h);
}
