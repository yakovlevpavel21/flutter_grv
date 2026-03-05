part of "shipments_bloc.dart";

abstract class ShipmentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShipmentsLoading extends ShipmentsState {}
class ShipmentsLoaded extends ShipmentsState {
  final List<ShipmentEntity> items;
  final ShipmentType selectedType;
  final List<int> selectedShopIds;

  ShipmentsLoaded({
    required this.items,
    required this.selectedType,
    required this.selectedShopIds,
  });

  bool get hasActiveFilters => selectedShopIds.isNotEmpty;

  ShipmentsLoaded copyWith({
    List<ShipmentEntity>? items,
    ShipmentType? selectedType,
    List<int>? selectedShopIds,
  }) {
    return ShipmentsLoaded(
      items: items ?? this.items, 
      selectedType: selectedType ?? this.selectedType, 
      selectedShopIds: selectedShopIds ?? this.selectedShopIds,
    );
  }
  @override
  List<Object?> get props => [
    items, 
    selectedType, 
    hasActiveFilters, 
    selectedShopIds
  ];
}
class ShipmentsError extends ShipmentsState {
  final String message;
  ShipmentsError(this.message);
  @override
  List<Object?> get props => [message];
}