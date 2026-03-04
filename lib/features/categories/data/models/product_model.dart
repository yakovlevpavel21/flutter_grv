import 'package:grv/features/categories/data/models/stock_model.dart';
import 'package:grv/features/categories/data/models/variant_model.dart';
import 'package:grv/features/categories/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id, 
    required super.name, 
    required super.variants,
    required super.stocks,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final variantsList = (json['variants'] as List? ?? [])
        .map((v) => VariantModel.fromJson(v))
        .toList();

    final stocksList = (json['stocks'] as List? ?? [])
        .map((v) => StockModel.fromJson(v))
        .toList();

    return ProductModel(
      id: json['id'],
      name: json['name'],
      variants: {for (var v in variantsList) v.id: v},
      stocks: {for (var s in stocksList) s.id: s},
    );
  }
}