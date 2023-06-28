import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color black90033 = fromHex('#33000000');

  static Color blueGray100 = fromHex('#d2d2d2');

  static Color black900 = fromHex('#000000');

  static Color blueGray400 = fromHex('#888888');

  static Color blueGray300 = fromHex('#80b8a8');

  static Color blueGray10001 = fromHex('#d9d9d9');

  static Color gray900 = fromHex('#242424');

  static Color blueGray700 = fromHex('#326e62');

  static Color black9003f = fromHex('#3f000000');

  static Color whiteA700 = fromHex('#ffffff');

  static Color deepOrange100 = fromHex('#edbcb2');

  static Color red50 = fromHex('#fef2f0');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
