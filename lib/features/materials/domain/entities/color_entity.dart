import 'package:flutter/material.dart';

class ColorEntity {
  final int id;
  final String name;
  final Color color;

  ColorEntity({
    required this.id,
    required this.name,
    required this.color,
  });

  ColorEntity copyWith({
    int? id,
    String? name,
    Color? color,
  }) {
    return ColorEntity(
      id: id ?? this.id, 
      name: name ?? this.name, 
      color: color ?? this.color, 
    );
  }
}