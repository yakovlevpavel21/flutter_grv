import 'package:equatable/equatable.dart';
import 'package:grv/data/models/color.dart';

class SemiStock extends Equatable {
  final int quantity;
  final ColorModel color;

  const SemiStock({
    required this.quantity,
    required this.color,
  });

  @override
  List<Object?> get props => [quantity, color];
}