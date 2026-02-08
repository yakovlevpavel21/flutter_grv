import 'dart:ui';
import 'package:equatable/equatable.dart';

class ColorModel extends Equatable {
  final int id;
  final String name;
  final String rgb;

  const ColorModel({
    required this.id,
    required this.name,
    required this.rgb,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      id: json['id'],
      name: json['name'],
      rgb: json['rgb'],
    );
  }

  @override
  List<Object?> get props => [id, name, rgb];

  Color toFlutterColor() {
    return Color(int.parse(rgb, radix: 16) + 0xFF000000);
  }
}