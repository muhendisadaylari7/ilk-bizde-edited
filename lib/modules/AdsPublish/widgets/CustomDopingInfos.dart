// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/data/model/CreateAdsCategoryFilterResponseModel.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:ilkbizde/shared/widgets/CustomDropdownFieldWithList.dart';
import 'package:sizer/sizer.dart';

class CustomDopingInfos extends StatelessWidget {
  const CustomDopingInfos({
    super.key,
    required this.dopingFilters,
    required this.allValues,
    required this.allFilters,
    required this.totalPrice,
  });

  final RxList<Doping> dopingFilters;
  final RxList allValues;
  final RxList allFilters;
  final RxInt totalPrice;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        shrinkWrap: true,
        itemCount: dopingFilters.length,
        separatorBuilder: (context, index) => Direction.vertical.spacer(2),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.SHY_MOMENT.withOpacity(.1),
                  border: Border.all(
                      color: AppColors.SHY_MOMENT.withOpacity(.3), width: 1),
                  borderRadius: AppBorderRadius.inputRadius,
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dopingFilters[index].filterName,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: 13.sp),
                      ),
                      Direction.vertical.spacer(.5),
                      Text(
                        dopingFilters[index].filterDesc,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.SHY_MOMENT,
                              fontSize: 8.sp,
                              fontFamily: AppFonts.light,
                            ),
                      ),
                      Direction.vertical.spacer(.5),
                    ],
                  ),
                  minLeadingWidth: 20.w,
                  leading: SizedBox(
                    width: 20.w,
                    child: CachedNetworkImage(
                      imageUrl:
                          "${dotenv.env["BASE_URL"]}${dopingFilters[index].filterPic}",
                      errorWidget: (context, url, error) =>
                          Images.noImages.pngWithScale,
                    ),
                  ),
                  subtitle: SizedBox(
                    height: 4.h,
                    child: CustomDropdownFieldWithList(
                      value:
                          allValues[allFilters.length + index].split("||")[0],
                      items: dopingFilters[index]
                          .filterChoises
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem(
                              value: value,
                              onTap: () {
                                if (allValues[allFilters.length + index] !=
                                    "Yok") {
                                  totalPrice.value -= int.parse(
                                    allValues[allFilters.length + index]
                                        .split("||")[0]
                                        .split("₺")
                                        .last
                                        .split(",")
                                        .first,
                                  );
                                }
                                if (value == "Yok") {
                                  allValues[allFilters.length + index] = "Yok";
                                  return;
                                }
                                if (value != "Yok" ||
                                    allValues[allFilters.length + index] ==
                                        "Yok") {
                                  if (value.contains("Hediye Doping")) {
                                    allValues[allFilters.length + index] =
                                        "${value.split("-").first}-₺0||${dopingFilters[index].fieldsValues[dopingFilters[index].filterChoises.indexOf(value)]}";
                                  } else {
                                    allValues[allFilters.length + index] =
                                        "$value||${dopingFilters[index].fieldsValues[dopingFilters[index].filterChoises.indexOf(value)]}";
                                    totalPrice.value += int.parse(
                                        value.split("₺").last.split(",").first);
                                  }
                                }
                              },
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 2.w,
                right: 2.w,
                child: Bounceable(
                  onTap: () {
                    Get.dialog(
                      Center(
                        child: SizedBox(
                          width: 80.w,
                          child: Material(
                            color: AppColors.WHITE,
                            borderRadius: AppBorderRadius.inputRadius,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dopingFilters[index].filterName,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  Direction.vertical.spacer(1),
                                  Text(
                                    dopingFilters[index].filterDesc,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Direction.vertical.spacer(1),
                                  SizedBox(
                                    width: 80.w,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${dotenv.env["BASE_URL"]}${dopingFilters[index].filterShowcasePic}",
                                      progressIndicatorBuilder:
                                          (context, url, progress) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                            color: AppColors.ASHENVALE_NIGHTS,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          Images.noImages.pngWithScale,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.visibility,
                    color: AppColors.ASHENVALE_NIGHTS,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
