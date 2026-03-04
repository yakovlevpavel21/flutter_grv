import 'package:flutter/material.dart';
import 'package:grv/features/materials/domain/entities/color_entity.dart';

class ColorModel extends ColorEntity {
  ColorModel({
    required super.id, 
    required super.name, 
    required super.color,
  });

  factory ColorModel.fromJson(Map<String, dynamic>? json) {
    return ColorModel(
      id: json?['id'] ?? -1, 
      name: json?['name'] ?? 'Null', 
      color: _rgbToColor(json?['rgb'] ?? 'FF0AF8'), 
    );
  }
}

Color _rgbToColor(String rgb) {
  return Color(int.parse(rgb, radix: 16) + 0xFF000000);
}