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

  @override
  List<Object?> get props => [built, packed, color];
}