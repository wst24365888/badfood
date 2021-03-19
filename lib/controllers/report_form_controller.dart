import 'package:badfood/models/report_form.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReportFormController extends GetxController {
  final Rx<ReportForm> _reportForm = ReportForm().obs;

  ReportForm get reportForm => _reportForm.value;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController symptonController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  void onChangeTitle(String s) {
    _reportForm.value.titleText = s;

    if (_reportForm.value.titleText.isEmpty) {
      _titleError.value = true;
    } else {
      _titleError.value = false;
    }
  }

  // ignore: use_setters_to_change_properties
  void onCahngeDate(String s) {
    _reportForm.value.dateText = s;
  }

  // ignore: use_setters_to_change_properties
  void onChangeTime(String s) {
    _reportForm.value.timeText = s;
  }

  void onChangePlace(String s) {
    _reportForm.value.placeText = s;
    _reportForm.value.placeID = "";

    if (_reportForm.value.placeText.length < 2 ||
        _reportForm.value.placeID.isEmpty) {
      _placeError.value = true;
    } else {
      _placeError.value = false;
    }
  }

  void onChangeSymptom(String s) {
    _reportForm.value.symptomText = s;

    if (_reportForm.value.symptomText.length < 15) {
      _symptomError.value = true;
    } else {
      _symptomError.value = false;
    }
  }

  // ignore: use_setters_to_change_properties
  void onChangeNote(String s) {
    _reportForm.value.noteText = s;
  }

  // ignore: use_setters_to_change_properties
  void setPlaceID(String s) {
    _reportForm.value.placeID = s;

    _placeError.value = false;
  }

  void addPhotoPath(String s) {
    _reportForm.value.photoPaths == null
        ? _reportForm.value.photoPaths = [s]
        : _reportForm.value.photoPaths.add(s);
  }

  void reset() {
    _reportForm.value = ReportForm();
  }

  final RxBool _titleError = false.obs;
  final RxBool _placeError = false.obs;
  final RxBool _symptomError = false.obs;

  bool get titleError => _titleError.value;
  bool get placeError => _placeError.value;
  bool get symptomError => _symptomError.value;
}
