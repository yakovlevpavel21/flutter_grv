import 'package:grv/features/product/data/models/variant_item.dart';
import 'package:grv/features/product/data/models/semi_stock_item.dart';

class ProductItemUi {
  final int id;
  final String name;
  final Map<int, VariantItemUi> variants;
  final Map<int, SemiStockItemUi> semiStocks;

  ProductItemUi({
    required this.id,
    required this.name,
    required this.variants,
    required this.semiStocks,
  });

  List<VariantItemUi> get variantsList => variants.values.toList();
  List<SemiStockItemUi> get semiStocksList => semiStocks.values.toList();
}