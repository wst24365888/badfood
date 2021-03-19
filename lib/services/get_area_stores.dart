import 'dart:convert';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/reported_stores.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<ReportedStores> getAreaStores({String cityName}) async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();

  final http.Response response = await http.get(
    Uri.http(
      'localhost:8080',
      'v1/blacklist/index',
      cityName != null
          ? {
              "cityName": cityName,
            }
          : null,
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
