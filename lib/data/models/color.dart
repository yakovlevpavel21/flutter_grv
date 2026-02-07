import 'dart:ui';
import 'package:equatable/equatable.dart';

class ColorModel extends Equatable {
  final String title;
  final String rgb;

  const ColorModel({
    required this.title,
    required this.rgb,
  });

  @override
  List<Object?> get props => [title, rgb];

  Color toFlutterColor() {
    return Color(int.parse(rgb, radix: 16) + 0xFF000000);
  }
}