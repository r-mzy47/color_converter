import 'dart:math';
import 'rgb.dart';
import 'cmyk.dart';
import 'hsb.dart';
import 'hsl.dart';
import 'xyz.dart';
import 'lab.dart';

RGB hexToRgb(String hex) {
  final values = hex.replaceAll('#', '').split('');
  final r = int.parse(values[0].toString() + values[1].toString(), radix: 16);
  final g = int.parse(values[2].toString() + values[3].toString(), radix: 16);
  final b = int.parse(values[4].toString() + values[5].toString(), radix: 16);

  return RGB(
    r: r,
    g: g,
    b: b,
  );
}

HSB hexToHsb(String hex) {
  final rgb = hexToRgb(hex);

  final r = rgb.r;
  final g = rgb.g.toDouble();
  final b = rgb.b;

  final maximum = max(max(r, g), b);
  final minimum = min(r, min(g, b));

  final d = maximum - minimum;
  final s = maximum == 0 ? 0 : d / maximum;

  final v = maximum / 255;

  late double h;

  if (maximum == minimum) {
    h = 0;
  } else if (maximum == r) {
    h = (g - b) + d * (g < b ? 6 : 0);
    h /= 6 * d;
  } else if (maximum == g) {
    h = (b - r) + d * 2;
    h /= 6 * d;
  } else if (maximum == b) {
    h = (r - g) + d * 4;
    h /= 6 * d;
  }

  return HSB(
    h: (h * 3600).roundToDouble() / 10,
    s: (s * 1000).roundToDouble() / 10,
    b: (v * 1000).roundToDouble() / 10,
  );
}

CMYK hexToCmyk(String hex) {
  final rgb = hexToRgb(hex);

  final r = rgb.r / 255;
  final g = rgb.g / 255;
  final b = rgb.b / 255;

  final k = min(1 - r, min(1 - g, 1 - b));

  final c = k != 1 ? (1 - r - k) / (1 - k) : 0;
  final m = k != 1 ? (1 - g - k) / (1 - k) : 0;
  final y = k != 1 ? (1 - b - k) / (1 - k) : 0;

  return CMYK(
    c: (c * 100).round(),
    m: (m * 100).round(),
    y: (y * 100).round(),
    k: (k * 100).round(),
  );
}

HSL hexToHsl(String hex) {
  final rgb = hexToRgb(hex);

  final r = rgb.r / 255;
  final g = rgb.g / 255;
  final b = rgb.b / 255;

  final maxN = max(r, max(g, b));
  final minN = min(r, min(g, b));

  final l = (maxN + minN) / 2;
  double h = 0, s = 0;

  if (maxN == minN) {
    h = s = 0;
  } else {
    final d = maxN - minN;
    s = l > 0.5 ? d / (2 - maxN - minN) : d / (maxN + minN);

    if (maxN == r) {
      h = (g - b) / d + (g < b ? 6 : 0);
    } else if (maxN == g) {
      h = (b - r) / d + 2;
    } else if (maxN == b) {
      h = (r - g) / d + 4;
    }

    h = h * 6;
  }

  return HSL(
    h: (h * 100).roundToDouble() / 10,
    s: (s * 1000).roundToDouble() / 10,
    l: (l * 1000).roundToDouble() / 10,
  );
}

XYZ hexToXyz(hex) {
  final rgb = hexToRgb(hex);

  final r = rgb.r / 255;
  final g = rgb.g / 255;
  final b = rgb.b / 255;

  final x = (0.4124 * r + 0.3576 * g + 0.1805 * b) * 100;
  final y = (0.2126 * r + 0.7152 * g + 0.0722 * b) * 100;
  final z = (0.0193 * r + 0.1192 * g + 0.9505 * b) * 100;

  return XYZ(x: x, y: y, z: z);
}

LAB hexToLab(String hex) {
  RGB rgbColor = hexToRgb(hex);

  double r = rgbColor.r / 255,
      g = rgbColor.g / 255,
      b = rgbColor.b / 255,
      x,
      y,
      z;

  r = (r > 0.04045) ? pow((r + 0.055) / 1.055, 2.4) as double : r / 12.92;
  g = (g > 0.04045) ? pow((g + 0.055) / 1.055, 2.4) as double : g / 12.92;
  b = (b > 0.04045) ? pow((b + 0.055) / 1.055, 2.4) as double : b / 12.92;

  x = (r * 0.4124 + g * 0.3576 + b * 0.1805) / 0.95047;
  y = (r * 0.2126 + g * 0.7152 + b * 0.0722) / 1.00000;
  z = (r * 0.0193 + g * 0.1192 + b * 0.9505) / 1.08883;

  x = (x > 0.008856) ? pow(x, 1 / 3) as double : (7.787 * x) + 16 / 116;
  y = (y > 0.008856) ? pow(y, 1 / 3) as double : (7.787 * y) + 16 / 116;
  z = (z > 0.008856) ? pow(z, 1 / 3) as double : (7.787 * z) + 16 / 116;

  return LAB(
    l: ((116 * y - 16) * 10).roundToDouble() / 10,
    a: (500 * (x - y) * 10).roundToDouble() / 10,
    b: (200 * (y - z) * 10).roundToDouble() / 10,
  );
}

String hslToHex(HSL color) {
  final h = color.h / 360;
  final s = color.s / 100;
  final l = color.l / 100;
  var r, g, b;
  if (s == 0) {
    r = g = b = l; // achromatic
  } else {
    Function hue2rgb = (double p, double q, double t) {
      if (t < 0) t += 1;
      if (t > 1) t -= 1;
      if (t < 1 / 6) return p + (q - p) * 6 * t;
      if (t < 1 / 2) return q;
      if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
      return p;
    };
    var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    var p = 2 * l - q;
    r = hue2rgb(p, q, h + 1 / 3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1 / 3);
  }
  Function toHex = (double x) {
    var hex = (x * 255).round().toRadixString(16);
    return hex.length == 1 ? '0' + hex : hex;
  };
  return "#" + toHex(r) + toHex(g) + toHex(b);
}

String rgbToHex(RGB color) {
  Function toHex = (int x) {
    var hex = x.toRadixString(16);
    return hex.length == 1 ? '0' + hex : hex;
  };
  return "#" + toHex(color.r) + toHex(color.g) + toHex(color.b);
}

String hsbToHex(HSB hsb) {
  var r, g, b, i, f, p, q, t;
  final h = hsb.h / 360;
  final s = hsb.s / 100;
  final v = hsb.b / 100;
  i = (h * 6).floor();
  f = h * 6 - i;
  p = v * (1 - s);
  q = v * (1 - f * s);
  t = v * (1 - (1 - f) * s);
  switch (i % 6) {
    case 0:
      r = v;
      g = t;
      b = p;
      break;
    case 1:
      r = q;
      g = v;
      b = p;
      break;
    case 2:
      r = p;
      g = v;
      b = t;
      break;
    case 3:
      r = p;
      g = q;
      b = v;
      break;
    case 4:
      r = t;
      g = p;
      b = v;
      break;
    case 5:
      r = v;
      g = p;
      b = q;
      break;
  }
  Function toHex = (double x) {
    var hex = (x * 255).round().toRadixString(16);
    return hex.length == 1 ? '0' + hex : hex;
  };
  return "#" + toHex(r) + toHex(g) + toHex(b);
}

String cmykToHex(CMYK cmyk) {
  double c = cmyk.c / 100;
  double m = cmyk.m / 100;
  double y = cmyk.y / 100;
  double k = cmyk.k / 100;
  Function toHex = (double x) {
    var hex = (x * 255).round().toRadixString(16);
    return hex.length == 1 ? '0' + hex : hex;
  };
  return "#" +
      toHex((1 - c) * (1 - k)) +
      toHex((1 - m) * (1 - k)) +
      toHex((1 - y) * (1 - k));
}

String labToHex(LAB lab) {
  double y = (lab.l + 16) / 116,
      x = lab.a / 500 + y,
      z = y - lab.b / 200,
      r,
      g,
      b;

  x = 0.95047 * ((x * x * x > 0.008856) ? x * x * x : (x - 16 / 116) / 7.787);
  y = 1.00000 * ((y * y * y > 0.008856) ? y * y * y : (y - 16 / 116) / 7.787);
  z = 1.08883 * ((z * z * z > 0.008856) ? z * z * z : (z - 16 / 116) / 7.787);

  r = x * 3.2406 + y * -1.5372 + z * -0.4986;
  g = x * -0.9689 + y * 1.8758 + z * 0.0415;
  b = x * 0.0557 + y * -0.2040 + z * 1.0570;

  r = (r > 0.0031308) ? (1.055 * pow(r, 1 / 2.4) - 0.055) : 12.92 * r;
  g = (g > 0.0031308) ? (1.055 * pow(g, 1 / 2.4) - 0.055) : 12.92 * g;
  b = (b > 0.0031308) ? (1.055 * pow(b, 1 / 2.4) - 0.055) : 12.92 * b;

  Function toHex = (double x) {
    var hex = (x * 255).round().toRadixString(16);
    return hex.length == 1 ? '0' + hex : hex;
  };
  return "#" +
      toHex(max(0, min(1, r)).toDouble()) +
      toHex(max(0, min(1, g)).toDouble()) +
      toHex(max(0, min(1, b)).toDouble());
}