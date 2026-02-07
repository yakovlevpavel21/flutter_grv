part of "shipments_bloc.dart"; 

abstract class ShipmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadShipments extends ShipmentsEvent {}
class ChangeShipmentsStock extends ShipmentsEvent {
  final String ShipmentsId;
  final int amount;
  final String type;


  ChangeShipmentsStock(this.ShipmentsId, this.amount, this.type);


  @override
  List<Object?> get props => [ShipmentsId, amount, type];
}


class CreateShipments extends ShipmentsEvent {
  final String name;
  final String sku;
  final String? category;
  final String? description;

  CreateShipments({
    required this.name,
    required this.sku,
    this.category,
    this.description,
  });

  @override
  List<Object?> get props => [name, sku, category, description];
}


class UpdateShipments extends ShipmentsEvent {
  final String id;
  final String name;
  final String sku;
  final String? category;
  final String? description;

  UpdateShipments({
    required this.id,
    required this.name,
    required this.sku,
    this.category,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, sku, category, description];
}


class DeleteShipments extends ShipmentsEvent {
  final String id;

  DeleteShipments(this.id);

  @override
  List<Object?> get props => [id];
}