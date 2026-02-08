part of "shipments_bloc.dart";

abstract class ShipmentsState extends Equatable {
  @override
  List<Object?> get props => [];
}


class ShipmentsLoading extends ShipmentsState {}
class ShipmentsLoaded extends ShipmentsState {
  final List<ShipmentItemUi> items;
  final ShipmentType selectedType;
  final bool hasActiveFilters;

  ShipmentsLoaded({
    required this.items,
    required this.selectedType,
    required this.hasActiveFilters,
  });

  @override
  List<Object?> get props =>
      [items, selectedType, hasActiveFilters];
}
class ShipmentsError extends ShipmentsState {
  final String message;
  ShipmentsError(this.message);
  @override
  List<Object?> get props => [message];
}