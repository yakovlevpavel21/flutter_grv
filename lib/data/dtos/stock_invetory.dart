import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/color.dart';
import 'package:grv/data/dtos/inventory_product.dart';

class StockDto extends Equatable {
  final ColorDto color;
  final InventoryProductDto inventory;

  const StockDto({
    required this.color,
    required this.inventory,
  });

  factory StockDto.fromJson(Map<String, dynamic> json) {
    return StockDto(
      color: ColorDto.fromJson(json['color']),
      inventory: InventoryProductDto.fromJson(json['inventory']),
    );
  }


  @override
  List<Object?> get props => [color, inventory];
}