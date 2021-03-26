import 'dart:convert';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/predicted_place.dart';
import 'package:badfood/services/get_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<PredictedPlace> getPredictPlace(String queryString) async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();

  final Position currentLocation = await getLocation();

  final http.Response response = await http.get(
    Uri.https(
      'badfoodapi.ncuuccu.online',
      'v1/forwardPlaceAPI/query',
      currentLocation == null
          ? {
              "q": queryString,
            }
          : {
              "lat": currentLocation.latitude.toString(),
              "lng": currentLocation.longitude.toString(),
              "q": queryString,
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

  return PredictedPlace.fromJson(result);
}
