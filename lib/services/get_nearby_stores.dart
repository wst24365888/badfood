import 'dart:convert';
import 'package:badfood/controllers/map_page_controller.dart';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/reported_stores.dart';
import 'package:badfood/services/get_location.dart';
// import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<ReportedStores> getNearbyStores({LatLng centralPoint}) async {
  // debugPrint("Getting Stores");

  final UserInfoController _userInfoController = Get.find<UserInfoController>();
  final MapPageController _mapPageController = Get.find<MapPageController>();

  Position currentLocation;

  if (centralPoint == null) {
    currentLocation = await getLocation();
  }

  final http.Response response = await http.post(
    Uri.https(
      'badfoodapi.ncuuccu.online',
      'v1/Places/nearby',
      centralPoint != null
          ? {
              "lat": centralPoint.latitude.toString(),
              "lng": centralPoint.longitude.toString(),
            }
          : currentLocation != null
              ? {
                  "lat": currentLocation.latitude.toString(),
                  "lng": currentLocation.longitude.toString(),
                }
              : {
                  "lat":
                      _mapPageController.kGooglePlex.target.latitude.toString(),
                  "lng": _mapPageController.kGooglePlex.target.longitude
                      .toString(),
                },
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${_userInfoController.bearerToken}',
    },
  );

  final Map<String, dynamic> result =
      jsonDecode(response.body) as Map<String, dynamic>;

  // debugPrint("Stores Get");

  return ReportedStores.fromJson(result);
}
