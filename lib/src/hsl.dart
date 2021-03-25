import 'dart:math';
import 'rgb.dart';
import 'hsb.dart';
import 'cmyk.dart';
import 'lab.dart';
import 'xyz.dart';
import 'package:color_converter/src/base_color.dart';

class HSL extends BaseColor {
  late double h;
  late double s;
  late double l;

  HSL({
    required this.h,
    required this.s,
    required this.l,
  });

  HSL.fromHex(String hex) {
    final values = hex.replaceAll('#', '').split('');
    final _r =
        int.parse(values[0].toString() + values[1].toString(), radix: 16) / 255;
    final _g =
        int.parse(values[2].toString() + values[3].toString(), radix: 16) / 255;
    final _b =
        int.parse(values[4].toString() + values[5].toString(), radix: 16) / 255;

    final maxN = max(_r, max(_g, _b));
    final minN = min(_r, min(_g, _b));

    final _l = (maxN + minN) / 2;
    double _h = 0, _s = 0;

    if (maxN == minN) {
      _h = _s = 0;
    } else {
      final _d = maxN - minN;
      _s = _l > 0.5 ? _d / (2 - maxN - minN) : _d / (maxN + minN);

      if (maxN == _r) {
        _h = (_g - _b) / _d + (_g < _b ? 6 : 0);
      } else if (maxN == _g) {
        _h = (_b - _r) / _d + 2;
      } else if (maxN == _b) {
        _h = (_r - _g) / _d + 4;
      }

      _h = _h * 6;
    }

    h = (_h * 100).roundToDouble() / 10;
    s = (_s * 1000).roundToDouble() / 10;
    l = (_l * 1000).roundToDouble() / 10;
  }

  @override
  String toString() {
    return 'h: $h, s: $s, l: $l';
  }

  @override
  String toHex() {
    final _h = h / 360;
    final _s = s / 100;
    final _l = l / 100;
    var _r, _g, _b;
    if (_s == 0) {
      _r = _g = _b = _l; // achromatic
    } else {
      Function hue2rgb = (double p, double q, double t) {
        if (t < 0) t += 1;
        if (t > 1) t -= 1;
        if (t < 1 / 6) return p + (q - p) * 6 * t;
        if (t < 1 / 2) return q;
        if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
        return p;
      };
      var _q = _l < 0.5 ? _l * (1 + _s) : _l + _s - _l * _s;
      var _p = 2 * _l - _q;
      _r = hue2rgb(_p, _q, _h + 1 / 3);
      _g = hue2rgb(_p, _q, _h);
      _b = hue2rgb(_p, _q, _h - 1 / 3);
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

  LAB toLab() {
    return LAB.fromHex(toHex());
  }

  XYZ toXyz() {
    return XYZ.fromHex(toHex());
  }
}
