import 'package:equatable/equatable.dart';
import 'package:grv/data/models/stock_invetory.dart';

class StockShipment extends Equatable {
  final int id;
  final int quantity;
  final StockInventory stock;

  const StockShipment({
    required this.id,
    required this.quantity,
    required this.stock,
  });

  factory StockShipment.fromJson(Map<String, dynamic> json) {
    return StockShipment(
      id: json['id'],
      quantity: json['quantity'],
      stock: StockInventory.fromJson(json['stock']),
    );
  }

  @override
  List<Object?> get props => [id, quantity, stock];
}