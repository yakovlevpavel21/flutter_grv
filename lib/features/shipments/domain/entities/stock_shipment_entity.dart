import 'package:grv/features/shipments/domain/entities/stock_details_entity.dart';

class StockShipmentEntity {
  final int? id;
  final StockDetailsEntity stock;
  final int quantity;

  const StockShipmentEntity({
    this.id,
    required this.stock,
    required this.quantity,
  });

  StockShipmentEntity copyWith({
    int? id,
    StockDetailsEntity? stock,
    int? quantity,
  }) {
    return StockShipmentEntity(
      id: id ?? this.id,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
    );
  }
}