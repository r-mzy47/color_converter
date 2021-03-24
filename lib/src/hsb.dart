import 'dart:math';
import 'rgb.dart';
import 'cmyk.dart';
import 'hsl.dart';
import 'lab.dart';
import 'xyz.dart';
import 'package:color_converter/src/base_color.dart';
import 'package:flutter/foundation.dart';

class HSB extends BaseColor {
  double h;
  double s;
  double b;

  HSB({
    @required this.h,
    @required this.s,
    @required this.b,
  });

  HSB.fromHex(String hex) {
    final values = hex.replaceAll('#', '').split('');

    final _r = int.parse(values[0].toString() + values[1].toString(), radix: 16);
    final _g = int.parse(values[2].toString() + values[3].toString(), radix: 16).toDouble();
    final _b = int.parse(values[4].toString() + values[5].toString(), radix: 16);

    final _maximum = max(max(_r, _g), _b);
    final _minimum = min(_r, min(_g, _b));

    final _d = _maximum - _minimum;
    final _s = _maximum == 0 ? 0 : _d / _maximum;

    final _v = _maximum / 255;

    double _h;

    if (_maximum == _minimum) {
      _h = 0;
    } else if (_maximum == _r) {
      _h = (_g - _b) + _d * (_g < _b ? 6 : 0);
      _h /= 6 * _d;
    } else if (_maximum == _g) {
      _h = (_b - _r) + _d * 2;
      _h /= 6 * _d;
    } else if (_maximum == _b) {
      _h = (_r - _g) + _d * 4;
      _h /= 6 * _d;
    }

    h = (_h * 3600).roundToDouble() / 10;
    s = (_s * 1000).roundToDouble() / 10;
    b = (_v * 1000).roundToDouble() / 10;
  }

  @override
  String toString() {
    return 'h: $h, s: $s, b: $b';
  }

  @override
  String toHex() {
    var _r, _g, _b, _i, _f, _p, _q, _t;
    final _h = h / 360;
    final _s = s / 100;
    final _v = b / 100;
    _i = (_h * 6).floor();
    _f = _h * 6 - _i;
    _p = _v * (1 - _s);
    _q = _v * (1 - _f * _s);
    _t = _v * (1 - (1 - _f) * _s);
    switch (_i % 6) {
      case 0:
        _r = _v;
        _g = _t;
        _b = _p;
        break;
      case 1:
        _r = _q;
        _g = _v;
        _b = _p;
        break;
      case 2:
        _r = _p;
        _g = _v;
        _b = _t;
        break;
      case 3:
        _r = _p;
        _g = _q;
        _b = _v;
        break;
      case 4:
        _r = _t;
        _g = _p;
        _b = _v;
        break;
      case 5:
        _r = _v;
        _g = _p;
        _b = _q;
        break;
    }
    Function toHex = (double x) {
      var hex = (x * 255).round().toRadixString(16);
      return hex.length == 1 ? '0' + hex : hex;
    };
    return "#" + toHex(_r) + toHex(_g) + toHex(_b);
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

  XYZ toXyz() {
    return XYZ.fromHex(toHex());
  }
}
