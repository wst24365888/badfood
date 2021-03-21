import 'dart:convert';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/backend_user_info.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<BackendUserInfo> getUserInfo() async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();

  final http.Response response = await http.get(
    Uri.http(
      '172.18.74.113:8080',
      'user',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${_userInfoController.bearerToken}',
    },
  );

  final Map<String, dynamic> result =
      jsonDecode(response.body) as Map<String, dynamic>;

  return BackendUserInfo.fromJson(result);
}
