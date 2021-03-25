# color_converter

dart color converter library. suitable for create, convert, and edit colors. It converts all ways between RGB, CMYK, HSB, HSL, XYZ, LAB.

## Installation

1. Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  color_converter: ^0.2.1
```

2. Get the package using your IDE's GUI or via command line with

```bash
$ flutter pub get
```

## Usage

```dart
import 'package:color_converter/color_converter.dart';
```
## Color Spaces

color spaces are RGB, CMYK, HSB, HSL, LAB, and XYZ. represented as [RGB], [CMYK], [HSB], [HSL], [LAB], [XYZ] respectively. extended from [BaseColor] class.

## Creating Colors

Colors can be created by simple constructor or with the [fromHex] named constructor. 

```dart
String hexColor = "#00ff00";

RGB.fromHex(hexColor);
RGB(r: 0, g: 255, b: 0);

CMYK.fromHex(hexColor);
CMYK(c: 100, m: 0, y: 100, k: 0);

HSB.fromHex(hexColor);
HSB(h: 120, s: 100, b: 100);

HSL.fromHex(hexColor);
HSB(h: 120, s: 100, b: 50);

LAB.fromHex(hexColor);
LAB(l: 87.7, a: -86.2, b: 83.2);

XYZ.fromHex(hexColor);
XYZ(x: 35.76, y: 71.52, z: 11.92);
```

## Modify Colors

```dart
String hexColor = "#00ff00";

HSB hsbColor = HSB.fromHex(hexColor);

hsbColor.s = 10;

print(hsbColor);
```

## Convert Colors

```dart
RGB rgbColor = RGB(r: 234, g: 112, b: 45);

HSL hslColor = rgbColor.toHsl();

print(hslColor);

print(rgbColor == hslColor);
```