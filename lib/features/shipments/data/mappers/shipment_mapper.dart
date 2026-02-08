import 'package:grv/data/models/shipment.dart';
import 'package:grv/features/shipments/data/models/shipment_item.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';

extension ShipmentToShipmentUi on Shipment {
  ShipmentItemUi toShipmentUi() {
    return ShipmentItemUi(
      id: id,
      date: DateTime.parse(createdAt),
      type: type == 'shipment'
          ? ShipmentType.shipment
          : ShipmentType.comeback,
      shopName: shop.name,
      totalQuantity: stokShipments.fold(
        0,
        (sum, e) => sum + e.quantity,
      ),
      products: stokShipments.map((e) {
        return ShipmentProductUi(
          productName: e.stock.inventory.product.name,
          variant: e.stock.inventory.variant,
          color: e.stock.color.name,
          quantity: e.quantity,
        );
      }).toList(),
    );
  }
}