import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/domain/entities/stock_shipment_entity.dart';

abstract class ShipmentEditRepository {
  Future<void> createShipment({
    required DateTime createdAt,
    required int shopId,
    required ShipmentType type,
    required List<StockShipmentEntity> items
  });
  Future<void> deleteShipment({ required int id });
}