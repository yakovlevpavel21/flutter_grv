
//extension ShipmentToShipmentUi on Shipment {
//  ShipmentEntity toShipmentUi() {
//    return ShipmentEntity(
//      id: id,
//      date: DateTime.parse(createdAt),
//      type: type == 'shipment'
//          ? ShipmentType.shipment
//          : ShipmentType.comeback,
//      shopName: shop.name,
//      totalQuantity: stokShipments.fold(
//        0,
//        (sum, e) => sum + e.quantity,
//      ),
//      products: stokShipments.map((e) {
//        return StockShipmentEntity(
//          id: e.stock.id,
//          productName: e.stock.variant.product.name,
//          variant: e.stock.variant.variant,
//          color: e.stock.color.name,
//          quantity: e.quantity,
//          maxQuantity: e.quantity
//        );
//      }).toList(),
//    );
//  }
//}