part of "shipment_bloc.dart"; 

abstract class ShipmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShipmentTypeChanged extends ShipmentEvent {
  final ShipmentType type;

  ShipmentTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}
class ShipmentDateChanged extends ShipmentEvent {
  final DateTime dateTime;

  ShipmentDateChanged(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}
class ShipmentShopChanged extends ShipmentEvent {
  final ShopItemUi shop;

  ShipmentShopChanged(this.shop);

  @override
  List<Object?> get props => [shop];
}
class ShipmentProductsAdded extends ShipmentEvent {
  final List<ShipmentProductUi> items;

  ShipmentProductsAdded(this.items);

  @override
  List<Object?> get props => [items];
}
class ShipmentProductRemoved extends ShipmentEvent {
  final ShipmentProductUi item;

  ShipmentProductRemoved(this.item);

  @override
  List<Object?> get props => [item];
}
class ShipmentProductQuantityChanged extends ShipmentEvent {
  final ShipmentProductUi item;
  final int quantity;

  ShipmentProductQuantityChanged(this.item, this.quantity);

  @override
  List<Object?> get props => [item, quantity];
}
class ShipmentSubmitted extends ShipmentEvent {}