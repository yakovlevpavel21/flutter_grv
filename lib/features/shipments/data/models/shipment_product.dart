import 'package:equatable/equatable.dart';

class ShipmentProductUi extends Equatable {
  final String productName;
  final String variant;
  final String color;
  final int quantity;

  const ShipmentProductUi({
    required this.productName,
    required this.variant,
    required this.color,
    required this.quantity,
  });

  @override
  List<Object?> get props =>
      [productName, variant, color, quantity];
}