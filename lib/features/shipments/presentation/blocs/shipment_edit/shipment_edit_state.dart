part of "shipment_edit_bloc.dart";

enum ShipmentEditStatus { initial, loading, success, error }

class ShipmentEditInitial extends Equatable {
  final int? id;
  final ShipmentType type;
  final DateTime dateTime;
  final ShopItemUi? shop;
  final List<StockShipmentEntity> items;
  final List<Shop> availableShops;
  final ShipmentEditStatus status;
  final String? errorMessage;

  const ShipmentEditInitial({
    this.id,
    required this.type,
    required this.dateTime,
    required this.shop,
    required this.items,
    required this.availableShops,
    required this.status,
    this.errorMessage,
  });

  bool get canSubmit =>
      shop != null &&
      items.isNotEmpty;

  ShipmentEditInitial copyWith({
    int? id,
    ShipmentType? type,
    DateTime? dateTime,
    ShopItemUi? shop,
    List<StockShipmentEntity>? items,
    List<Shop>? availableShops,
    ShipmentEditStatus? status,
    String? errorMessage,
  }) {
    return ShipmentEditInitial(
      id: id ?? this.id,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      shop: shop ?? this.shop,
      items: items ?? this.items,
      availableShops: availableShops ?? this.availableShops,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory ShipmentEditInitial.initial() {
    return ShipmentEditInitial(
      type: ShipmentType.shipment,
      dateTime: DateTime.now(),
      shop: null,
      items: const [],
      availableShops: const [],
      status: ShipmentEditStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        dateTime,
        shop,
        items,
        availableShops,
        status,
        errorMessage
      ];
}