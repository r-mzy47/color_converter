import 'dart:math';
import 'rgb.dart';
import 'cmyk.dart';
import 'hsl.dart';
import 'hsb.dart';
import 'xyz.dart';
import 'package:color_converter/src/base_color.dart';
import 'package:flutter/foundation.dart';

class LAB extends BaseColor {
  double l;
  double a;
  double b;

  LAB({
    @required this.l,
    @required this.a,
    @required this.b,
  });

  LAB.fromHex(String hex) {
    final values = hex.replaceAll('#', '').split('');

    double _r =
        int.parse(values[0].toString() + values[1].toString(), radix: 16) / 255;
    double _g =
        int.parse(values[2].toString() + values[3].toString(), radix: 16) / 255;
    double _b =
        int.parse(values[4].toString() + values[5].toString(), radix: 16) / 255;

    double _x, _y, _z;

    _r = (_r > 0.04045) ? pow((_r + 0.055) / 1.055, 2.4) : _r / 12.92;
    _g = (_g > 0.04045) ? pow((_g + 0.055) / 1.055, 2.4) : _g / 12.92;
    _b = (_b > 0.04045) ? pow((_b + 0.055) / 1.055, 2.4) : _b / 12.92;

    _x = (_r * 0.4124 + _g * 0.3576 + _b * 0.1805) / 0.95047;
    _y = (_r * 0.2126 + _g * 0.7152 + _b * 0.0722) / 1.00000;
    _z = (_r * 0.0193 + _g * 0.1192 + _b * 0.9505) / 1.08883;

    _x = (_x > 0.008856) ? pow(_x, 1 / 3) : (7.787 * _x) + 16 / 116;
    _y = (_y > 0.008856) ? pow(_y, 1 / 3) : (7.787 * _y) + 16 / 116;
    _z = (_z > 0.008856) ? pow(_z, 1 / 3) : (7.787 * _z) + 16 / 116;

    l = ((116 * _y - 16) * 10).roundToDouble() / 10;
    a = (500 * (_x - _y) * 10).roundToDouble() / 10;
    b = (200 * (_y - _z) * 10).roundToDouble() / 10;
  }

  @override
  String toString() {
    return 'l: $l, a: $a, b: $b';
  }

  @override
  String toHex() {
    double _y = (l + 16) / 116,
        _x = a / 500 + _y,
        _z = _y - b / 200,
        _r,
        _g,
        _b;

    _x = 0.95047 *
        ((_x * _x * _x > 0.008856) ? _x * _x * _x : (_x - 16 / 116) / 7.787);
    _y = 1.00000 *
        ((_y * _y * _y > 0.008856) ? _y * _y * _y : (_y - 16 / 116) / 7.787);
    _z = 1.08883 *
        ((_z * _z * _z > 0.008856) ? _z * _z * _z : (_z - 16 / 116) / 7.787);

    _r = _x * 3.2406 + _y * -1.5372 + _z * -0.4986;
    _g = _x * -0.9689 + _y * 1.8758 + _z * 0.0415;
    _b = _x * 0.0557 + _y * -0.2040 + _z * 1.0570;

    _r = (_r > 0.0031308) ? (1.055 * pow(_r, 1 / 2.4) - 0.055) : 12.92 * _r;
    _g = (_g > 0.0031308) ? (1.055 * pow(_g, 1 / 2.4) - 0.055) : 12.92 * _g;
    _b = (_b > 0.0031308) ? (1.055 * pow(_b, 1 / 2.4) - 0.055) : 12.92 * _b;

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

  XYZ toXyz() {
    return XYZ.fromHex(toHex());
  }
}
