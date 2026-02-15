import 'package:equatable/equatable.dart';
import 'package:grv/data/models/variant_stocks.dart';
import 'package:grv/data/models/semi_stock.dart';

class ProductStocks extends Equatable {
  final int id;
  final String name;
  final List<VariantStocks> variants;
  final List<SemiStock> semiStocks;

  const ProductStocks({
    required this.id,
    required this.name,
    required this.variants,
    required this.semiStocks,
  });

  factory ProductStocks.fromJson(Map<String, dynamic> json) {
    return ProductStocks(
      id: json['id'],
      name: json['name'],
      variants: (json['variants'] as List<dynamic>)
          .map((e) => VariantStocks.fromJson(e))
          .toList(),
      semiStocks: (json['semi_stocks'] as List<dynamic>)
          .map((e) => SemiStock.fromJson(e))
          .toList(),
    );
  }
  @override
  List<Object?> get props => [id, name, variants, semiStocks];
}