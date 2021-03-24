import 'package:color_converter/color_converter.dart';

void main() {
  final rgbColor = RGB(r: 234, g: 235, b: 120);
  print(rgbColor.toString());
  print(rgbColor.toHex());
  print(rgbColor.toCmyk());
  print(rgbColor.toHsb());
  print(rgbColor.toHsl());
  print(rgbColor.toLab());
  print(rgbColor.toXyz());
  print(rgbColor == CMYK(c: 0, m: 0, y: 49, k: 8));
}
