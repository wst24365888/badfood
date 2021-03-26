import 'dart:async';
import 'package:badfood/controllers/main_screen_controller.dart';
import 'package:badfood/controllers/report_form_controller.dart';
import 'package:badfood/services/get_marker_icon.dart';
import 'package:badfood/services/get_nearby_stores.dart';
import 'package:badfood/widgets/responsive_ui.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:badfood/services/get_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:badfood/models/reported_stores.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:badfood/controllers/color_theme_controller.dart';

class MapPageController extends GetxController {
  RxBool enable = true.obs;

  final RxList<Marker> _markers = <Marker>[].obs;
  int _markerIDCounter = 0;

  List<Marker> get marker => _markers;

  BitmapDescriptor _icon;

  GoogleMapController _mapController;

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 16,
  );

  Future<void> addMarker(BuildContext context, StoreData storeData) async {
    final ColorThemeController _colorThemeController =
        Get.find<ColorThemeController>();

    _markerIDCounter++;

    _icon ??= await getMarkerIcon(context, 'assets/pin.svg');

    _markers.add(
      Marker(
        icon: _icon,
        markerId: MarkerId("$_markerIDCounter"),
        position: LatLng(storeData.location.lat, storeData.location.lng),
        onTap: () async {
          enable.value = false;

          final Widget mainComponent = Center(
            child: Column(
              children: [
                ExpansionCard(
                  background: Container(
                    height: 280,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/food.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.warning_rounded,
                    size: 64,
                    color:
                        storeData.reportsCount > 5 ? Colors.red : Colors.orange,
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(left: 12, top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          storeData.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _colorThemeController.colorTheme.color1,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // Fixed Spacing
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Has been reported ${storeData.reportsCount} times.",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _colorThemeController.colorTheme.color1,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  children: <Widget>[
                        const SizedBox(
                          height: 12,
                        ),
                      ] +
                      storeData.reports
                          .map((StoreReport report) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 24),
                                      child: Text(
                                        report.happenedAt,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 36,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 24),
                                      child: Text(
                                        report.title,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                          .toList()
                          .sublist(
                            0,
                            storeData.reports.length >= 3
                                ? 3
                                : storeData.reports.length,
                          ),
                ),
                Container(
                  height: 72,
                  color: _colorThemeController.colorTheme.color4,
                  child: GestureDetector(
                    onTap: () {
                      final ReportFormController reportFormController =
                          Get.find<ReportFormController>();
                      reportFormController.reportForm.placeText =
                          storeData.name;
                      reportFormController.reportForm.placeID =
                          storeData.placeId;
                      reportFormController.placeController.text =
                          storeData.name;

                      final MainScreenController mainScreenController =
                          Get.find<MainScreenController>();
                      mainScreenController.currentPage = 0;

                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        "CLICK HERE TO REPORT THE STORE",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );

          final ResponsiveUI responsiveUI = ResponsiveUI(
            mobileUI: SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff2394b0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                  ),
                  child: mainComponent,
                ),
              ),
            ),
            webUI: SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 480,
                  decoration: const BoxDecoration(
                    color: Color(0xff2394b0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                  ),
                  child: mainComponent,
                ),
              ),
            ),
          );

          await showModalBottomSheet(
            useRootNavigator: true,
            elevation: 0,
            barrierColor: Colors.black.withOpacity(0.5),
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                topRight: Radius.circular(45.0),
              ),
            ),
            isScrollControlled:
                true, // won't scroll when keyboard came out if isScrollControlled is set to false
            context: context,
            builder: (context) => responsiveUI.build(context),
          );

          enable.value = true;
        },
      ),
    );
  }

  Future<void> locate({
    GoogleMapController controller,
    LatLng location,
    double zoom = 16,
  }) async {
    _mapController ??= controller;

    LatLng _location;

    if (location == null) {
      final Position currentLocationData = await getLocation();

      if (currentLocationData == null) {
        return;
      }

      _location =
          LatLng(currentLocationData.latitude, currentLocationData.longitude);
    } else {
      _location = location;
    }

    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(_location.latitude, _location.longitude),
      zoom: zoom,
    );

    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> resetMarkers(BuildContext context) async {
    _markers.assignAll(<Marker>[]);

    final ReportedStores _nearbyStores = await getNearbyStores();

    for (final StoreData _storeData in _nearbyStores.data) {
      await addMarker(context, _storeData);
    }
  }
}
