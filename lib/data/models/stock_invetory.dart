import 'package:equatable/equatable.dart';
import 'package:grv/data/models/color.dart';
import 'package:grv/data/models/inventory_product.dart';

class StockInventory extends Equatable {
  final int id;
  final ColorModel color;
  final InventoryProduct inventory;

  const StockInventory({
    required this.id,
    required this.color,
    required this.inventory,
  });

  factory StockInventory.fromJson(Map<String, dynamic> json) {
    return StockInventory(
      id: json['id'],
      color: ColorModel.fromJson(json['color']),
      inventory: InventoryProduct.fromJson(json['inventory']),
    );
  }

  @override
  List<Object?> get props => [id, color, inventory];
}