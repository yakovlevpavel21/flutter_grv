import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/color.dart';

class SemiStockDto extends Equatable {
  final int quantity;
  final ColorDto color;


  const SemiStockDto({
    required this.quantity,
    required this.color,
  });


  factory SemiStockDto.fromJson(Map<String, dynamic> json) {
    return SemiStockDto(
      quantity: json['quantity'],
      color: ColorDto.fromJson(json['color']),
    );
  }


  @override
  List<Object?> get props => [quantity, color];
}