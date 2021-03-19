import 'dart:async';
import 'package:badfood/controllers/map_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:badfood/controllers/color_theme_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController = Completer();

  final ColorThemeController _colorThemeController =
      Get.find<ColorThemeController>();
  final MapPageController _mapPageController = Get.put(MapPageController());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: GoogleMap(
          markers: Set.from(_mapPageController.marker),
          scrollGesturesEnabled: _mapPageController.enable.value,
          zoomControlsEnabled: false,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) async {
            _mapController.complete(controller);

            final GoogleMapController _tmpController =
                await _mapController.future;
            await _mapPageController.locate(controller: _tmpController);

            await _mapPageController.resetMarkers(context);
          },
          onTap: (LatLng place) {},
        ),
        floatingActionButton: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    bottom: 24.0,
                  ),
                  child: Transform.scale(
                    scale: 1.1,
                    child: FloatingActionButton(
                      heroTag: null,
                      foregroundColor: Colors.white70,
                      backgroundColor: _colorThemeController.colorTheme.color4,
                      splashColor: _colorThemeController.colorTheme.color5,
                      onPressed: () async {
                        final GoogleMapController _tmpController =
                            await _mapController.future;

                        final LatLngBounds _currentPos =
                            await _tmpController.getVisibleRegion();
                        final double _zoom =
                            await _tmpController.getZoomLevel();

                        _tmpController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                  (_currentPos.northeast.latitude +
                                          _currentPos.southwest.latitude) /
                                      2,
                                  (_currentPos.northeast.longitude +
                                          _currentPos.southwest.longitude) /
                                      2),
                              zoom: _zoom + 1,
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    bottom: 24.0,
                  ),
                  child: Transform.scale(
                    scale: 1.1,
                    child: FloatingActionButton(
                      heroTag: null,
                      foregroundColor: Colors.white70,
                      backgroundColor: _colorThemeController.colorTheme.color4,
                      splashColor: _colorThemeController.colorTheme.color5,
                      onPressed: () async {
                        final GoogleMapController _tmpController =
                            await _mapController.future;

                        final LatLngBounds _currentPos =
                            await _tmpController.getVisibleRegion();
                        final double _zoom =
                            await _tmpController.getZoomLevel();

                        _tmpController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                  (_currentPos.northeast.latitude +
                                          _currentPos.southwest.latitude) /
                                      2,
                                  (_currentPos.northeast.longitude +
                                          _currentPos.southwest.longitude) /
                                      2),
                              zoom: _zoom - 1,
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    bottom: 24.0,
                  ),
                  child: Transform.scale(
                    scale: 1.1,
                    child: FloatingActionButton(
                      heroTag: null,
                      foregroundColor: Colors.white70,
                      backgroundColor: _colorThemeController.colorTheme.color4,
                      splashColor: _colorThemeController.colorTheme.color5,
                      onPressed: () async {
                        await _mapPageController.resetMarkers(context);
                        final GoogleMapController _tmpController =
                            await _mapController.future;
                        await _mapPageController.locate(
                          controller: _tmpController,
                        );
                      },
                      child: const Icon(Icons.location_searching),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
