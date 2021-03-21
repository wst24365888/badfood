import 'dart:convert';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/user_report_history.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<UserReportHistory> getAllReportsByUser() async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();

  final http.Response response = await http.get(
    Uri.https(
      '104.199.232.64',
      'v1/reports/index',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${_userInfoController.bearerToken}',
    },
  );

  final Map<String, dynamic> result =
      jsonDecode(response.body) as Map<String, dynamic>;

  return UserReportHistory.fromJson(result);
}
