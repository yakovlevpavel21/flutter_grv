import 'package:equatable/equatable.dart';
import 'package:grv/data/dtos/stock.dart';

class StockShipmentDto extends Equatable {
  final int id;
  final int quantity;
  final StockDto stock;

  const StockShipmentDto({
    required this.id,
    required this.quantity,
    required this.stock,
  });

  factory StockShipmentDto.fromJson(Map<String, dynamic> json) {
    return StockShipmentDto(
      id: json['id'],
      quantity: json['quantity'],
      stock: StockDto.fromJson(json['stock']),
    );
  }


  @override
  List<Object?> get props => [id, quantity, stock];
}