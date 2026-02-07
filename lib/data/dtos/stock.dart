import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/color.dart';

class StockDto extends Equatable {
  final int built;
  final int packed;
  final ColorDto color;

  const StockDto({
    required this.built,
    required this.packed,
    required this.color,
  });

  factory StockDto.fromJson(Map<String, dynamic> json) {
    return StockDto(
      built: json['built'],
      packed: json['packed'],
      color: ColorDto.fromJson(json['color']),
    );
  }


  @override
  List<Object?> get props => [built, packed, color];
}