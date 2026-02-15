import 'package:equatable/equatable.dart';
import 'package:grv/data/models/stock_variant.dart';

class StockShipment extends Equatable {
  final int quantity;
  final StockVariant stock;

  const StockShipment({
    required this.quantity,
    required this.stock,
  });

  factory StockShipment.fromJson(Map<String, dynamic> json) {
    return StockShipment(
      quantity: json['quantity'],
      stock: StockVariant.fromJson(json['stock']),
    );
  }

  @override
  List<Object?> get props => [quantity, stock];
}