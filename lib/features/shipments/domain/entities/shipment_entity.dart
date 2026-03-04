import 'package:grv/features/shipments/data/enums/shipment_type.dart';
import 'package:grv/features/shipments/domain/entities/stock_shipment_entity.dart';

class ShipmentEntity {
  final int id;
  final DateTime date;
  final ShipmentType type;
  final String shopName;
  final List<StockShipmentEntity> stocks;

  int get totalQuantity => 
      stocks.fold(0, (sum, item) => sum + item.quantity);

  const ShipmentEntity({
    required this.id,
    required this.date,
    required this.type,
    required this.shopName,
    required this.stocks,
  });
}