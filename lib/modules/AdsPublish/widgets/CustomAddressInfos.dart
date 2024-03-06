// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:ilkbizde/modules/AdsPublish/AdsPublishController.dart';
import 'package:ilkbizde/shared/constants/index.dart';
import 'package:ilkbizde/shared/widgets/index.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

class CustomAddressInfos extends StatelessWidget {
  final AdsPublishController controller;

  const CustomAddressInfos({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isSatellite = false.obs;
    return Obx(
      () => Stack(
        children: [
          SizedBox(
            width: 100.w,
            height: 80.h,
            child: FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                onTap: (tapPosition, point) async {
                  controller.getAddressInfosFromMarker(point);
                  CustomManuelAddressBottomSheet(context);
                  controller.currentLocation = point;
                  controller.markers.value = [
                    Marker(
                      point: point,
                      child: Icon(
                        Icons.location_on,
                        size: 10.w,
                        color: AppColors.ASHENVALE_NIGHTS,
                      ),
                    ),
                  ];
                },
                interactionOptions: const InteractionOptions(
                  rotationWinGestures: MultiFingerGesture.none,
                ),
                initialCenter: controller.currentLocation != const LatLng(0, 0)
                    ? controller.currentLocation
                    : controller.allValues[1] == "Pasif"
                        ? const LatLng(37.8785065, 32.5064825)
                        : const LatLng(39.0876459, 35.1293295),
                initialZoom: 10,
              ),
              children: [
                Obx(
                  () => TileLayer(
                    urlTemplate: isSatellite.value
                        ? "https://mt.google.com/vt/lyrs=s&x={x}&y={y}&z={z}"
                        : "https://mt.google.com/vt/lyrs=r&x={x}&y={y}&z={z}",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                ),
                MarkerLayer(
                  rotate: true,
                  markers: controller.markers.toList(),
                ),
              ],
            ),
          ),
          // controller.interactiveFlag.value == InteractiveFlag.all
          //     ? Positioned(
          //         bottom: 1.h,
          //         right: 5.w,
          //         child: Column(
          //           children: [
          //             Bounceable(
          //               onTap: () {
          //                 isSatellite.toggle();
          //               },
          //               child: Container(
          //                 padding: EdgeInsets.all(8.sp),
          //                 decoration: BoxDecoration(
          //                   color: AppColors.BLUE_RIBBON,
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Obx(
          //                   () => Icon(
          //                     isSatellite.value
          //                         ? Icons.width_normal_outlined
          //                         : Icons.satellite_alt_outlined,
          //                     color: AppColors.WHITE,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Direction.vertical.spacer(1),
          //             Bounceable(
          //               onTap: () {
          //                 controller.interactiveFlag.value =
          //                     InteractiveFlag.none;
          //               },
          //               child: Container(
          //                 padding: EdgeInsets.all(8.sp),
          //                 decoration: BoxDecoration(
          //                   color: AppColors.BLUE_RIBBON,
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Icon(
          //                   Icons.close,
          //                   color: AppColors.WHITE,
          //                   size: 6.w,
          //                 ),
          //               ),
          //             ),
          //             Direction.vertical.spacer(1),
          //             Bounceable(
          //               onTap: () {
          //                 controller.interactiveFlag.value =
          //                     InteractiveFlag.none;
          //                 controller.markers.value = [];
          //                 controller.currentLocation = LatLng(0, 0);
          //               },
          //               child: Container(
          //                 padding: EdgeInsets.all(8.sp),
          //                 decoration: BoxDecoration(
          //                   color: AppColors.BLUE_RIBBON,
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Icon(
          //                   Icons.wrong_location_outlined,
          //                   color: AppColors.WHITE,
          //                   size: 6.w,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     :
          Positioned(
            left: 5.w,
            right: 5.w,
            bottom: 5.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: "Mevcut Konumu Kullan",
                  bg: AppColors.BLUE_RIBBON,
                  onTap: () {
                    controller.getCurrentLocation().then((value) {
                      if (value != null) {
                        LatLng point = LatLng(value.latitude, value.longitude);
                        controller.mapController.move(point, 13.0);
                        controller.getAddressInfosFromMarker(point);
                        CustomManuelAddressBottomSheet(context);
                        controller.currentLocation = point;
                        controller.markers.value = [
                          Marker(
                            point: point,
                            child: Icon(
                              Icons.location_on,
                              size: 10.w,
                              color: AppColors.ASHENVALE_NIGHTS,
                            ),
                          ),
                        ];
                      } else {
                        controller.mapController
                            .move(const LatLng(37.874634, 32.493027), 13.0);
                      }
                    });
                  },
                  hasIcon: true,
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.WHITE,
                  ),
                  textStyle: const TextStyle(
                    fontFamily: AppFonts.medium,
                    fontSize: 14,
                    color: AppColors.WHITE,
                  ),
                ),
                Direction.vertical.spacer(2),
                CustomButton(
                  title: "Kendim Seçmek İstiyorum",
                  bg: AppColors.WHITE,
                  onTap: () async {
                    if (controller.allValues[1] == "Pasif") {
                      await controller.getCities(
                          countryCode: "TR", cityId: "53");
                      controller.selectedCity.value = "Konya";
                    }
                    CustomManuelAddressBottomSheet(
                      context,
                      isEnabled:
                          controller.allValues[1] == "Pasif" ? false : true,
                    );
                  },
                  hasIcon: true,
                  textStyle: const TextStyle(
                    fontFamily: AppFonts.medium,
                    fontSize: 14,
                    color: AppColors.BLUE_RIBBON,
                  ),
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.BLUE_RIBBON,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> CustomManuelAddressBottomSheet(BuildContext context,
      {bool isEnabled = true}) {
    return Get.bottomSheet(
      Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 1.5.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: AppBorderRadius.inputRadius,
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: AppStrings.country),
                Direction.vertical.spacer(.3),
                // COUNTRY DROPDOWN
                CustomDropdownFieldWithList(
                  value: controller.selectedCountry.value,
                  items: controller.countries
                      .map(
                        (element) => DropdownMenuItem(
                          enabled: isEnabled,
                          onTap: () async {
                            controller.selectedCountry.value = element.name;
                            getLatLng(element.name).then((value) {
                              controller.mapController.move(value, 5.0);
                            });
                            controller.getCities(
                              countryCode: element.code,
                            );
                          },
                          value: element.name,
                          child: Text(
                            element.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: AppStrings.city),
                Direction.vertical.spacer(.3),
                // CITY DROPDOWN
                CustomDropdownFieldWithList(
                  value: controller.selectedCity.value,
                  items: controller.cities
                      .map(
                        (element) => DropdownMenuItem(
                          enabled: isEnabled,
                          onTap: () {
                            controller.selectedCity.value = element.name;
                            getLatLng(
                                    "${controller.selectedCountry.value}, ${element.name}")
                                .then((value) {
                              controller.mapController.move(value, 9.0);
                            });
                            controller.getDistricts(
                              cityId: element.id,
                            );
                          },
                          value: element.name,
                          child: Text(
                            element.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: AppStrings.district),
                Direction.vertical.spacer(.3),
                // DISTRICT DROPDOWN
                CustomDropdownFieldWithList(
                  value: controller.selectedDistrict.value,
                  items: controller.districts
                      .map(
                        (element) => DropdownMenuItem(
                          value: element.name,
                          onTap: () {
                            controller.selectedDistrict.value = element.name;
                            getLatLng(
                                    "${controller.selectedCountry.value}, ${controller.selectedCity.value}, ${element.name}")
                                .then((value) {
                              controller.mapController.move(value, 12.0);
                            });
                            controller.getNeighborhood(
                              districtId: element.id,
                            );
                          },
                          child: Text(
                            element.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Direction.vertical.spacer(1),
                const CustomInputLabel(text: "Mahalle"),
                Direction.vertical.spacer(.3),
                // NEIGHBORHOOD DROPDOWN
                CustomDropdownFieldWithList(
                  value: controller.selectedNeighborhood.value,
                  items: controller.neighborhoods
                      .map(
                        (element) => DropdownMenuItem(
                          value: element.name,
                          onTap: () {
                            controller.selectedNeighborhood.value =
                                element.name;
                            getLatLng(
                                    "${controller.selectedCountry.value}, ${controller.selectedCity.value}, ${controller.selectedDistrict.value}, ${element.name}")
                                .then((value) {
                              controller.mapController.move(value, 15.0);
                            });
                          },
                          child: Text(
                            element.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.OBSIDIAN_SHARD),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Direction.vertical.spacer(2),
                CustomButton(
                  title: "Kaydet",
                  bg: AppColors.ASHENVALE_NIGHTS,
                  onTap: () async {
                    Get.back();
                    LatLng point = await getLatLng(
                        "${controller.selectedCountry.value}, ${controller.selectedCity.value}, ${controller.selectedDistrict.value}, ${controller.selectedNeighborhood.value}");
                    controller.mapController.move(point, 13.0);
                    controller.currentLocation = point;
                    controller.markers.value = [
                      Marker(
                        point: controller.currentLocation,
                        child: Icon(
                          Icons.location_on,
                          size: 10.w,
                          color: AppColors.ASHENVALE_NIGHTS,
                        ),
                      ),
                    ];
                  },
                ),
                Direction.vertical.spacer(3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<LatLng> getLatLng(String address) async {
    GeoCode geoCode = GeoCode();
    try {
      Coordinates coordinates =
          await geoCode.forwardGeocoding(address: address);

      return LatLng(
        coordinates.latitude ?? controller.currentLocation.latitude,
        coordinates.longitude ?? controller.currentLocation.longitude,
      );
    } catch (e) {
      print(e);
    }

    return const LatLng(37.874634, 32.493027);
  }
}
