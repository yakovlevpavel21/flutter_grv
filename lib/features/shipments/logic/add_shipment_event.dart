part of "add_shipment_bloc.dart"; 

abstract class AddShipmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShipmentTypeChanged extends AddShipmentEvent {
  final ShipmentType type;

  ShipmentTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}
class ShipmentDateChanged extends AddShipmentEvent {
  final DateTime dateTime;

  ShipmentDateChanged(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}
class ShipmentShopChanged extends AddShipmentEvent {
  final ShopItemUi shop;

  ShipmentShopChanged(this.shop);

  @override
  List<Object?> get props => [shop];
}
class ShipmentProductsAdded extends AddShipmentEvent {
  final List<ShipmentProductUi> items;

  ShipmentProductsAdded(this.items);

  @override
  List<Object?> get props => [items];
}
class ShipmentProductRemoved extends AddShipmentEvent {
  final ShipmentProductUi item;

  ShipmentProductRemoved(this.item);

  @override
  List<Object?> get props => [item];
}
class ShipmentProductQuantityChanged extends AddShipmentEvent {
  final ShipmentProductUi item;
  final int quantity;

  ShipmentProductQuantityChanged(this.item, this.quantity);

  @override
  List<Object?> get props => [item, quantity];
}
class ShipmentSubmitted extends AddShipmentEvent {}