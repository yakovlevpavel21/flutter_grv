import 'package:grv/features/shipments/data/models/stock_details_model.dart';
import 'package:grv/features/shipments/domain/entities/stock_shipment_entity.dart';

class StockShipmentModel extends StockShipmentEntity {
  StockShipmentModel({
    required super.id,
    required super.stock,
    required super.quantity,
  });

  factory StockShipmentModel.fromJson(Map<String, dynamic> json) {
    return StockShipmentModel(
      id: json['id'],
      stock: StockDetailsModel.fromJson(json['stock']),
      quantity: json['quantity'],
    );
  }
}