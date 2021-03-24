import 'dart:math';
import 'rgb.dart';
import 'cmyk.dart';
import 'hsl.dart';
import 'lab.dart';
import 'hsb.dart';
import 'package:color_converter/src/base_color.dart';
import 'package:flutter/foundation.dart';

class XYZ extends BaseColor {
  double x;
  double y;
  double z;

  XYZ({
    @required this.x,
    @required this.y,
    @required this.z,
  });

  XYZ.fromHex(String hex) {
    final values = hex.replaceAll('#', '').split('');

    double _r =
        int.parse(values[0].toString() + values[1].toString(), radix: 16) / 255;
    double _g =
        int.parse(values[2].toString() + values[3].toString(), radix: 16) / 255;
    double _b =
        int.parse(values[4].toString() + values[5].toString(), radix: 16) / 255;

    _r = _r <= 0.04045 ? _r / 12.92 : pow((_r + 0.055) / 1.055, 2.4);
    _g = _g <= 0.04045 ? _g / 12.92 : pow((_g + 0.055) / 1.055, 2.4);
    _b = _b <= 0.04045 ? _b / 12.92 : pow((_b + 0.055) / 1.055, 2.4);

    x = (0.4124 * _r + 0.3576 * _g + 0.1805 * _b) * 100;
    y = (0.2126 * _r + 0.7152 * _g + 0.0722 * _b) * 100;
    z = (0.0193 * _r + 0.1192 * _g + 0.9505 * _b) * 100;
  }

  @override
  String toString() {
    return 'x: $x, y: $y, z: $z';
  }

  @override
  String toHex() {
    double _x = x / 100;
    double _y = y / 100;
    double _z = z / 100;

    double _r = _x * 3.2406 + _y * -1.5372 + _z * -0.4986;
    double _g = _x * -0.9689 + _y * 1.8758 + _z * 0.0415;
    double _b = _x * 0.0557 + _y * -0.2040 + _z * 1.0570;

    _r = _r > 0.0031308 ? 1.055 * pow(_r, 1 / 2.4) - 0.055 : _r * 12.92;
    _g = _g > 0.0031308 ? 1.055 * pow(_g, 1 / 2.4) - 0.055 : _g * 12.92;
    _b = _b > 0.0031308 ? 1.055 * pow(_b, 1 / 2.4) - 0.055 : _b * 12.92;

    Function toHex = (double x) {
      var hex = (x * 255).round().toRadixString(16);
      return hex.length == 1 ? '0' + hex : hex;
    };
    return "#" +
        toHex(max(0, min(1, _r)).toDouble()) +
        toHex(max(0, min(1, _g)).toDouble()) +
        toHex(max(0, min(1, _b)).toDouble());
  }

  CMYK toCmyk() {
    return CMYK.fromHex(toHex());
  }

  RGB toRgb() {
    return RGB.fromHex(toHex());
  }

  HSB toHsb() {
    return HSB.fromHex(toHex());
  }

  HSL toHsl() {
    return HSL.fromHex(toHex());
  }

  LAB toLab() {
    return LAB.fromHex(toHex());
  }
}
