import 'package:grv/features/categories/domain/entities/stock_entity.dart';
import 'package:grv/features/categories/domain/entities/variant_entity.dart';

class ProductEntity {
  final int id;
  final String name;
  final Map<int, VariantEntity> variants;
  final Map<int, StockEntity> stocks;

  ProductEntity({
    required this.id,
    required this.name,
    required this.variants,
    required this.stocks,
  });

  ProductEntity copyWith({
    int? id,
    String? name,
    Map<int, VariantEntity>? variants,
    Map<int, StockEntity>? stocks
  }) {
    return ProductEntity(
      id: id ?? this.id, 
      name: name ?? this.name, 
      variants: variants ?? this.variants,
      stocks: stocks ?? this.stocks
    );
  }

  List<VariantEntity> get variantsList => variants.values.toList();
  List<StockEntity> get stocksList => stocks.values.toList();
}