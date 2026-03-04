import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/data/models/stock_shipment_model.dart';
import 'package:grv/features/shipments/domain/entities/shipment_entity.dart';

class ShipmentModel extends ShipmentEntity {
  ShipmentModel({
    required super.id,
    required super.date,
    required super.type,
    required super.shopName,
    required super.stocks,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    final stocks = (json['stock_shipments'] as List? ?? [])
        .map((p) => StockShipmentModel.fromJson(p))
        .toList();
        
    return ShipmentModel(
      id: json['id'],
      date: DateTime.parse(json['created_at']),
      type: json['type'] == ShipmentType.shipment.name 
          ? ShipmentType.shipment 
          : ShipmentType.comeback,
      shopName: json['shop']['name'],
      stocks: stocks,
    );
  }
}