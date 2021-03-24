import 'dart:math';
import 'rgb.dart';
import 'hsb.dart';
import 'hsl.dart';
import 'lab.dart';
import 'xyz.dart';
import 'package:color_converter/src/base_color.dart';
import 'package:flutter/foundation.dart';

class CMYK extends BaseColor {
  int c;
  int m;
  int y;
  int k;

  CMYK({
    @required this.c,
    @required this.m,
    @required this.y,
    @required this.k,
  });

  CMYK.fromHex(String hex) {
    final values = hex.replaceAll('#', '').split('');

    final _r =
        int.parse(values[0].toString() + values[1].toString(), radix: 16) / 255;
    final _g =
        int.parse(values[2].toString() + values[3].toString(), radix: 16) / 255;
    final _b =
        int.parse(values[4].toString() + values[5].toString(), radix: 16) / 255;

    final _k = min(1 - _r, min(1 - _g, 1 - _b));

    final _c = _k != 1 ? (1 - _r - _k) / (1 - _k) : 0;
    final _m = _k != 1 ? (1 - _g - _k) / (1 - _k) : 0;
    final _y = _k != 1 ? (1 - _b - _k) / (1 - _k) : 0;

    c = (_c * 100).round();
    m = (_m * 100).round();
    y = (_y * 100).round();
    k = (_k * 100).round();
  }

  @override
  String toString() {
    return 'c: $c, m: $m, y: $y, k: $k';
  }

  @override
  String toHex() {
    double _c = c / 100;
    double _m = m / 100;
    double _y = y / 100;
    double _k = k / 100;
    Function toHex = (double x) {
      var hex = (x * 255).round().toRadixString(16);
      return hex.length == 1 ? '0' + hex : hex;
    };
    return "#" +
        toHex((1 - _c) * (1 - _k)) +
        toHex((1 - _m) * (1 - _k)) +
        toHex((1 - _y) * (1 - _k));
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

  XYZ toXyz() {
    return XYZ.fromHex(toHex());
  }
}
