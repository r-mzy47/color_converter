num abs(num number) => number.abs();

abstract class BaseColor {
  String toHex();

  // ignore: hash_and_equals
  bool operator ==(Object color) {
    if (color is BaseColor) {
      final _v1 = toHex().replaceAll('#', '').split('');

      final _r1 = int.parse(_v1[0].toString() + _v1[1].toString(), radix: 16);
      final _g1 = int.parse(_v1[2].toString() + _v1[3].toString(), radix: 16);
      final _b1 = int.parse(_v1[4].toString() + _v1[5].toString(), radix: 16);

      final _v2 = color.toHex().replaceAll('#', '').split('');

      final _r2 = int.parse(_v2[0].toString() + _v2[1].toString(), radix: 16);
      final _g2 = int.parse(_v2[2].toString() + _v2[3].toString(), radix: 16);
      final _b2 = int.parse(_v2[4].toString() + _v2[5].toString(), radix: 16);

      if (abs(_r1 - _r2) < 3 && abs(_g1 - _g2) < 3 && abs(_b1 - _b2) < 3) {
        return true;
      }
    }
    return false;
  }
}
