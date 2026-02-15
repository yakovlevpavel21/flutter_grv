import 'package:equatable/equatable.dart';
import 'package:grv/data/models/color.dart';

class SemiStock extends Equatable {
  final int id;
  final int quantity;
  final ColorModel color;

  const SemiStock({
    required this.id,
    required this.quantity,
    required this.color,
  });

  factory SemiStock.fromJson(Map<String, dynamic> json) {
    return SemiStock(
      id: json['id'],
      quantity: json['quantity'],
      color: ColorModel.fromJson(json['color']),
    );
  }

  @override
  List<Object?> get props => [id, quantity, color];
}