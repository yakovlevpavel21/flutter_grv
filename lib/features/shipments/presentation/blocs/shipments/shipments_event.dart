part of "shipments_bloc.dart"; 

abstract class ShipmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadShipments extends ShipmentsEvent {
  LoadShipments({this.completer});

  final Completer? completer;
}
class ShipmentsTypeChanged extends ShipmentsEvent {
  final ShipmentType type;

  ShipmentsTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}
class ShipmentsFilterShopAdded extends ShipmentsEvent {
  final int shopId;

  ShipmentsFilterShopAdded(this.shopId);

  @override
  List<Object?> get props => [shopId];
}
class ShipmentsFilterShopRemoved extends ShipmentsEvent {
  final int shopId;

  ShipmentsFilterShopRemoved(this.shopId);

  @override
  List<Object?> get props => [shopId];
}