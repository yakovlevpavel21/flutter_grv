import 'package:grv/features/shipments/domain/entities/shipment_entity.dart';

abstract class ShipmentsRepository {
  Future<List<ShipmentEntity>> getShipments();
}