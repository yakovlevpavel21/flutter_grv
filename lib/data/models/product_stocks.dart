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

  @override
  List<Object?> get props => [name, inventories, semiStocks];
}