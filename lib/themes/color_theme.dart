import 'package:flutter/material.dart';

class ColorTheme {
  Color _color1, _color2, _color3, _color4, _color5;

  ColorTheme({
    Color color1,
    Color color2,
    Color color3,
    Color color4,
    Color color5,
  })  : _color1 = color1 ?? const Color(0xffffffff),
        _color2 = color2 ?? const Color(0xffffd166),
        _color3 = color3 ?? const Color(0xffFFF8E4),
        _color4 = color4 ?? const Color(0xff26547c),
        _color5 = color5 ?? const Color(0xffef476f);

  Color get color1 => _color1;
  Color get color2 => _color2;
  Color get color3 => _color3;
  Color get color4 => _color4;
  Color get color5 => _color5;

  void setColor({
    Color color1,
    Color color2,
    Color color3,
    Color color4,
    Color color5,
  }) {
    _color1 = color1 ?? const Color(0xffffffff);
    _color2 = color2 ?? const Color(0xffffd166);
    _color3 = color3 ?? const Color(0xffFFF8E4);
    _color4 = color4 ?? const Color(0xff26547c);
    _color5 = color5 ?? const Color(0xffef476f);
  }
}
