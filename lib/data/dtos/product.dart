import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/inventory.dart';
import 'package:grv/data/dtos/semi_stock.dart';

class ProductDto extends Equatable {
  final String name;
  final List<InventoryDto> inventories;
  final List<SemiStockDto> semiStocks;


  const ProductDto({
    required this.name,
    required this.inventories,
    required this.semiStocks,
  });


  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      name: json['name'],
      inventories: (json['inventories'] as List<dynamic>)
          .map((e) => InventoryDto.fromJson(e))
          .toList(),
      semiStocks: (json['semi_stocks'] as List<dynamic>)
          .map((e) => SemiStockDto.fromJson(e))
          .toList(),
    );
  }


  @override
  List<Object?> get props => [name, inventories, semiStocks];
}