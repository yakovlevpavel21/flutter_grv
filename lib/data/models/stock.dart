import 'package:equatable/equatable.dart';
import 'package:grv/data/models/color.dart';

class Stock extends Equatable {
  final int built;
  final int packed;
  final ColorModel color;

  const Stock({
    required this.built,
    required this.packed,
    required this.color,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      built: json['built'],
      packed: json['packed'],
      color: ColorModel.fromJson(json['color']),
    );
  }

  @override
  List<Object?> get props => [built, packed, color];
}