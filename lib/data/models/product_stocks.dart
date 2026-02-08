import 'package:equatable/equatable.dart';
import 'package:grv/data/models/inventory_stocks.dart';
import 'package:grv/data/models/semi_stock.dart';

class ProductStocks extends Equatable {
  final String name;
  final List<InventoryStocks> inventories;
  final List<SemiStock> semiStocks;

  const ProductStocks({
    required this.name,
    required this.inventories,
    required this.semiStocks,
  });

  factory ProductStocks.fromJson(Map<String, dynamic> json) {
    return ProductStocks(
      name: json['name'],
      inventories: (json['inventories'] as List<dynamic>)
          .map((e) => InventoryStocks.fromJson(e))
          .toList(),
      semiStocks: (json['semi_stocks'] as List<dynamic>)
          .map((e) => SemiStock.fromJson(e))
          .toList(),
    );
  }
  @override
  List<Object?> get props => [name, inventories, semiStocks];
}