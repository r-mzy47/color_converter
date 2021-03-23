import 'package:color_converter/src/base_color.dart';
import 'package:test/test.dart';
import 'package:color_converter/color_converter.dart';

void main() {

  group("RGB - ", () {
    test('hex to hex', () {
      final initialHex = "#faf345";
      final rgb = RGB.fromHex(initialHex);
      final hex = rgb.toHex();
      expect(hex, initialHex);
    });
    test('rgb to hex', () {
      final rgb = RGB(r: 10, g: 9, b: 8);
      final hex = rgb.toHex();
      expect(hex, "#0a0908");
    });
  });

  // rgb is used as standard for the rest of tests

  group("CMYK - ", () {
    final initialHex = "#faf345";
    test('hex to hex', () {
      final cmyk = CMYK.fromHex(initialHex);
      expect(cmyk, RGB.fromHex(initialHex));
    });
    test('cmyk to hex', () {
      final cmyk = CMYK(c: 7, m: 21, y: 0, k: 36);
      expect(cmyk, RGB.fromHex("#9782a3"));
    });
  });

  group("HSB - ", () {
    final initialHex = "#faf345";
    test('hex to hex', () {
      final hsb = HSB.fromHex(initialHex);
      expect(hsb, RGB.fromHex(initialHex));
    });
    test('hsb to hex', () {
      final hsb = HSB(h: 278, s: 20, b: 64);
      expect(hsb, RGB.fromHex("#9782a3"));
    });
  });

  group("HSL - ", () {
    final initialHex = "#faf345";
    test('hex to hex', () {
      final hsl = HSL.fromHex(initialHex);
      expect(hsl, RGB.fromHex(initialHex));
    });
    test('hsl to hex', () {
      final hsl = HSL(h: 278, s: 15, l: 57);
      expect(hsl, RGB.fromHex("#9782a3"));
    });
  });

  group("LAB - ", () {
    final initialHex = "#faf345";
    test('hex to hex', () {
      final lab = LAB.fromHex(initialHex);
      expect(lab, RGB.fromHex(initialHex));
    });
    test('lab to hex', () {
      final lab = LAB(l: 57.259, a: 14.345, b:-14.588);
      expect(lab, RGB.fromHex("#9782a3"));
    });
  });

  group("XYZ - ", () {
    final initialHex = "#faf345";
    test('hex to hex', () {
      final xyz = XYZ.fromHex(initialHex);
      expect(xyz, RGB.fromHex(initialHex));
    });
    test('xyz to hex', () {
      final xyz = XYZ(x: 27.355, y: 25.189, z: 38.069);
      expect(xyz, RGB.fromHex("#9782a3"));
    });
  });
}
