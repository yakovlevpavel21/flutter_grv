part of "shipment_bloc.dart";


abstract class ShipmentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShipmentInitial extends ShipmentState {
  final ShipmentType type;
  final DateTime dateTime;
  final ShopItemUi? shop;

  final List<ShipmentProductUi> items;

  final List<Shop> availableShops;

  final String? error;

  ShipmentInitial({
    required this.type,
    required this.dateTime,
    required this.shop,
    required this.items,
    required this.availableShops,
    this.error,
  });

  bool get canSubmit =>
      shop != null &&
      items.isNotEmpty;

  ShipmentInitial copyWith({
    ShipmentType? type,
    DateTime? dateTime,
    ShopItemUi? shop,
    List<ShipmentProductUi>? items,
    List<Shop>? availableShops,
    String? error,
  }) {
    return ShipmentInitial(
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      shop: shop ?? this.shop,
      items: items ?? this.items,
      availableShops: availableShops ?? this.availableShops,
      error: error,
    );
  }

  factory ShipmentInitial.initial() {
    return ShipmentInitial(
      type: ShipmentType.shipment,
      dateTime: DateTime.now(),
      shop: null,
      items: const [],
      availableShops: const [],
    );
  }

  @override
  List<Object?> get props => [
        type,
        dateTime,
        shop,
        items,
        availableShops,
        error,
      ];
}
class ShipmentLoading extends ShipmentState {}
class ShipmentSuccess extends ShipmentState {}
class ShipmentError extends ShipmentState {
  final String message;
  ShipmentError(this.message);

  @override
  List<Object?> get props => [message];
}