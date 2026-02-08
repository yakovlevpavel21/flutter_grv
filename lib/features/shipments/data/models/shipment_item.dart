import 'package:equatable/equatable.dart';
import 'package:grv/features/shipments/data/models/shipment_product.dart';
import 'package:grv/features/shipments/data/enums/shipment_type.dart';

class ShipmentItemUi extends Equatable {
  final String id;
  final DateTime date;
  final ShipmentType type;
  final String shopName;
  final int totalQuantity;
  final List<ShipmentProductUi> products;

  const ShipmentItemUi({
    required this.id,
    required this.date,
    required this.type,
    required this.shopName,
    required this.totalQuantity,
    required this.products,
  });

  @override
  List<Object?> get props =>
      [id, date, type, shopName, totalQuantity, products];
}