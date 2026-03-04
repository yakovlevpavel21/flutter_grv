part of "shipments_bloc.dart";

abstract class ShipmentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShipmentsLoading extends ShipmentsState {}
class ShipmentsLoaded extends ShipmentsState {
  final List<ShipmentEntity> items;
  final ShipmentType selectedType;
  final bool hasActiveFilters;

  ShipmentsLoaded({
    required this.items,
    required this.selectedType,
    required this.hasActiveFilters,
  });

  ShipmentsLoaded copyWith({
    List<ShipmentEntity>? items,
    ShipmentType? selectedType,
    bool? hasActiveFilters,
  }) {
    return ShipmentsLoaded(
      items: items ?? this.items, 
      selectedType: selectedType ?? this.selectedType, 
      hasActiveFilters: hasActiveFilters ?? this.hasActiveFilters,
    );
  }
  @override
  List<Object?> get props => [items, selectedType, hasActiveFilters];
}
class ShipmentsError extends ShipmentsState {
  final String message;
  ShipmentsError(this.message);
  @override
  List<Object?> get props => [message];
}