import 'package:equatable/equatable.dart';
import 'package:grv/data/models/stock.dart';

class InventoryStocks extends Equatable {
  final String variant;
  final List<Stock> stocks;


  const InventoryStocks({
    required this.variant,
    required this.stocks,
  });


  factory InventoryStocks.fromJson(Map<String, dynamic> json) {
    return InventoryStocks(
      variant: json['variant'],
      stocks: (json['stocks'] as List<dynamic>)
          .map((e) => Stock.fromJson(e))
          .toList(),
    );
  }


  @override
  List<Object?> get props => [variant, stocks];
}