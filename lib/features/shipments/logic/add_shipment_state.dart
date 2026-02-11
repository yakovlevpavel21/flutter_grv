part of "add_shipment_bloc.dart";


abstract class AddShipmentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddShipmentInitial extends AddShipmentState {
  final ShipmentType type;
  final DateTime dateTime;
  final ShopItemUi? shop;

  final List<ShipmentProductUi> items;

  final List<Shop> availableShops;

  final String? error;

  AddShipmentInitial({
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

  AddShipmentInitial copyWith({
    ShipmentType? type,
    DateTime? dateTime,
    ShopItemUi? shop,
    List<ShipmentProductUi>? items,
    List<Shop>? availableShops,
    String? error,
  }) {
    return AddShipmentInitial(
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      shop: shop ?? this.shop,
      items: items ?? this.items,
      availableShops: availableShops ?? this.availableShops,
      error: error,
    );
  }

  factory AddShipmentInitial.initial() {
    return AddShipmentInitial(
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
class AddShipmentLoading extends AddShipmentState {}
class AddShipmentSuccess extends AddShipmentState {}
class AddShipmentError extends AddShipmentState {
  final String message;
  AddShipmentError(this.message);

  @override
  List<Object?> get props => [message];
}