import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  debugPrint("Getting Location");

  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      debugPrint("Location permissions are denied.");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    debugPrint(
        "Location permissions are permanently denied, we cannot request permissions.");
  }

  final Position position = await Geolocator.getCurrentPosition();

  debugPrint("Location Get");
  return position;
}
