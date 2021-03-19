import 'package:badfood/controllers/color_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackBar textSnackBar(BuildContext context, String content) {
  final ColorThemeController _colorThemeController =
      Get.find<ColorThemeController>();

  return SnackBar(
    content: SizedBox(
      height: 200.0,
      child: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText1,
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
    duration: const Duration(milliseconds: 1250),
    backgroundColor: _colorThemeController.colorTheme.color5,
  );
}
