import 'package:equatable/equatable.dart';
import 'package:grv/data/models/stock_invetory.dart';

class StockShipment extends Equatable {
  final int quantity;
  final StockInventory stock;

  const StockShipment({
    required this.quantity,
    required this.stock,
  });

  factory StockShipment.fromJson(Map<String, dynamic> json) {
    return StockShipment(
      quantity: json['quantity'],
      stock: StockInventory.fromJson(json['stock']),
    );
  }

  @override
  List<Object?> get props => [quantity, stock];
}