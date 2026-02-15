import 'package:equatable/equatable.dart';
import 'package:grv/data/models/stock.dart';

class VariantStocks extends Equatable {
  final int id;
  final String name;
  final int ratio;
  final List<Stock> stocks;


  const VariantStocks({
    required this.id,
    required this.name,
    required this.ratio,
    required this.stocks,
  });


  factory VariantStocks.fromJson(Map<String, dynamic> json) {
    return VariantStocks(
      id: json['id'],
      name: json['name'],
      ratio: json['ratio'],
      stocks: (json['stocks'] as List<dynamic>)
          .map((e) => Stock.fromJson(e))
          .toList(),
    );
  }


  @override
  List<Object?> get props => [id, name, ratio, stocks];
}