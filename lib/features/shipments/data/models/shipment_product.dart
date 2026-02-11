import 'package:equatable/equatable.dart';

class ShipmentProductUi extends Equatable {
  final int id;
  final String productName;
  final String variant;
  final String color;
  final int quantity;
  final int maxQuantity;

  const ShipmentProductUi({
    required this.id,
    required this.productName,
    required this.variant,
    required this.color,
    required this.quantity,
    required this.maxQuantity,
  });

  ShipmentProductUi copyWith({
    int? id,
    String? productName,
    String? variant,
    String? color,
    int? quantity,
    int? maxQuantity,
  }) {
    return ShipmentProductUi(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      variant: variant ?? this.variant,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
    );
  }

  @override
  List<Object?> get props =>
      [id, productName, variant, color, quantity, maxQuantity];
}