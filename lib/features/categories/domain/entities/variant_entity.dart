import 'package:grv/features/categories/domain/entities/stock_entity.dart';

class VariantEntity {
  final int id;
  final String name;
  final int partsConsumed;
  final Map<int, StockEntity> stocks;

  VariantEntity({
    required this.id,
    required this.name,
    required this.partsConsumed,
    required this.stocks,
  });

  VariantEntity copyWith({
    int? id,
    String? name,
    int? partsConsumed,
    Map<int, StockEntity>? stocks
  }) {
    return VariantEntity(
      id: id ?? this.id, 
      name: name ?? this.name, 
      partsConsumed: partsConsumed ?? this.partsConsumed, 
      stocks: stocks ?? this.stocks
    );
  }

  List<StockEntity> get stocksList => stocks.values.toList();
}