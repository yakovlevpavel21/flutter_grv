import 'package:grv/features/variant/data/models/stock_item.dart';

class VariantItemUi {
  final int id;
  final String name;
  final int ratio;
  final Map<int, StockItemUi> stocks;

  VariantItemUi({
    required this.id,
    required this.name,
    required this.ratio,
    required this.stocks,
  });

  List<StockItemUi> get stocksList => stocks.values.toList();
}