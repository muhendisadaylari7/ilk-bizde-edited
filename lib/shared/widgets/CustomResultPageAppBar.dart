// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:sizer/sizer.dart';

class CustomResultPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final RxInt totalAds;
  final void Function(String)? searchOnChanged;
  final TextEditingController searchTextEditingController;
  const CustomResultPageAppBar({
    super.key,
    required this.totalAds,
    this.searchOnChanged,
    required this.searchTextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    RxInt w = 7.w.toInt().obs;
    RxInt h = 7.w.toInt().obs;
    RxBool isSearchEnabled = false.obs;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isSearchEnabled.value
                ? SizedBox.shrink()
                : Expanded(
                    child: Row(
                      children: [
                        Bounceable(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.chevron_left_outlined,
                            size: 35.sp,
                          ),
                        ),
                        Direction.horizontal.spacer(2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.searchResult,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.WHITE,
                                      fontFamily: AppFonts.medium,
                                    ),
                              ),
                              Obx(
                                () => Text(
                                  "${totalAds.value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} ${AppStrings.searchResultCount}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.WHITE,
                                        fontFamily: AppFonts.light,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            Bounceable(
              onTap: () async {
                isSearchEnabled.toggle();
                w.value = 90.w.toInt();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: w.value.toDouble(),
                height: h.value.toDouble(),
                child: isSearchEnabled.value
                    ? TextFormField(
                        autofocus: true,
                        controller: searchTextEditingController,
                        cursorColor: AppColors.WHITE,
                        enabled: isSearchEnabled.value,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.WHITE,
                            ),
                        onChanged: searchOnChanged,
                        onTapOutside: (event) async {
                          w.value = 7.w.toInt();
                          FocusScopeNode().unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 300),
                          );
                          isSearchEnabled.toggle();
                        },
                        decoration: InputDecoration(
                          suffixIcon: Bounceable(
                            onTap: () => searchTextEditingController.clear(),
                            child: Icon(
                              Icons.close_outlined,
                              color: AppColors.WHITE,
                              size: 13.sp,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
                          hintText: AppStrings.search,
                          hintStyle:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.SILVER,
                                  ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: AppBorderRadius.inputRadius,
                            borderSide: BorderSide.none,
                          ),
                          fillColor: AppColors.WHITE.withOpacity(.1),
                          filled: true,
                        ),
                      )
                    : CustomIconButton(
                        onTap: null,
                        child: Icon(
                          Icons.search_outlined,
                          color: AppColors.WHITE,
                          size: 12.sp,
                        ),
                      ),
              ),
            )
            // const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.h);
}
