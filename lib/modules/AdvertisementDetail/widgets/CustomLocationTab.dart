// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdvertisementDetail/AdvertisementDetailController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/enum/images.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

class CustomLocationTab extends StatelessWidget {
  const CustomLocationTab({
    super.key,
    required this.controller,
  });

  final AdvertisementDetailController controller;

  @override
  Widget build(BuildContext context) {
    RxBool isSatellite = false.obs;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          controller.location == const LatLng(0, 0)
              ? Column(
                  children: [
                    Direction.vertical.spacer(5),
                    Icon(
                      Icons.not_listed_location_outlined,
                      color: Get.isDarkMode ? null : AppColors.BLACK,
                    ),
                    Direction.vertical.spacer(3),
                    Text(
                      "Konum bilgisi eklenmemiştir.",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Get.isDarkMode ? null : AppColors.BLACK,
                              ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 70.h,
                      child: FlutterMap(
                        options: MapOptions(
                          interactionOptions: const InteractionOptions(
                            rotationWinGestures: MultiFingerGesture.none,
                          ),
                          initialCenter: controller.location,
                          initialZoom: 15,
                        ),
                        children: [
                          Obx(
                            () => TileLayer(
                              retinaMode: true,
                              urlTemplate: isSatellite.value
                                  ? "https://mt.google.com/vt/lyrs=s&x={x}&y={y}&z={z}"
                                  : "https://mt.google.com/vt/lyrs=r&x={x}&y={y}&z={z}",
                              subdomains: const ['a', 'b', 'c'],
                            ),
                          ),
                          MarkerLayer(
                            rotate: true,
                            markers: [
                              Marker(
                                rotate: true,
                                point: controller.location,
                                child: Icon(
                                  Icons.location_on,
                                  size: 25.sp,
                                  color: AppColors.ASHENVALE_NIGHTS,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8.5.h,
                      right: 2.w,
                      child: Bounceable(
                        onTap: () => isSatellite.toggle(),
                        child: Container(
                          width: 7.h,
                          height: 7.h,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.ASHENVALE_NIGHTS,
                            shape: BoxShape.circle,
                          ),
                          child: Obx(
                            () => Icon(
                              isSatellite.value
                                  ? Icons.width_normal_outlined
                                  : Icons.satellite_alt_outlined,
                              color: AppColors.WHITE,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1.h,
                      right: 2.w,
                      child: Bounceable(
                        onTap: () =>
                            controller.getCurrentLocationAndLaunchMap(),
                        child: Container(
                          width: 7.h,
                          height: 7.h,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.ASHENVALE_NIGHTS,
                            shape: BoxShape.circle,
                          ),
                          child: Images.locationIcon.pngWithScale,
                        ),
                      ),
                    ),
                  ],
                ),
          Direction.vertical.spacer(9),
        ],
      ),
    );
  }
}
