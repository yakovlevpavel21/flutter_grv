import 'package:flutter/material.dart';
import 'package:grv/data/models/color.dart';
import 'package:grv/features/colors/data/models/color_item.dart';

extension ColorToColorUi on ColorModel {
  ColorItemUi toColorUi() {
    return ColorItemUi(
      id: id,
      name: name,
      color: _rgbToColor(rgb),
    );
  }
}

Color _rgbToColor(String rgb) {
  return Color(int.parse(rgb, radix: 16) + 0xFF000000);
}