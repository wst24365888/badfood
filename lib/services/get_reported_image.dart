import 'dart:convert';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:badfood/models/reported_image.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<ReportedImage> getReportedImage(String imageID) async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();

  final http.Response response = await http.get(
    Uri.https(
      'badfoodapi.ncuuccu.online',
      'v1/firebase/getImgUrl/$imageID',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${_userInfoController.bearerToken}',
    },
  );

  final Map<String, dynamic> result =
      jsonDecode(response.body) as Map<String, dynamic>;

  return ReportedImage.fromJson(result);
}
