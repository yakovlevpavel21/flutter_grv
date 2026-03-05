part of "shipment_edit_bloc.dart"; 

abstract class ShipmentEditEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShipmentTypeChanged extends ShipmentEditEvent {
  final ShipmentType type;

  ShipmentTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}
class ShipmentDateChanged extends ShipmentEditEvent {
  final DateTime dateTime;

  ShipmentDateChanged(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}
class ShipmentShopChanged extends ShipmentEditEvent {
  final ShopItemUi shop;

  ShipmentShopChanged(this.shop);

  @override
  List<Object?> get props => [shop];
}
class ShipmentProductAdded extends ShipmentEditEvent {
  final StockDetailsEntity item;

  ShipmentProductAdded(this.item);

  @override
  List<Object?> get props => [item];
}
class ShipmentProductRemoved extends ShipmentEditEvent {
  final int itemId;

  ShipmentProductRemoved(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
class ShipmentProductQuantityChanged extends ShipmentEditEvent {
  final int stockId;
  final int quantity;

  ShipmentProductQuantityChanged(this.stockId, this.quantity);

  @override
  List<Object?> get props => [stockId, quantity];
}
class ShipmentSubmitted extends ShipmentEditEvent {}
class ShipmentDeleted extends ShipmentEditEvent {
  final int id;

  ShipmentDeleted(this.id);

  @override
  List<Object?> get props => [id];
}