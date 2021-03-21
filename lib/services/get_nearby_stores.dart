import 'dart:convert';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/reported_stores.dart';
import 'package:badfood/services/get_location.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<ReportedStores> getNearbyStores() async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();

  final LocationData currentLocation = await getLocation();

  final http.Response response = await http.post(
    Uri.http(
      '172.18.74.113:8080',
      'v1/Places/nearby',
      {
        "lat": currentLocation.latitude.toString(),
        "lng": currentLocation.longitude.toString(),
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

  return ReportedStores.fromJson(result);
}
