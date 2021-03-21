import 'dart:typed_data';

import 'package:badfood/controllers/report_form_controller.dart';
import 'package:badfood/controllers/user_info_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';

Future<String> submitNewReport() async {
  final UserInfoController _userInfoController = Get.find<UserInfoController>();
  final ReportFormController _reportFormController =
      Get.find<ReportFormController>();

  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer ${_userInfoController.bearerToken}',
  };

  final http.MultipartRequest request = http.MultipartRequest(
    'POST',
    Uri.parse('http://172.18.74.113:8080/v1/reports/store'),
  );

  request.fields.addAll({
    'title': _reportFormController.reportForm.titleText,
    'place_id': _reportFormController.reportForm.placeID,
    'symptom': _reportFormController.reportForm.symptomText,
    if (_reportFormController.reportForm.noteText.isNotEmpty)
      'note': _reportFormController.reportForm.noteText,
    'happened_at':
        '${_reportFormController.reportForm.dateText} ${_reportFormController.reportForm.timeText}'
  });

  for (final String photoPath
      in _reportFormController.reportForm.photoPaths ?? []) {
    final PickedFile photoFile = PickedFile(photoPath);

    final http.ByteStream stream = http.ByteStream(photoFile.openRead());
    stream.cast();

    final Uint8List photoBytes = await photoFile.readAsBytes();

    final int length = photoBytes.length;

    final String mediaType = lookupMimeType(photoPath, headerBytes: photoBytes);

    final http.MultipartFile multipartFile = http.MultipartFile(
      'photos[]',
      stream,
      length,
      filename:
          "${basename(photoFile.path)}.${MediaType.parse(mediaType).subtype}",
      contentType: MediaType.parse(mediaType),
    );

    request.files.add(multipartFile);
  }

  request.headers.addAll(headers);

  final http.StreamedResponse response = await request.send();

  if (response.statusCode.isLowerThan(300)) {
    // debugPrint(await response.stream.bytesToString());

    return "success";
  } else {
    // debugPrint(response.reasonPhrase);

    return response.reasonPhrase;
  }
}
