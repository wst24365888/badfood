import 'dart:convert';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/services/get_location.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<Map<String, dynamic>> getPredictPlace(String queryString) async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();

  final LocationData currentLocation = await getLocation();

  final http.Response response = await http.get(
    Uri.http(
      'localhost:8080',
      'v1/forwardPlaceAPI/query',
      {
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

  final Map<String, dynamic> empty = {};

  return result.containsKey("message") ? empty : result;
}
