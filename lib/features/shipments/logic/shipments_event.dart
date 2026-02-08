part of "shipments_bloc.dart"; 

abstract class ShipmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadShipments extends ShipmentsEvent {}
class ShipmentsTypeChanged extends ShipmentsEvent {
  final ShipmentType type;

  ShipmentsTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}