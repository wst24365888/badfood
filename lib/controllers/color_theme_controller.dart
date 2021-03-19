import 'package:badfood/themes/color_theme.dart';
import 'package:get/get.dart';

class ColorThemeController extends GetxController {
  final Rx<ColorTheme> _colorTheme = ColorTheme().obs;

  ColorTheme get colorTheme => _colorTheme.value;
}
