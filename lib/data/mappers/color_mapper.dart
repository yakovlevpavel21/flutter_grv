import 'package:grv/data/dtos/color.dart';
import 'package:grv/data/models/color.dart';

extension ColorMapper on ColorDto {
  ColorModel toModel() {
    return ColorModel(
      title: name,
      rgb: rgb,
    );
  }
}