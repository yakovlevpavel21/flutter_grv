import 'package:equatable/equatable.dart';
import 'package:grv/data/models/stock.dart';

class InventoryStocks extends Equatable {
  final String variant;
  final List<Stock> stocks;

  const InventoryStocks({
    required this.variant,
    required this.stocks,
  });

  @override
  List<Object?> get props => [variant, stocks];
}